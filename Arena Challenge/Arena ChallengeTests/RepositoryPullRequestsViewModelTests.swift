//
//  RepositoryPullRequestsViewModelTests.swift
//  Arena Challenge
//
//  Created by Fernando Gallo on 09/04/17.
//  Copyright © 2017 arena. All rights reserved.
//

import XCTest
import RxSwift

@testable import Arena_Challenge

class RepositoryPullRequestsViewModelTests: XCTestCase {
    
    var model: RepositoryPullRequestsViewModel!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        
        let user = User(userId: 6407041, name: "ReactiveX", imageUrl: "https://avatars2.githubusercontent.com/u/6407041?v=3")
        let repository = Repository(repositoryId: 7508411, name: "RxJava", description: "", numberOfForks: 4084, numberOfStars: 23145, user: user)
        
        model = RepositoryPullRequestsViewModel(provider: GitHubProviderTest, repository: repository)
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        model = nil
        disposeBag = nil
        super.tearDown()
    }
    
    func testTableViewNumberOfSections() {
        let numberOfSections = model.numberOfSectionsInTableView()
        XCTAssertEqual(numberOfSections, 1, "Number of sections in Pull Requests TableView isn't 1.")
    }
    
    func testEmptyTableView() {
        let numberOfRows = model.numberOfRowsInSection(0)
        XCTAssertEqual(numberOfRows, 0, "Number of rows in Pull Requests TableView isn't empty at the beginning.")
    }
    
    func testNotEmptyTableView() {
        let promise = expectation(description: "driveOnNext called")
        
        model.fetchPullRequests()
            .drive(onNext: { pullRequests in
                let numberOfRows = self.model.numberOfRowsInSection(0)
                XCTAssertGreaterThan(numberOfRows, 0, "Number of rows in Pull Requests TableView is empty after load stubed requests.")
                promise.fulfill()
            })
            .addDisposableTo(disposeBag)
        
        waitForExpectations(timeout: 3.0) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    
    func testFetchPullRequestsParse() {
        let promise = expectation(description: "driveOnNext called")
        
        model.fetchPullRequests()
            .drive(onNext: { pullRequests in
                let pullRequest = pullRequests[0]
                
                XCTAssertEqual(pullRequest.title, "Allowing skipping of query params if the conveters converted to a null", "Error on parsing pull request title.")
                XCTAssertEqual(pullRequest.description, "First let me say, love retrofit. It's a wonderfully written library.")
                
                promise.fulfill()
            })
            .addDisposableTo(disposeBag)
        
        waitForExpectations(timeout: 3.0) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    
    func testFetchPullRequestsStubCount() {
        let promise = expectation(description: "driveOnNext called")
        
        model.fetchPullRequests()
            .drive(onNext: { pullRequests in
                XCTAssertEqual(pullRequests.count, 1, "Number of pull requests Stubed isn't 1.")
                promise.fulfill()
            })
            .addDisposableTo(disposeBag)
        
        waitForExpectations(timeout: 3.0) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }

    
}
