//
//  RepositoryPullRequestsViewModel.swift
//  Arena Challenge
//
//  Created by Fernando Gallo on 09/04/17.
//  Copyright © 2017 arena. All rights reserved.
//

import Foundation
import Moya
import Mapper
import Moya_ModelMapper
import RxCocoa
import RxSwift

class RepositoryPullRequestsViewModel {
    
    private let provider: RxMoyaProvider<GitHubAPI>
    private let repository: Repository
    private var pullRequests: [PullRequest]
    var title: String
    
    init(provider: RxMoyaProvider<GitHubAPI>, repository: Repository) {
        self.provider = provider
        self.repository = repository
        self.pullRequests = []
        self.title = repository.name
    }
    
    
    // MARK: - TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pullRequests.count
    }
    
    func viewModelForCell(at indexPath: IndexPath) -> PullRequestCellViewModel {
        return PullRequestCellViewModel(pullRequest: pullRequests[indexPath.row])
    }
    
    func pullRequestFor(indexPath: IndexPath) -> PullRequest {
        return pullRequests[indexPath.row]
    }
    
    
    // MARK: - API
    
    func fetchPullRequests() -> Driver<[PullRequest]> {
        return provider
            .request(GitHubAPI.PullRequests(user: repository.user.name, repository: repository.name))
            .mapArray(type: PullRequest.self)
            .do(onNext: { pullRequests in
                self.pullRequests.append(contentsOf: pullRequests)
            })
            .asDriver(onErrorJustReturn: [])
    }

}
