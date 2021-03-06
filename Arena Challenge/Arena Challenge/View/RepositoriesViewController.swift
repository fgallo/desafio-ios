//
//  RepositoriesViewController.swift
//  Arena Challenge
//
//  Created by Fernando Gallo on 08/04/17.
//  Copyright © 2017 arena. All rights reserved.
//

import UIKit
import MBProgressHUD
import RxCocoa
import RxSwift

class RepositoriesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let progressHUD = MBProgressHUD()
    private let startLoadingOffset: CGFloat = 300.0
    private let disposeBag = DisposeBag()
    
    var viewModel: RepositoriesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
        fetchRepositories()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupView() {
        title = viewModel.title
        
        viewModel.activityIndicator
            .asObservable()
            .bindTo(progressHUD.rx_mbprogresshud_animating)
            .addDisposableTo(disposeBag)
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        self.navigationItem.backBarButtonItem = backItem
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 120.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none
        tableView.register(UINib.init(nibName: "RepositoryTableViewCell", bundle: nil), forCellReuseIdentifier: "RepositoryCell")
    }
    
    private func fetchRepositories() {
        let loadNextPageTrigger = tableView.rx.contentOffset.flatMap({ (offset) in
            self.isNearTheBottomEdge(contentOffset: offset, tableView: self.tableView) && !self.viewModel.allRepositoriesLoaded
                ? Observable.just()
                : Observable.empty()
        })
        
        viewModel.fetchRepositories(loadNextPageTrigger: loadNextPageTrigger)
            .drive(onNext: { repositories in
                self.tableView.reloadData()
                self.tableView.separatorStyle = .singleLine
            })
            .addDisposableTo(disposeBag)
    }
    
    private func isNearTheBottomEdge(contentOffset: CGPoint, tableView: UITableView) -> Bool {
        return contentOffset.y + tableView.frame.size.height + startLoadingOffset > tableView.contentSize.height
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifiers.RepositoryPullRequestsViewController.rawValue {
            if let indexPath = sender as? IndexPath {
                let repositoryPullRequestsViewController = segue.destination as! RepositoryPullRequestsViewController
                repositoryPullRequestsViewController.viewModel = viewModel.repositoryPullRequestViewModelFor(indexPath: indexPath)
            }
        }
    }
    
}


// MARK: - UITableView DataSource and Delegate

extension RepositoriesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSectionsInTableView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryCell", for: indexPath) as! RepositoryTableViewCell
        cell.viewModel = viewModel.viewModelForCell(at: indexPath)
        cell.configure()
        return cell
    }
    
}

extension RepositoriesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: SegueIdentifiers.RepositoryPullRequestsViewController.rawValue, sender: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
