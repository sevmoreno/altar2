//
//  MyCellCollectionViewCell.swift
//  altar
//
//  Created by Juan Moreno on 11/19/19.
//  Copyright © 2019 Juan Moreno. All rights reserved.
//

import UIKit

class MyCellCollectionViewCell: UICollectionViewCell {
    
    lazy var width: NSLayoutConstraint = {
        let width = contentView.widthAnchor.constraint(equalToConstant: bounds.size.width)
        width.isActive = true
        return width
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = UIColor.red
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        width.constant = bounds.size.width
        return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 1))
    }
    
    fileprivate func setupViews() {
        contentView.addSubview(label)
        label.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        label.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        
        contentView.addSubview(customView)
        customView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10).isActive = true
        customView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        customView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        customView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        if let lastSubview = contentView.subviews.last {
            contentView.bottomAnchor.constraint(equalTo: lastSubview.bottomAnchor, constant: 10).isActive = true
        }
    }
    
    let label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .yellow
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let customView: UIView = {
        let customView = UIView()
        customView.backgroundColor = .green
        customView.translatesAutoresizingMaskIntoConstraints = false
        return customView
    }()
    
}
