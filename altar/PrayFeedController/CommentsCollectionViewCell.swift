//
//  CommentsCollectionViewCell.swift
//  altar
//
//  Created by Juan Moreno on 1/14/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//

import UIKit

class CommentsCollectionViewCell: UICollectionViewCell {
    
    
        var comment: Comment? {
            didSet {
                guard let comment = comment else { return }
                
                let attributedText = NSMutableAttributedString(string: comment.user.fullName, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
                
                attributedText.append(NSAttributedString(string: " " + comment.text, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]))
                
                textView.attributedText = attributedText
                
                let profileuserURL = comment.user.photoUser
                print("Este es el URL de la foto del usuario")
                print(profileuserURL)
                profileImageView.loadImage(urlString: comment.user.photoUser)
                
      
              //  profileImageView.loadImage(urlString: comment.user.photoUser)
            }
        }
        
        let textView: UITextView = {
            let textView = UITextView()
            textView.font = UIFont.systemFont(ofSize: 14)
            //        label.numberOfLines = 0
            //        label.backgroundColor = .lightGray
            textView.isScrollEnabled = false
            return textView
        }()
        
        let profileImageView: CustomImageView = {
            let iv = CustomImageView()
            iv.contentMode = .scaleAspectFill
            iv.clipsToBounds = true
            iv.backgroundColor = .blue
            return iv

        }()
    
  
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            //        backgroundColor = .yellow
            
            addSubview(profileImageView)
            profileImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
            profileImageView.layer.cornerRadius = 50 / 2
            
            addSubview(textView)
            textView.anchor(top: topAnchor, left: profileImageView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 4, paddingLeft: 4, paddingBottom: 4, paddingRight: 4, width: 0, height: 0)
            
          
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
 

    
}
