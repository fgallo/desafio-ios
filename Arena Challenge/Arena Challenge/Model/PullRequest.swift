//
//  PullRequest.swift
//  Arena Challenge
//
//  Created by Fernando Gallo on 09/04/17.
//  Copyright © 2017 arena. All rights reserved.
//

import Mapper

struct PullRequest: Mappable {
    
    let title: String
    let description: String?
    let date: String
    let user: User
    
    init(map: Mapper) throws {
        try title = map.from("title")
        try date = map.from("created_at")
        try user = map.from("user")
        description = map.optionalFrom("body")
    }
    
}
