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
    let htmlUrl: String
    let description: String?
    let date: String
    let user: User
    let state: PullRequestState
    
    enum PullRequestState: String{
        case open = "open"
        case closed = "closed"
    }
    
    init(map: Mapper) throws {
        try title = map.from("title")
        try htmlUrl = map.from("html_url")
        try date = map.from("created_at")
        try user = map.from("user")
        try state = map.from("state")
        description = map.optionalFrom("body")
    }
    
}
