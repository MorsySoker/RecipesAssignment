//
//  UIImageView+extension.swift
//  POMacArch
//
//  Created by Mohamed gamal on 05/05/2021.
//  Copyright © 2021 POMac. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    
    func setImage(with urlString: String) {
        let url = URL(string: urlString)
        self.kf.setImage(
            with: url,
            placeholder: #imageLiteral(resourceName: "Image"),
            options: [.transition(.fade(0.5))],
            progressBlock: nil,
            completionHandler: { [weak self](result) in
                switch result {
                case .failure:
                    self?.image =  #imageLiteral(resourceName: "student")
                default:
                    break
                }
            })
    }
}
