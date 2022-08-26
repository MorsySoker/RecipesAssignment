//
//  RecipeCardCell.swift
//  RecipesAssignment
//
//  Created by MorsyElsokary on 25/08/2022.
//

import UIKit

class RecipeCardCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var recipeImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var sourceLabel: UILabel!
    @IBOutlet private weak var healthLabel: UILabel!
    
    // MARK: - Awake From nib

    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
    }

    // MARK: - Methods
    
    func configure(_ recipe: RecipeCellViewModel)
    {
       recipeImage.setImage(with: recipe.imageLink)
        titleLabel.text = recipe.title
        sourceLabel.text = recipe.source
        healthLabel.text = recipe.healthLabels
    }
    
    private func setupViews() {
        contentView.backgroundColor = .red
        recipeImage.layer.cornerRadius = 8
        recipeImage.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        recipeImage.clipsToBounds = true
    }
}
