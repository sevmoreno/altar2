//
//  File.swift
//  altar
//
//  Created by Juan Moreno on 1/10/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//

import UIKit

class Video: NSObject {
    
    var thumbnailImageName: String?
    var title: String?
    var numberOfViews: NSNumber?
    var uploadDate: NSDate?
    
    var channel: Channel?
    
}

class Channel: NSObject {
    var name: String?
    var profileImageName: String?
}
