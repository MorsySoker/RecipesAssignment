//
//  ImageService.swift
//  RecipesAssignment
//
//  Created by MorsyElsokary on 13/10/2022.
//

import Foundation
import Kingfisher
import UIKit

protocol ImageServiceProtocol: AnyObject {
    
    func loadImage(with urlString: String, compeletion: @escaping (Result<UIImage, Error>) -> Void) -> UUID?
    func cancelTask(_ taskIdentifier: UUID)
}

final class ImageService: ImageServiceProtocol {
    
    var loadedImages = [URL: UIImage]()
    var runningDownloadTasks = [UUID: DownloadTask]()
    let taskIdentifier = UUID()
    let fisher = KingfisherManager.shared
    
    func loadImage(with urlString: String, compeletion: @escaping (Result<UIImage, Error>) -> Void) -> UUID? {
        
        guard let url = URL(string: urlString) else { return nil }
        
        if let image = loadedImages[url] {
            compeletion(.success(image))
            return nil
        }
        
        let downloadTask = fisher.retrieveImage(with: url,
                                        options: nil,
                                        progressBlock: nil,
                                        downloadTaskUpdated: nil)
        { [weak self] result in
            
            defer {self?.runningDownloadTasks.removeValue(forKey: self!.taskIdentifier)}
            
            switch result {
            case .success(let result):
                self?.onSuccess(image: result.image, url: result.originalSource.url!)
                compeletion(.success(result.image))
            case .failure(let error):
                self?.onFail(error: error)
            }
        }
        
        runningDownloadTasks[taskIdentifier] = downloadTask
        return taskIdentifier
    }
    
    
    private func onSuccess(image: UIImage, url: URL) {
        loadedImages[url] = image
    }
    
    private func onFail(error: KingfisherError) {
        if error.isTaskCancelled {
            print("Task is Cancled")
        }
    }
    
    func cancelTask(_ taskIdentifier: UUID) {
        runningDownloadTasks[taskIdentifier]?.cancel()
        runningDownloadTasks.removeValue(forKey: taskIdentifier)
        print("Task is Cancled")
    }
}
