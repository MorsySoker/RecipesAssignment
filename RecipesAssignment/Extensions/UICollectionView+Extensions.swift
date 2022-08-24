//
//  UICollectionView+Extensions.swift
//  TMDB-MVVM
//
//  Created by MorsyElsokary on 30/07/2022.
//

import UIKit

extension UICollectionView {
    
    func register<T: UICollectionViewCell>(cellType: T.Type) {
        let nib = UINib(nibName: cellType.identifier, bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: cellType.identifier)
    }
}
