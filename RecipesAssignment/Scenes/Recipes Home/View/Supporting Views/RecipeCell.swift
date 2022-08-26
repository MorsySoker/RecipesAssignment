//
//  RecipeCell.swift
//  RecipesAssignment
//
//  Created by MorsyElsokary on 24/08/2022.
//

import UIKit

class RecipeCell: UITableViewCell {
    
    // MARK: - Views
    
    private lazy var recipeImage: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 8
        image.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        image.image = UIImage(named: "Image")
        return image
    }()
    
    private lazy var recipeTitleLbl: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.textAlignment = .left
        lbl.textColor = UIColor(red: 0.371, green: 0.371, blue: 0.371, alpha: 1)
        lbl.text = "Green tea noodles with sticky sweet chilli salmon"
        lbl.font = UIFont(name: "Georgia", size: 16)
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        return lbl
    }()
    
    private lazy var recipeSourceLbl: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.textAlignment = .left
        lbl.textColor = UIColor(red: 0.371, green: 0.371, blue: 0.371, alpha: 1)
        lbl.text = " 120 Cal"
        lbl.font = UIFont(name: "Georgia", size: 15)
        lbl.numberOfLines = 1
        return lbl
    }()
    
    private lazy var recipeHealthLbl: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.textAlignment = .left
        lbl.textColor = UIColor(red: 0.371, green: 0.371, blue: 0.371, alpha: 1)
        lbl.text = "20 Minutes"
        lbl.font = UIFont(name: "Georgia", size: 15)
        lbl.numberOfLines = 1
        return lbl
    }()
    
    private lazy var recipeLblsStackContainer: UIStackView = {
        let stack = UIStackView(
            arrangedSubviews: [
                recipeTitleLbl,
                recipeSourceLbl,
                recipeHealthLbl])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fillProportionally
        stack.spacing = 5
        return stack
    }()
    
    private lazy var containerStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [recipeImage, recipeLblsStackContainer])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 15
        stack.layer.cornerRadius = 8
        stack.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        stack.backgroundColor = .white
        stack.clipsToBounds = true
        stack.addShadow(color: .white, alpha: 0.09, xValue: 0, yValue: 2, blur: 20)
        return stack
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
    
    // Methods
    
    func configure(with recipe: RecipeCellViewModel) {
        
        recipeImage.setImage(with: recipe.imageLink)
        recipeImage.layer.cornerRadius = 8
        recipeImage.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        recipeTitleLbl.text = recipe.title
        recipeSourceLbl.text = recipe.source
        recipeHealthLbl.text = recipe.healthLabels
    }
}

// MARK: - Setup Views

extension RecipeCell: ViewCodeConfiguration {
    
    func buildHierarchy() {
        
        //        contentView.addSubview(containerStackView)
        contentView.addSubview(recipeImage)
        contentView.addSubview(recipeLblsStackContainer)
        
    }
    
    func setupConstraints() {
        
        recipeImage.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.37535809018)
            make.height.equalTo(105)
            make.top.bottom.equalToSuperview().inset(5)
            make.leading.equalToSuperview().offset(10)
        }
        
        recipeLblsStackContainer.snp.makeConstraints { make in
            make.leading.equalTo(recipeImage.snp.trailing).offset(5)
            make.trailing.top.bottom.equalToSuperview()
            make.height.equalTo(115)
        }
        
        //        containerStackView.snp.makeConstraints { make in
        //            make.leading.trailing.equalToSuperview().inset(25)
        //            make.bottom.top.equalToSuperview().inset(12)
        //        }
        //
        //        recipeImage.snp.makeConstraints { make in
        //            make.leading.trailing.bottom.equalToSuperview()
        //            make.width.equalToSuperview().multipliedBy(0.30)
        //            make.height.equalToSuperview()
        //        }
    }
}
