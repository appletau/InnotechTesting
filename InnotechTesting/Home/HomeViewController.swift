//
//  ViewController.swift
//  InnotechTesting
//
//  Created by tautau on 2020/10/2.
//  Copyright © 2020 tautau. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class HomeViewController: UIViewController {
    
    //MARK:- Property
    private lazy var tableview: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = .leastNormalMagnitude
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: String(describing: HomeTableViewCell.self))
        return tableView
    }()
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.autocapitalizationType = .none
        return searchController
    }()
    
    private lazy var searchBarView: UIView = {
        let view = UIView()
        view.addSubview(searchController.searchBar)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    private let viewModel = HomeViewModel()
    private var disposeBag = DisposeBag()
    
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        initBinding()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.disposeBag = DisposeBag()
    }
    
    //MARK:- Private Function
    private func setupUI() {
        self.view.backgroundColor = .white
        self.definesPresentationContext = true
        setupConstraints()
    }
    
    private func setupConstraints() {
        self.view.addSubview(searchBarView)
        NSLayoutConstraint.activate([
               searchBarView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
               searchBarView.heightAnchor.constraint(equalToConstant: 50),
               searchBarView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
               searchBarView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
           ])
        
        self.view.addSubview(tableview)
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: searchBarView.bottomAnchor),
            tableview.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            tableview.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableview.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func initBinding() {
        viewModel.output.photoList
            .drive(tableview.rx.items) { (tableView, row, model) -> UITableViewCell in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HomeTableViewCell.self)) as? HomeTableViewCell else { return UITableViewCell() }
                cell.configureCell(model: model)
                return cell
        }
        .disposed(by: self.disposeBag)
        
        searchController.searchBar.rx.text
            .orEmpty
            .bind(to: viewModel.input.filterText)
            .disposed(by: self.disposeBag)
    }
}

