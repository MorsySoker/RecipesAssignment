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
    func filterResults(WithFilter filter: HealthFilters)
    func fetchNextPageForSearchResults()
}

final class SearchRecipesView: BaseViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var recipesTableView: UITableView!
    @IBOutlet private weak var headerView: UIView!
    @IBOutlet private weak var searchBar: SearchTextField!
    @IBOutlet private weak var healthFilterCollection: UICollectionView!
    
    // MARK: - Properties
    
    lazy var searchResults: [RecipeCellViewModel] = [RecipeCellViewModel]()
    var interactor: SearchRecipesInteractorInput?
    var router: SearchRecipeRoutingLogic?
    var count = 10
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: - Methods
    
    private func setupViews() {
        headerView.layer.cornerRadius = 8
        headerView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        headerView.clipsToBounds = true
        setupTableView()
        setupSearchBar()
        setupHealthFilterCollection()
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
    
    private func setupHealthFilterCollection() {
        
        healthFilterCollection.showsVerticalScrollIndicator = false
        healthFilterCollection.showsHorizontalScrollIndicator = false
        healthFilterCollection.delegate = self
        healthFilterCollection.dataSource = self
        healthFilterCollection.register(HealthFilterCell.self,
                                        forCellWithReuseIdentifier: HealthFilterCell.identifier)
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.scrollDirection  = .horizontal
        healthFilterCollection!.collectionViewLayout = layout
        healthFilterCollection.reloadData()
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

// MARK: - View input Protocol Confirmation

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

// MARK: - health Filter Collection DataSource

extension SearchRecipesView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        HealthFilters.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let healthFilterCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HealthFilterCell.identifier,
            for: indexPath) as? HealthFilterCell else {
            fatalError("Couldn't Find The Cell!!")
        }
        
        let healthText = HealthFilters.allCases[indexPath.row]
        
        healthFilterCell.healthLbl.text = healthText.text
        
        return healthFilterCell
    }
}

// MARK: - health Filter Collection Delegate

extension SearchRecipesView: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let filter = HealthFilters.allCases[indexPath.row]
        interactor?.filterResults(WithFilter: filter)
        if let cell = collectionView.cellForItem(at: indexPath) as? HealthFilterCell {
            cell.contentView.backgroundColor = UIColor(named: "headerColor")
            cell.healthLbl.textColor = .white
        }
        searchBar.showLoadingIndicator()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? HealthFilterCell {
            cell.healthLbl.textColor = UIColor(red: 0.371, green: 0.371, blue: 0.371, alpha: 1)
            cell.contentView.backgroundColor = .white
        }
    }
}

// MARK: - health Filter FlowLayout

extension SearchRecipesView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = healthFilterCollection.frame.size.width / 3.5
            
            return CGSize(width: width, height: 40)
        }
}
