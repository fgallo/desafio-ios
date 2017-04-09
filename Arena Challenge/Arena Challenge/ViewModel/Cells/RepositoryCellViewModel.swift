//
//  RepositoryCellViewModel.swift
//  Arena Challenge
//
//  Created by Fernando Gallo on 08/04/17.
//  Copyright © 2017 arena. All rights reserved.
//

import Foundation

struct RepositoryCellViewModel {
    
    let name: String
    let username: String
    let description: String
    let numberOfForks: Int
    let numberOfStars: Int
    let userImageURL: URL?
    
    init(repository: Repository) {
        name = repository.name
        username = repository.user.name
        description = repository.description ?? ""
        numberOfForks = repository.numberOfForks
        numberOfStars = repository.numberOfStars
        userImageURL = URL(string: repository.user.imageUrl)
    }
    
}
