//
//  ViewCodeConfiguration.swift
//  TMDB-MVVM
//
//  Created by MorsyElsokary on 17/08/2022.
//

import Foundation

protocol ViewCodeConfiguration {
    
    func buildHierarchy()
    func setupConstraints()
    func configureViews()
}

extension ViewCodeConfiguration {
    
    func configureViews() {}
    
    func applyViewCode() {
        
        buildHierarchy()
        setupConstraints()
        configureViews()
    }
}
