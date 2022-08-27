//
//  RecipesView.swift
//  RecipesAssignment
//
//  Created by MorsyElsokary on 24/08/2022.
//

import UIKit

protocol SearchRecipesViewInput: AnyObject {
    
    func displaySearchOrFilterResults(_ recipes: [RecipeCellViewModel])
    func displayNextPageResults(_ recipes: [RecipeCellViewModel])
}

protocol SearchRecipesViewOutput: AnyObject {
    
    func search(WithKeyowrd query: String)
    func fetchNextPageForSearchResults()
}

final class SearchRecipesView: BaseViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var recipesTableView: UITableView!
    @IBOutlet private weak var headerView: UIView!
    @IBOutlet private weak var searchBar: SearchTextField!
    
    // MARK: - Properties
    
    lazy var searchResults: [RecipeCellViewModel] = [RecipeCellViewModel]()
    var interactor: SearchRecipesInteractorInput?
    var router: SearchRecipeRoutingLogic?
    var count = 10
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Methods
    
    private func setup() {
        setupViews()
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
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.startVisible = true
        searchBar.theme.bgColor = .white
        searchBar.theme.font = .systemFont(ofSize: 15)
        searchBar.theme.cellHeight = 40
        searchBar.theme.separatorColor = UIColor (red: 0.9, green: 0.9, blue: 0.9, alpha: 0.5)
    }
    
    private func refreshTableView() {
        
        searchBar.stopLoadingIndicator()
        recipesTableView.reloadData()
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
        
        let recipe = searchResults[indexPath.row]
        recipeCell.configure(with: recipe)
        return recipeCell
    }
}

// MARK: - TableView Delegate

extension SearchRecipesView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let recipe = searchResults[indexPath.item]
        //        router?.showDetails(for: recipe)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        115
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == searchResults.count - 1 {
            interactor?.fetchNextPageForSearchResults()
            searchBar.showLoadingIndicator()
        }
    }
}

// MARK: - TextField Delegate

extension SearchRecipesView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.location == 0 && string == " " {
            // prevent space on first character
            return false
        }
        
        if textField.text?.last == " " && string == " " {
            // allowed only single space
            return false
        }
        
        if string == " " { return true } // now allowing space between name
        
        if string.rangeOfCharacter(from: CharacterSet.letters.inverted) != nil {
            return false
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let searchKeyword = textField.text, searchKeyword.isNotEmptyOrSpaces()
        else {
            //            displayError(WithMessage: "Please Enter Valid Sarch Keyword")
            textField.resignFirstResponder()
            return true
        }
        interactor?.search(WithKeyowrd: searchKeyword)
        textField.resignFirstResponder()
        searchBar.showLoadingIndicator()
        return true
    }
}

extension SearchRecipesView: SearchRecipesViewInput {
    
    func displaySearchOrFilterResults(_ recipes: [RecipeCellViewModel]) {
        
        searchResults = recipes
        refreshTableView()
        let topRow = IndexPath(row: 0,section: 0)
        recipesTableView.scrollToRow(at: topRow, at: .top, animated: true)
    }
    
    func displayNextPageResults(_ recipes: [RecipeCellViewModel]) {
        searchResults = recipes
        refreshTableView()
    }
}
