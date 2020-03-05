//
//  VideoCell.swift
//  altar
//
//  Created by Juan Moreno on 1/10/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//

import UIKit

class VideoCell: UICollectionViewCell {
    
   
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
        imageView.image = #imageLiteral(resourceName: "450x450bb.jpg")
        return imageView
    }()
    
    let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .green
        return imageView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .purple
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subtitleTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .red
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    
    func setupViews() {
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        
    
    }
   
       
       override init(frame: CGRect) {
           super.init(frame: frame)
           setupViews()
       }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
