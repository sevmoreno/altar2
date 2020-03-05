//
//  PostCell.swift
//  Facebook+Research
//
//  Created by Duc Tran on 3/20/17.
//  Copyright © 2017 Developers Academy. All rights reserved.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell
{
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timeAgoLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!

    
    /*
  
    var post: Posts! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI()
    {
       
        print("Lo que hay en post \(post.userPhoto)")
        
           // DispatchQueue.main.async {
                
                self.profileImageView.downloadImage(imgURL: self.post.userPhoto)
                self.profileImageView.layer.cornerRadius = 3.0
                self.profileImageView.layer.masksToBounds = true
                
                self.captionLabel.text = self.post.message
                self.usernameLabel.text = self.post.author
                //  timeAgoLabel.text = post.timeAgo
                
                
                self.postImageView.downloadImage(imgURL: self.post.photoImage)
                self.postImageView.layer.cornerRadius = 5.0
                self.postImageView.layer.masksToBounds = true
            //}
        
        
        
        
    }

    */
    
}



/*
class PostCell: UITableViewCell
{
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timeAgoLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postStatsLabel: UILabel!
    
    var post: Posts! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI()
    {
        profileImageView.image = post.createdBy.profileImage
        usernameLabel.text = post.createdBy.username
        timeAgoLabel.text = post.timeAgo
        captionLabel.text = post.caption
        postImageView.image = post.image
        postStatsLabel.text = "\(post.numberOfLikes!) Likes     \(post.numberOfComments!) Comments     \(post.numberOfShares!) Shares"
    }
 
 
}


*/





