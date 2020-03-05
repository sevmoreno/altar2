//
//  User.swift
//  altar
//
//  Created by Juan Moreno on 9/13/19.
//  Copyright © 2019 Juan Moreno. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var userID: String = ""
    var photoUser: String = ""
    var fullName: String = ""
    var churchUser: String = ""
    var email: String = ""
    var uid: String = ""
    var title: String = ""
    var churchID: String = ""
    var isPastor: Int = 0

   func setup(uid: String, dictionary: [String: Any]) {
           self.fullName = dictionary["name"] as? String ?? ""
           self.photoUser = dictionary["photoURL"]  as? String ?? ""
           self.userID = dictionary["userid"] as? String ?? ""
           self.churchUser = dictionary["church"]  as? String ?? ""
        
          self.title = dictionary["title"]  as? String ?? ""
          self.churchID = dictionary["churchID"] as? String ?? ""
          self.isPastor = dictionary["isPastor"]  as? Int ?? 0
        
           self.uid = uid
       }
    
}
