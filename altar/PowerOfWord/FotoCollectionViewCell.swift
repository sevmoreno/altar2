//
//  FotoCollectionViewCell.swift
//  altar
//
//  Created by Juan Moreno on 2/10/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//

import UIKit

class FotoCollectionViewCell: UICollectionViewCell {
    var post: fondo? {
    
        didSet {
            
            guard let imagenNombre = post?.url else {return}
            imagen.loadImage(urlString: imagenNombre)
        }
        
    }

        let imagen: CustomImageView = {
            let iv = CustomImageView()
            iv.clipsToBounds = true
            iv.contentMode = .scaleAspectFill
           // iv.backgroundColor = .blue
            return iv
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            //        backgroundColor = .yellow
          
           
            addSubview(imagen)
            imagen.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
           
            
          //  backgroundColor = .red
     
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        

    
}
