//
//  HealthFilterCell.swift
//  RecipesAssignment
//
//  Created by MorsyElsokary on 27/08/2022.
//

import UIKit

class HealthFilterCell: UICollectionViewCell {
    
    // MARK: - Views
    
     lazy var healthLbl: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.textAlignment = .center
        lbl.textColor = UIColor(red: 0.371, green: 0.371, blue: 0.371, alpha: 1)
        lbl.font = UIFont(name: "Georgia", size: 15)
        lbl.numberOfLines = 1
        return lbl
    }()
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HealthFilterCell: ViewCodeConfiguration {
    func buildHierarchy() {
        contentView.addSubview(healthLbl)
    }
    
    func setupConstraints() {
        healthLbl.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func configureViews() {
        contentView.backgroundColor = .white
        contentView.setBorder()
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds =  true
    }
}
