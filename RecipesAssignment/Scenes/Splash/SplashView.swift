//
//  SplashView.swift
//  RecipesAssignment
//
//  Created by MorsyElsokary on 24/08/2022.
//

import Lottie

class SplashView: BaseViewController {
    
    // MARK: - Views
    
    private lazy var lottieView: AnimationView = {
        let view = AnimationView()
        let animation = Animation.named("food")
        view.animation = animation
        view.play()
        return view
    }()

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyViewCode()
        
        lottieView.play { [weak self] _ in
            self?.navigationController?.pushViewController(
                SearchRecipeConfigurator.configured(),
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

