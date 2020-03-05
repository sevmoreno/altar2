//
//  Devo.swift
//  altar
//
//  Created by Juan Moreno on 1/13/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//

import Foundation
import UIKit

struct Devo {
    
    var church: String! = ""
    var author: String! = ""
    var title: String! = ""
  //  var likes: Int!
    var photoURL: String! = ""
  //  var userID: String!
    
    var urltexto: String! = ""
    
    var postID: String! = ""
  //  var userPhoto: String!
//var postType: String!
    var message: String! = ""
    
    var creationDate: Date!
    var devoUID: String! = ""
    
    init(dictionary: [String: Any]) {
               self.author = dictionary["author"] as? String ?? ""
               self.church = dictionary["church"] as? String ?? ""
               self.title = dictionary["title"] as? String
               self.urltexto = dictionary["urltexto"] as? String
               self.photoURL = dictionary["photoURL"] as? String
                self.devoUID = dictionary["devoUID"] as? String
        
            
               self.postID = dictionary["postID"] as? String ?? ""
               self.message = dictionary["message"] as? String ?? ""
       
        let secondsFrom1970 = dictionary["creationDate"] as? Int64 ?? 0
        self.creationDate = Date(milliseconds: secondsFrom1970)
    }
    
    
 //   var photoW: CGFloat?
 //   var photoH: CGFloat?
    
    
  //  var whoLikes: [String] = [String] ()
    
   /*
    init(dictionary: [String: Any]) {
        //self.user = user
        self.author = dictionary["author"] as? String ?? ""
        self.church = dictionary["church"] as? String ?? ""
  //      self.likes = dictionary["likes"] as? Int ?? 0
        self.photoImage = dictionary["pathtoPost"] as? String ?? "No image"
    //    self.userID = dictionary["userID"] as? String ?? ""
        self.postID = dictionary["postID"] as? String ?? ""
   //     self.userPhoto = dictionary["userPhoto"] as? String ?? ""
   //     self.postType = dictionary["postType"] as? String ?? ""
        self.message = dictionary["message"] as? String ?? ""
   //     self.photoH = dictionary["photoW"] as? CGFloat ?? 764.0
     //   self.photoW = dictionary["photoH"] as? CGFloat ?? 694.0
      //  let secondsFrom1970 = dictionary["creationDate"] as? Double ?? 0
      //  self.creationDate = Date(timeIntervalSince1970: secondsFrom1970)
    }
    
 */
    
}
