//
//  RepositoriesViewModel.swift
//  Arena Challenge
//
//  Created by Fernando Gallo on 08/04/17.
//  Copyright © 2017 arena. All rights reserved.
//

import Foundation
import Moya
import Mapper
import Moya_ModelMapper
import RxCocoa
import RxSwift

class RepositoriesViewModel {
    
    let title = "GitHub JavaPop"
    
    private let provider: RxMoyaProvider<GitHubAPI>
    private let fetchExecuting: Driver<Bool>
    private var page: Int
    private var repositories: [Repository]
    
    let activityIndicator: ActivityIndicator
    var allRepositoriesLoaded: Bool
    
    init(provider: RxMoyaProvider<GitHubAPI>) {
        self.provider = provider
        self.page = 1
        self.repositories = []
        self.allRepositoriesLoaded = false
        self.activityIndicator = ActivityIndicator()
        
        fetchExecuting = activityIndicator
            .asDriver()
    }
    
    
    // MARK: - TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func viewModelForCell(at indexPath: IndexPath) -> RepositoryCellViewModel {
        return RepositoryCellViewModel(repository: repositories[indexPath.row])
    }
    
    func repositoryPullRequestViewModelFor(indexPath: IndexPath) -> RepositoryPullRequestsViewModel {
        return RepositoryPullRequestsViewModel(provider: GitHubProvider, repository: repositories[indexPath.row])
    }
    
    
    // MARK: - API
    
    func refreshRepositories() {
        page = 1
        repositories = []
        allRepositoriesLoaded = false
    }
    
    func fetchRepositories(loadNextPageTrigger: Observable<Void>) -> Driver<[Repository]> {
        return recursivelyFetchRepositories(loadedSoFar: [], loadNextPageTrigger: loadNextPageTrigger)
    }
    
    private func recursivelyFetchRepositories(loadedSoFar: [Repository], loadNextPageTrigger: Observable<Void>) -> Driver<[Repository]> {
        return loadRepositories()
            .flatMap { repositories in
                if repositories.count == 0 {
                    self.allRepositoriesLoaded = true
                }
                
                let loadedRepositories = self.repositories
                
                return Driver.concat([
                    Driver.just(loadedRepositories),
                    Observable.never().takeUntil(loadNextPageTrigger).asDriver(onErrorJustReturn: []),
                    self.recursivelyFetchRepositories(loadedSoFar: loadedRepositories, loadNextPageTrigger: loadNextPageTrigger)
                    ])
        }
    }
    
    private func loadRepositories() -> Driver<[Repository]> {
        return provider
            .request(GitHubAPI.Repositories(language: "Java", sort: "stars", page: page))
            .trackActivity(activityIndicator)
            .mapArray(type: Repository.self, keyPath: "items")
            .do(onNext: { repositories in
                self.page += 1
                self.repositories.append(contentsOf: repositories)
            })
            .asDriver(onErrorJustReturn: [])
    }
    
}
