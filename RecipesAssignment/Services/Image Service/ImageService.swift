//
//  ImageService.swift
//  RecipesAssignment
//
//  Created by MorsyElsokary on 13/10/2022.
//

import Kingfisher
import UIKit

protocol ImageServiceProtocol: AnyObject {
    func loadImage(with urlString: String, completion: @escaping (Result<UIImage, Error>) -> Void) -> UUID?
    func cancelTask(_ taskIdentifier: UUID)
}

final class ImageService: ImageServiceProtocol {
    
    static let shared = ImageService()
    private let fisher = KingfisherManager.shared
    private var cache: ImageCache {
        let cache = ImageCache.default
        // Limit memory cache size to 75 MB.
        cache.memoryStorage.config.totalCostLimit = 75 * 1024 * 1024
        
        // Limit memory cache to hold 150 images at most.
        cache.memoryStorage.config.countLimit = 150
        return cache
    }
    
    private  var runningDownloadTasks = [UUID: DownloadTask]()
    private let taskIdentifier = UUID()
    private var placeHolderImage = UIImage(named: "Image")!
    
    
    func loadImage(with urlString: String, completion: @escaping (Result<UIImage, Error>) -> Void) -> UUID? {
        
        guard let url = URL(string: urlString) else { return nil }
        
        completion(.success(placeHolderImage))
        
        if cache.isCached(forKey: urlString) {
            cache.retrieveImage(forKey: urlString, options: nil)
            { result in
                switch result {
                case .success(let result):
                    if let image = result.image {
                        completion(.success(image))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
            return nil
        }
        
        let downloadTask = fisher.retrieveImage(with: url)
        { [weak self] result in
            
            defer { self?.runningDownloadTasks.removeValue(forKey: self!.taskIdentifier) }
            
            switch result {
            case .success(let result):
                completion(.success(result.image))
            case .failure(let error):
                completion(.failure(error))
                
            }
        }
        
        runningDownloadTasks[taskIdentifier] = downloadTask
        return taskIdentifier
    }
    
    func cancelTask(_ taskIdentifier: UUID) {
        runningDownloadTasks[taskIdentifier]?.cancel()
        runningDownloadTasks.removeValue(forKey: taskIdentifier)
    }
    
    func clearMemoryCache() {
        cache.clearMemoryCache()
    }
}
