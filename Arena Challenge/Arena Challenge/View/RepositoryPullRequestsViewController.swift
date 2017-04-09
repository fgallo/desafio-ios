//
//  RepositoryPullRequestsViewController.swift
//  Arena Challenge
//
//  Created by Fernando Gallo on 09/04/17.
//  Copyright © 2017 arena. All rights reserved.
//

import UIKit
import MBProgressHUD
import RxCocoa
import RxSwift

class RepositoryPullRequestsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let progressHUD = MBProgressHUD()
    private let disposeBag = DisposeBag()
    
    var viewModel: RepositoryPullRequestsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
        fetchPullRequests()
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
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 120.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(UINib.init(nibName: "PullRequestTableViewCell", bundle: nil), forCellReuseIdentifier: "PullRequestCell")
    }
    
    private func fetchPullRequests() {
        viewModel.fetchPullRequests()
            .drive(onNext: { pullRequests in
                self.tableView.reloadData()
            })
            .addDisposableTo(disposeBag)
    }

}


// MARK: - UITableView DataSource and Delegate

extension RepositoryPullRequestsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections(in: tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableView(tableView, numberOfRowsInSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PullRequestCell", for: indexPath) as! PullRequestTableViewCell
        cell.viewModel = viewModel.viewModelForCell(at: indexPath)
        cell.configure()
        return cell
    }
    
}

extension RepositoryPullRequestsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
