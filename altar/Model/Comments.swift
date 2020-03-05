//
//  Comments.swift
//  altar
//
//  Created by Juan Moreno on 1/14/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//

import Foundation

struct Comment {
    
    let user: User
    
    let text: String
    let uid: String
    
    init(user: User, dictionary: [String: Any]) {
        self.user = user
        self.text = dictionary["text"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
    }
}
