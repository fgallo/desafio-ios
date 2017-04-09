//
//  User.swift
//  Arena Challenge
//
//  Created by Fernando Gallo on 08/04/17.
//  Copyright © 2017 arena. All rights reserved.
//

import Mapper

struct User: Mappable {
    
    let userId: Int
    let name: String
    let imageUrl: String
    
    init(map: Mapper) throws {
        try userId = map.from("id")
        try name = map.from("login")
        try imageUrl = map.from("avatar_url")
    }
    
    init(userId: Int, name: String, imageUrl: String) {
        self.userId = userId
        self.name = name
        self.imageUrl = imageUrl
    }
    
}

