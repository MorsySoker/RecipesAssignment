//
//  RecipesView.swift
//  RecipesAssignment
//
//  Created by MorsyElsokary on 24/08/2022.
//

import UIKit

protocol SearchRecipesViewProtocol: AnyObject {
    
    var interactor: SearchRecipesInteractorProtocol? { get set }
    
    func displaySearchOrFilterResults(_ recipes: [RecipeCellViewModel])
}

class SearchRecipesView: BaseViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var recipesTableView: UITableView!
    @IBOutlet private weak var headerView: UIView!
    @IBOutlet private weak var recipesSearchBar: UISearchBar!
    
    // MARK: - Properties
    
    lazy var searchResults: [RecipeCellViewModel] = [RecipeCellViewModel]()
    var interactor: SearchRecipesInteractorProtocol?
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setup()
    }
    
    // MARK: - Methods
    
    private func setup() {
//        setupViews()
        interactor?.search(WithKeyowrd: "chicken")
    }
    
    private func setupViews() {
        headerView.layer.cornerRadius = 8
        headerView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        headerView.clipsToBounds = true
        setupTableView()
        setupSearchBar()
    }
    
    private func setupTableView() {
        recipesTableView.delegate = self
        recipesTableView.dataSource = self
        recipesTableView.register(
            RecipeCell.self,
            forCellReuseIdentifier: RecipeCell.identifier)
       recipesTableView.reloadData()
    }
    
    private func setupSearchBar() {
        recipesSearchBar.delegate = self
        recipesSearchBar.placeholder = "Search..."
        recipesSearchBar.backgroundColor = .clear
    }
}

// MARK: - TableView DataSource

extension SearchRecipesView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let recipeCell = tableView.dequeueReusableCell(
            withIdentifier: RecipeCell.identifier,
            for: indexPath) as? RecipeCell else {
            fatalError("Couldn't Find The Cell!!")
        }
        
        return recipeCell
    }
}

// MARK: - TableView Delegate

extension SearchRecipesView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("Hey iam in \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        115
    }
}

extension SearchRecipesView: UISearchBarDelegate {
    
    
}

extension SearchRecipesView: SearchRecipesViewProtocol {
    
    func displaySearchOrFilterResults(_ recipes: [RecipeCellViewModel]) {
        
        searchResults = recipes
        recipesTableView.reloadData()
    }
}
