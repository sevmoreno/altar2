//
//  fondo.swift
//  altar
//
//  Created by Juan Moreno on 2/11/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//

import Foundation

struct fondo {

    var type: String
    var index: String
    var url: String
    
    init(dictionary: [String : Any]) {
            self.type = dictionary["type"] as? String ?? ""
             self.index = dictionary["index"] as? String ?? ""
             self.url = dictionary["url"] as? String ?? ""
    }
}
