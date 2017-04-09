//
//  RepositoriesViewModelTests.swift
//  Arena Challenge
//
//  Created by Fernando Gallo on 09/04/17.
//  Copyright © 2017 arena. All rights reserved.
//

import XCTest
import RxSwift

@testable import Arena_Challenge

class RepositoriesViewModelTests: XCTestCase {
    
    var model: RepositoriesViewModel!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        model = RepositoriesViewModel(provider: GitHubProviderTest)
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        model = nil
        disposeBag = nil
        super.tearDown()
    }
    
    func testTableViewNumberOfSections() {
        let numberOfSections = model.numberOfSectionsInTableView()
        XCTAssertEqual(numberOfSections, 1, "Number of sections in Repositories TableView isn't 1.")
    }
    
    func testEmptyTableView() {
        let numberOfRows = model.numberOfRowsInSection(0)
        XCTAssertEqual(numberOfRows, 0, "Number of rows in Repositories TableView isn't empty at the beginning.")
    }
    
    func testNotEmptyTableView() {
        let promise = expectation(description: "driveOnNext called")
        
        model.loadRepositories()
            .drive(onNext: { repositories in
                let numberOfRows = self.model.numberOfRowsInSection(0)
                XCTAssertGreaterThan(numberOfRows, 0, "Number of rows in Repositories TableView is empty after load stubed repositories.")
                promise.fulfill()
            })
            .addDisposableTo(disposeBag)
        
        waitForExpectations(timeout: 3.0) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }

    func testFetchRepositoriesParse() {
        let promise = expectation(description: "driveOnNext called")
        
        model.loadRepositories()
            .drive(onNext: { repositories in
                let repository = repositories[0]
                
                XCTAssertEqual(repository.repositoryId, 7508411, "Error on parsing repository id.")
                XCTAssertEqual(repository.name, "RxJava", "Error on parsing repository name.")
                XCTAssertEqual(repository.description, "RxJava – Reactive Extensions for the JVM – a library for composing asynchronous and event-based programs using observable sequences for the Java VM.", "Error on parsing repository description.")
                XCTAssertEqual(repository.numberOfForks, 4084, "Error on parsing repository number of Forks.")
                XCTAssertEqual(repository.numberOfStars, 23145, "Error on parsing repository number of Stars.")
                
                promise.fulfill()
            })
            .addDisposableTo(disposeBag)
        
        waitForExpectations(timeout: 3.0) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    
    func testFetchRepositoriesStubCount() {
        let promise = expectation(description: "driveOnNext called")
        
        model.loadRepositories()
            .drive(onNext: { repositories in
                XCTAssertEqual(repositories.count, 3, "Number of repositories Stubed isn't 3.")
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
