//
//  Church.swift
//  altar
//
//  Created by Juan Moreno on 2/12/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//

import Foundation


import UIKit

class Church: NSObject {
    
    var userID: String = ""
    var displayname: String = ""
    var name: String = ""
    var address: String = ""
    var state: String = ""
    var country: String = ""
    var zipCode: String = ""
    var email: String = ""
    var facebook: String = ""
    var instragram: String = ""
    var webSite: String = ""
    var phoneNumber: String = ""
    var uidChurch: String = ""
    var fcmToken: String = ""
    var channelActive: String = "37E98093-7B60-4029-8DE2-7BD7C15840BE"
    var channelActiveTime: Int = 0
    
    init(dictionary: [String: Any]) {
           self.name = dictionary["name"] as? String ?? ""
           self.address = dictionary["address"]  as? String ?? ""
           self.userID = dictionary["userid"] as? String ?? ""
           self.country = dictionary["country"]  as? String ?? ""
            self.state = dictionary["state"]  as? String ?? ""
           self.fcmToken = dictionary["fcmToken"]  as? String ?? ""
           self.zipCode = dictionary["zipCode"] as? String ?? ""
           self.email = dictionary["email"]  as? String ?? ""
           self.facebook = dictionary["facebook"] as? String ?? ""
           self.instragram = dictionary["instragram"]  as? String ?? ""
        
            self.displayname = dictionary["displayname"]  as? String ?? "Altar"
        
           self.webSite = dictionary["webSite"]  as? String ?? ""
           self.phoneNumber = dictionary["phoneNumber"] as? String ?? ""
           self.uidChurch = dictionary["uidChurch"]  as? String ?? ""
        self.channelActiveTime = dictionary["channelActiveTime"]  as? Int ?? 0
           
        self.channelActive = dictionary["channelActive"]  as? String ?? "E41F56A9-2DA2-458F-8292-63F46DF3C8D3"
        self.userID = dictionary["userID"]  as? String ?? ""
        
        
           
       }
    
}
