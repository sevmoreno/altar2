//
//  UserTableViewCell.swift
//  altar
//
//  Created by Juan Moreno on 9/13/19.
//  Copyright © 2019 Juan Moreno. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var foto: UIImageView!
    @IBOutlet weak var nombre: UILabel!
    
    var userId: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
