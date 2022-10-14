//
//  SplashView.swift
//  RecipesAssignment
//
//  Created by MorsyElsokary on 24/08/2022.
//

import Lottie
import UIKit

enum SplashViewLottieFilesKeys: String {
    
    case food
}

class SplashView: BaseViewController {
    
    // MARK: - Views
    
    private lazy var lottieView: LottieAnimationView = {
        let view = LottieAnimationView()
        let animation = LottieAnimation.named(SplashViewLottieFilesKeys.food.rawValue)
        view.animation = animation
        view.play()
        return view
    }()
    
    var viewAfterSplash: SearchRecipesView = SearchRecipeConfigurator.configured()

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyViewCode()
        lottieView.play { [weak self] _ in
            self?.navigationController?.pushViewController(
                self!.viewAfterSplash,
                animated: true)
        }
    }
}

// MARK: - Configure Views

extension SplashView: ViewCodeConfiguration {
    
    func buildHierarchy() {
        view.addSubview(lottieView)
    }
    
    func setupConstraints() {
        lottieView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.edges.equalToSuperview()
        }
    }
}

extension SplashView {
    func applicationDidEnterBackground(_ application: UIApplication) {
        // save searchSuggestions before app closed
        viewAfterSplash.interactor?.saveSearchSuggestions()
    }
}

