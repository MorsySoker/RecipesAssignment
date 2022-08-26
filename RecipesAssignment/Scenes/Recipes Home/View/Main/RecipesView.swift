//
//  RecipesView.swift
//  RecipesAssignment
//
//  Created by MorsyElsokary on 24/08/2022.
//

import UIKit

class RecipesView: BaseViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var recipesTableView: UITableView!
    @IBOutlet private weak var headerView: UIView!
    @IBOutlet private weak var recipesSearchBar: UISearchBar!
    
    // MARK: - Properties
    
    let interactor: SearchRecipesInteractor
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: - init
    
    init(interactor: SearchRecipesInteractor) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
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

extension RecipesView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
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

extension RecipesView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("Hey iam in \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        115
    }
}

extension RecipesView: UISearchBarDelegate {
    
    
}
