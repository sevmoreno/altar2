//
//  Slide3Type.swift
//  altar
//
//  Created by Juan Moreno on 2/18/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//

import UIKit

class Slide3Type: UIView {

    
    var even: Event? {
        didSet {
            
            guard let a = even?.photoURL else {return}
            
            photoImageView.loadImage(urlString: a)
            usernameLabel.text = even?.title
            
            
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var photoImageView: CustomImageView = {
        let iv = CustomImageView()
        //  iv.contentMode = .scaleAspectFill
        
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    let usernameLabel: UILabel = {
        
        let a = UILabel()
       
        a.text = "texto"
      
        a.font = UIFont(name: "Avenir-Heavy", size: 20)
        a.textColor = .white
        a.numberOfLines = 0
        return a
        
    } ()

   // let frameA = CGRect((x: 0, y: Double, width: 500, height: 500))

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(photoImageView)
        photoImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: frame.width, height: 383)
        addSubview(usernameLabel)
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
      usernameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        usernameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        photoImageView.contentMode = .scaleAspectFill
        usernameLabel.textAlignment = .center
        usernameLabel.font = UIFont(name: "Avenir-Heavy", size: 20)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
