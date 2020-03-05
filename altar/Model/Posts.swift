//
//  Posts.swift
//  altar
//
//  Created by Juan Moreno on 9/18/19.
//  Copyright © 2019 Juan Moreno. All rights reserved.
//

import UIKit

class Posts {
    
    var church: String!
    var author: String
    var likes: Int!
    var photoImage: String!
    var userID: String!
    var postID: String!
    var userPhoto: String!
    var postType: String!
    var message: String!
    var photoW: CGFloat?
    var photoH: CGFloat?
    var comments: Int!
    var hasLiked = false
    var whoLikes: [String] = [String] ()
    var creationDate: Date?
    
    init(dictionary: [String: Any]) {
        //self.user = user
        self.author = dictionary["author"] as? String ?? ""
        self.church = dictionary["church"] as? String ?? ""
        self.likes = dictionary["prays"] as? Int 
        self.comments = dictionary["comments"] as? Int ?? 0
        self.photoImage = dictionary["pathtoPost"] as? String ?? "No image"
        self.userID = dictionary["userID"] as? String ?? ""
        self.postID = dictionary["postID"] as? String
        self.userPhoto = dictionary["userPhoto"] as? String ?? ""
        self.postType = dictionary["postType"] as? String ?? ""
        self.message = dictionary["message"] as? String ?? ""
        self.photoH = dictionary["photoW"] as? CGFloat ?? 764.0
        self.photoW = dictionary["photoH"] as? CGFloat ?? 694.0
       // self.creationDate = dictionary["creationDate"] as? Double ?? 0
        let secondsFrom1970 = dictionary["creationDate"] as? Int64 ?? 0
         self.creationDate = Date(milliseconds: secondsFrom1970)
    }
    
}
