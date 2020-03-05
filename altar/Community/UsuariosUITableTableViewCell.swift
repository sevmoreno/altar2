//
//  UsuariosUITableTableViewCell.swift
//  altar
//
//  Created by Juan Moreno on 2/19/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//

import UIKit

class UsuariosUITableTableViewCell: UITableViewCell {
    
    
    @IBOutlet var foto: CustomImageView! = {
        
        let a = CustomImageView ()
        
      
              a.layer.borderWidth = 1
             
              a.layer.borderColor = advengers.shared.colorOrange.cgColor
              
              a.layer.cornerRadius = 50 / 2
        return a
    } ()
    
    @IBOutlet var nombre: UILabel!
    
//    let userProfileImageView: CustomImageView = {
//        let iv = CustomImageView()
//        iv.contentMode = .scaleAspectFill
//        iv.clipsToBounds = true
//        iv.backgroundColor = .blue
//        return iv
//    }()
//
//    var photoImageView: CustomImageView = {
//        let iv = CustomImageView()
//        //  iv.contentMode = .scaleAspectFill
//
//        iv.contentMode = .scaleAspectFit
//        iv.clipsToBounds = true
//        return iv
//    }()
    
//    let usernameLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Username"
//        label.font = UIFont(name: "Avenir-Medium", size: 15)
//        return label
//    }()
    
    
    var user: User? {
        didSet{
            
//            guard let postImageUrl = user?.photoUser else { return }
            
            
//            userProfileImageView.loadImage(urlString: postImageUrl)
//
//            usernameLabel.text = user?.fullName
            

        }
        
        
    
        
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()

              foto.layer.borderWidth = 1
             
              foto.layer.borderColor = advengers.shared.colorOrange.cgColor
              
              foto.layer.cornerRadius = 50 / 2
        
        foto.contentMode = .scaleAspectFill
        foto.clipsToBounds = true
        
        
        nombre.textColor = .white
        
//        contentView.addSubview(userProfileImageView)
//        contentView.addSubview(usernameLabel)
//
//        usernameLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
