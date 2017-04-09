//
//  Repository.swift
//  Arena Challenge
//
//  Created by Fernando Gallo on 08/04/17.
//  Copyright © 2017 arena. All rights reserved.
//

import Mapper

struct Repository: Mappable {

    let repositoryId: Int
    let name: String
    let numberOfForks: Int
    let numberOfStars: Int
    let user: User
    let description: String?
    
    init(map: Mapper) throws {
        try repositoryId = map.from("id")
        try name = map.from("name")
        try numberOfForks = map.from("forks_count")
        try numberOfStars = map.from("stargazers_count")
        try user = map.from("owner")
        description = map.optionalFrom("description")
    }
    
}
