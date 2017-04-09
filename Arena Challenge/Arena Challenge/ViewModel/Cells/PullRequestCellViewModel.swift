//
//  PullRequestCellViewModel.swift
//  Arena Challenge
//
//  Created by Fernando Gallo on 09/04/17.
//  Copyright © 2017 arena. All rights reserved.
//

import Foundation

struct PullRequestCellViewModel {
    
    let title: String
    let username: String
    let description: String
    let date: String
    let userImageURL: URL?
    
    init(pullRequest: PullRequest) {
        title = pullRequest.title
        username = pullRequest.user.name
        description = pullRequest.description ?? ""
        userImageURL = URL(string: pullRequest.user.imageUrl)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        if let newDate = dateFormatter.date(from: pullRequest.date) {
            dateFormatter.dateFormat = "dd/MM/yyyy '-' HH:mm"
            date = dateFormatter.string(from: newDate)
        } else {
            date = ""
        }
    }
    
}
