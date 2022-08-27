//
//  RecipeDetailView.swift
//  RecipesAssignment
//
//  Created by MorsyElsokary on 27/08/2022.
//

import UIKit

protocol RecipeDetailViewInput: AnyObject {
    
    func getSelectedRecipeDetails()
    func goToRecipeWebsite()
    func shareRecipe()
}

protocol RecipeDetailViewOutput: AnyObject {
    
    func displayRecipeDetails(_ recipe: DetailedRecipeViewModel)
    func openRecipeWebsite(with url: URL)
    func shareRecipe(with url: URL)
}

final class RecipeDetailView: BaseViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var headerView: UIView!
    @IBOutlet private weak var recipeTitleLbl: UILabel!
    @IBOutlet private weak var recipeImage: UIImageView!
    @IBOutlet private weak var recipeingredientTableView: UITableView!
    @IBOutlet private weak var directToWebBtn: UIButton!
    
    // MARK: - Properties
    
    var recipeDetails: DetailedRecipeViewModel?
    var interactor: RecipeDetailViewInput?
    var router: RecipeDetailRouter?
    
    // MARK: - view Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        interactor?.getSelectedRecipeDetails()
    }
    
    // MARK: - Methods
    
    private func setupViews() {
        
        headerView.layer.cornerRadius = 8
        headerView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        headerView.clipsToBounds = true
        
        directToWebBtn.layer.cornerRadius = 8
        directToWebBtn.clipsToBounds = true
        
        setupTableView()
    }
    
    private func setupTableView() {
        
        recipeingredientTableView.layer.cornerRadius = 8
        recipeingredientTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        recipeingredientTableView.clipsToBounds = true
        recipeingredientTableView.register(IngredientsCell.self,
                                           forCellReuseIdentifier: IngredientsCell.identifier)
        recipeingredientTableView.dataSource = self
        recipeingredientTableView.delegate = self
    }
    
    private func refreshTableView() {
        
        recipeingredientTableView.reloadData()
    }
    
    // MARK: - Actions
    
    @IBAction private func popView() {
        router?.popToSearchRecipe()
    }
    
    @IBAction private func shareRecipe() {
        
        interactor?.shareRecipe()
    }
    
    @IBAction private func goToRecipeWebsite() {
        
        interactor?.goToRecipeWebsite()
    }
}

// MARK: - TableView DataSource

extension RecipeDetailView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let recipe = recipeDetails {
           return recipe.ingredients.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let ingredientsCell = tableView.dequeueReusableCell(
            withIdentifier: IngredientsCell.identifier,
            for: indexPath) as? IngredientsCell else {
            fatalError("Couldn't Find Cell!")
        }
        
        if let recipe = recipeDetails {
            let ingredient = recipe.ingredients[indexPath.row]
            ingredientsCell.ingredientLbl.text = ingredient
        }
        
        return ingredientsCell
    }
}

// MARK: - TableView Delegate

extension RecipeDetailView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        view.layoutIfNeeded()
    }
}

// MARK: - View input Protocol Confrimation

extension RecipeDetailView: RecipeDetailViewOutput {
    
    func displayRecipeDetails(_ recipe: DetailedRecipeViewModel) {
        recipeDetails = recipe
        recipeImage.setImage(with: recipe.imageLink)
        recipeTitleLbl.text = recipe.title
        refreshTableView()
    }
    
    func openRecipeWebsite(with url: URL) {
        
        UIApplication.shared.open(url)
    }
    
    func shareRecipe(with url: URL) {
        let itemsToShare = [url]
        let ac = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)
        present(ac, animated: true)
    }
}
