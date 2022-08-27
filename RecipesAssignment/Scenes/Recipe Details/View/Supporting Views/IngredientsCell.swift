//
//  IngredientsCell.swift
//  RecipesAssignment
//
//  Created by MorsyElsokary on 27/08/2022.
//

import UIKit

class IngredientsCell: UITableViewCell {

    // MARK: - Views
    
    lazy var ingredientLbl: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.textAlignment = .center
        lbl.textColor = UIColor(red: 0.371, green: 0.371, blue: 0.371, alpha: 1)
        lbl.font = UIFont(name: "Georgia", size: 16)
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        return lbl
    }()
    
    // MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(named: "background")
        applyViewCode()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup ViewCode
extension IngredientsCell: ViewCodeConfiguration {
    
    func buildHierarchy() {
        contentView.addSubview(ingredientLbl)
    }
    
    func setupConstraints() {
        ingredientLbl.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
