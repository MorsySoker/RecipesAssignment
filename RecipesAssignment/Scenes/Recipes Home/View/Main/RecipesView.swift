//
//  RecipesView.swift
//  RecipesAssignment
//
//  Created by MorsyElsokary on 24/08/2022.
//

import UIKit

class RecipesView: BaseViewController {
    
    // MARK: - Views
    
    private lazy var headerLbl: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.textAlignment = .left
        lbl.textColor = UIColor.white
        lbl.text = "Recipes Search"
        lbl.font = UIFont(name: "Georgia", size: 20)
        lbl.numberOfLines = 1
        return lbl
    }()
    
    private lazy var headerView: UIView = {
        let header = UIView(frame: .zero)
        header.backgroundColor = UIColor(named: "headerColor")
        header.layer.cornerRadius = 8
        header.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        header.clipsToBounds = true
        header.insetsLayoutMarginsFromSafeArea = false
        return header
    }()
    
    private lazy var recipesSearchBar: UISearchBar = {
        let sBar = UISearchBar(frame: .zero)
        sBar.delegate = self
        sBar.placeholder = "Search..."
        sBar.backgroundColor = .clear
        sBar.searchBarStyle = .minimal
        return sBar
    }()
    
    private lazy var recipesTableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.register(RecipeCell.self, forCellReuseIdentifier: RecipeCell.identifier)
        view.delegate = self
        view.dataSource = self
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .clear
        view.separatorStyle = .none
        return view
    }()
    
    // MARK: - Properties
    
    let recipePresenter: RecipesPresenter
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Recipes Search"
        view.insetsLayoutMarginsFromSafeArea = true
        applyViewCode()
    }
    
    // MARK: - init
    
    init(recipePresenter: RecipesPresenter) {
        self.recipePresenter = recipePresenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        125
    }
}

extension RecipesView: UISearchBarDelegate {
    
    
}

// MARK: - Setup Views

extension RecipesView: ViewCodeConfiguration {
    
    func buildHierarchy() {
        
        view.addSubview(headerView)
        headerView.addSubview(headerLbl)
        view.addSubview(recipesSearchBar)
        view.addSubview(recipesTableView)
        
    }
    
    func setupConstraints() {
        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(90)
        }
        
        headerLbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-22)
        }
        
        recipesSearchBar.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(14)
            make.leading.trailing.equalToSuperview().inset(18)
            make.height.equalTo(36)
        }
        
        recipesTableView.snp.makeConstraints { make in
            make.top.equalTo(recipesSearchBar.snp.bottom).offset(24)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
