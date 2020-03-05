//
//  NewsfeedCollectionViewController.swift
//  Facebook+Research
//
//  Created by Duc Tran on 3/20/17.
//  Copyright © 2017 Developers Academy. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import Firebase


class NewsfeedCollectionViewController : UICollectionViewController
{
    var searchController: UISearchController!
    //var posts = [Posts] ()
    
    var posts = [Posts] ()
    
    @IBOutlet var feedCollections: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("entro a la nueva collection")
        
        advengers.shared.usersStatusRef.queryOrderedByKey().observe(.value) { (datasnap) in
            
            let userinfo = datasnap.value as! [String:NSDictionary]
            
            for (key, value) in userinfo {
                
                if key == Auth.auth().currentUser?.uid {
                    advengers.shared.currenUSer["userid"] = value["userid"] as! String
                    advengers.shared.currenUSer["email"] = value["email"] as! String
                    advengers.shared.currenUSer["name"] = value["name"] as! String
                    advengers.shared.currenUSer["photoURL"] = value["photoURL"] as! String
                    advengers.shared.currenUSer["church"] = value["church"] as! String
                    advengers.shared.currentChurch = value["church"] as! String
                }
            }
            
            self.fetchPost()
        }
      
        
        collectionView?.contentInset = UIEdgeInsets(top: 12, left: 4, bottom: 12, right: 4)
        
        if let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: 200, height: 300)
        }
    }
  
    /*
    func fetchPosts()
    {
        self.posts = Post.fetchPosts()
        self.collectionView?.reloadData()
    }
 
 */
    
    func fetchPost () {
        print("Fechea ")
        advengers.shared.postPrayFeed.queryOrderedByKey().observe(.value) { (data) in
            
            self.posts.removeAll()
            
            if let postfeed = data.value as? [String:NSDictionary] {
                
                for (_,value) in postfeed
                {
                    //      let eachpost = value as! [String:Any]
                    
                    let temporarioPost = Posts (dictionary: postfeed)
                    
                    /*
                    temporarioPost.author = value["author"] as? String
                    temporarioPost.photoImage = value["pathtoPost"] as? String
                    temporarioPost.likes = value["prays"] as? Int
                    temporarioPost.userPhoto = value["userPhoto"] as! String
                    temporarioPost.postID = value["postID"] as! String
                    temporarioPost.userID = value["userid"] as? String
                    temporarioPost.postType = value["postType"] as? String
                    temporarioPost.message = value["message"] as? String
 */
                    self.posts.append(temporarioPost)
                    self.collectionView.reloadData()
                    print("Cargo uno")
                   // self.feedCollections.reloadData()
                    
                  //  self.feedCollection.reloadData()
                    
                    
                    
                }
                
                
            }
        }
    }
    
}



extension NewsfeedCollectionViewController
{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as! PostCollectionViewCell
        
        
        cell.captionLabel.text = self.posts[indexPath.item].message
        cell.postImageView.downloadImage(imgURL: self.posts[indexPath.row].photoImage)
        cell.postImageView.layer.cornerRadius = 5.0
        cell.postImageView.layer.masksToBounds = true
        
        
     //    cell.post = self.posts[indexPath.item]
        
        /*
        
        
        cell.profileImageView.downloadImage(imgURL: posts[indexPath.row].userPhoto)
        cell.profileImageView.layer.cornerRadius = 3.0
        cell.profileImageView.layer.masksToBounds = true
        
        cell.captionLabel.text = posts[indexPath.row].message
        cell.usernameLabel.text = posts[indexPath.row].author
        //  timeAgoLabel.text = post.timeAgo
        
        
        cell.postImageView.downloadImage(imgURL: posts[indexPath.row].photoImage)
        cell.postImageView.layer.cornerRadius = 5.0
        cell.postImageView.layer.masksToBounds = true
 
 */
        
        return cell
    }
}

















