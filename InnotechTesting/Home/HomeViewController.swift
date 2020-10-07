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

class HomeViewController: UIViewController, NetworkUIHandler {
    
    //MARK:- NetworkUIHandler
    var targetView: UIView {
        return tableview
    }
    
    //MARK:- Property
    private lazy var tableview: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        tableView.register(HomeSkeletonCell.self, forCellReuseIdentifier: HomeSkeletonCell.identifier)
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
        tableview.rx.willDisplayCell
            .compactMap({ $0.cell as? HomeSkeletonCell })
            .subscribe(onNext: { (cell) in
                DispatchQueue.main.async {
                    cell.showSkeletonAnimation()
                }
            })
            .disposed(by: self.disposeBag)
        
        tableview.rx.didEndDisplayingCell
            .compactMap({ $0.cell as? HomeSkeletonCell })
            .subscribe(onNext: { (cell) in
                cell.hideSkeletonAnimation()
            })
            .disposed(by: self.disposeBag)
        
        //input
        searchController.searchBar.rx.text
            .orEmpty
            .bind(to: viewModel.input.filterText)
            .disposed(by: self.disposeBag)
        
        networkErrorView.reloadButtonPressed
            .bind(to: viewModel.input.reloadButtonPressed)
            .disposed(by: self.disposeBag)
        
        //output
        viewModel.output.dataStatus
            .map({ $0.cellData })
            .drive(tableview.rx.items) { (tableView, row, model) -> UITableViewCell in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: model.cellIdentifier) else { return UITableViewCell() }
                if let cell = cell as? ConfigurableCell { cell.configureCell(model: model) }
                return cell
        }
        .disposed(by: self.disposeBag)
        
        viewModel.output.dataStatus
            .map({ $0.shouldHideNoDataView })
            .drive(noDataView.rx.isHidden)
            .disposed(by: self.disposeBag)
        
        viewModel.output.networkError
            .map({ $0 == .None ? 0 : 1 })
            .drive(networkErrorView.rx.alpha)
            .disposed(by: self.disposeBag)
    }
}

