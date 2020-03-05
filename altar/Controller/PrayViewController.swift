//
//  PrayViewController.swift
//  altar
//
//  Created by Juan Moreno on 9/16/19.
//  Copyright © 2019 Juan Moreno. All rights reserved.
//

import UIKit
import Firebase

class PrayViewController: UIViewController {

    @IBOutlet weak var feedCollection: UICollectionView!
    var posts = [Posts] ()
    
    private let reuseIdentifier = "feedImage"
    private let itemsPerRow: CGFloat = 1
    private let sectionInsets = UIEdgeInsets(top: 50.0,
                                             left: 20.0,
                                             bottom: 50.0,
                                             right: 20.0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ------ DEL TUTORIAL RAYWENDRICH
        
     //   if let layout = feedCollection.collectionViewLayout as? PrayCollectionViewLayout {
  //          layout.delegate = self
     //   }

        
        // ----------------------
        
        self.feedCollection.reloadData()
        self.feedCollection.layoutIfNeeded()
        
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
        
        

    }
  
    func fetchPost () {
        
        advengers.shared.postPrayFeed.queryOrderedByKey().observe(.value) { (data) in
            
            self.posts.removeAll()
            
            if let postfeed = data.value as? [String:NSDictionary] {
            
            for (_,value) in postfeed
            {
          //      let eachpost = value as! [String:Any]
            
                /*
                let diction: [String:Any] = [
                    
                    "author":"temporario",
                    "pathtoPost" : "",
                    "prays": "",
                    "userPhoto": "",
                    "postID":"",
                    "userid":"",
                    
                ]
 
 */
                
                let temporarioPost = Posts (dictionary: postfeed)
              //  temporarioPost.author = value["author"] as! String
              //  temporarioPost.photoImage = value["pathtoPost"] as? String
              //  temporarioPost.likes = value["prays"] as! Int
              //  temporarioPost.userPhoto = value["userPhoto"] as! String
              //  temporarioPost.postID = value["postID"] as! String
              //  temporarioPost.userID = value["userid"] as! String
               // temporarioPost.postType = value["postType"] as! String
              
                self.posts.append(temporarioPost)
                
                
                self.feedCollection.reloadData()
              
                
                
            }
            
            
        }
        }
    }
    

}
extension PrayViewController: UICollectionViewDelegate, UICollectionViewDataSource  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        print("Tipo de post \(posts[indexPath.row].postType)")
        
        switch posts[indexPath.row].postType {
            
        case advengers.postType.imageOnly.rawValue:
            
            print ("IMAGE ONLY")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "feedImage", for: indexPath) as! FeedImageOnlyCollectionViewCell
            cell.fotoAuthor.downloadImage(imgURL: posts[indexPath.row].userPhoto)
            cell.postImagen.downloadImage(imgURL: posts[indexPath.row].photoImage ?? "gs://altar-92d12.appspot.com/post_pray_feed/SuGgNEE2drVVBd5fLnw6Q2cbfc12/-LpFra4bipDDspKXcuML.jpg")
            cell.nameAutor.text = posts[indexPath.row].author
            cell.praysCount.text = String (posts[indexPath.row].likes) + "Prayed"
            cell.postID = posts[indexPath.row].postID
            
            
            return cell
            
         case advengers.postType.textOnly.rawValue:
            
            print ("TEXT ONLY")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnlyText", for: indexPath) as! FeedOnlyTextCollectionViewCell
            cell.fotoAuthor.downloadImage(imgURL: posts[indexPath.row].userPhoto)
            cell.message.text = posts[indexPath.row].message
            cell.nameAutor.text = posts[indexPath.row].author
            cell.praysCount.text = String (posts[indexPath.row].likes) + "Prayed"
            cell.postID = posts[indexPath.row].postID
            
            
            return cell
          
         case advengers.postType.textImage.rawValue:
            
       
             print ("DEFAULT")
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "feed", for: indexPath) as! FeedCollectionViewCell
             cell.fotoAuthor.downloadImage(imgURL: posts[indexPath.row].userPhoto)
             cell.postImagen.downloadImage(imgURL: posts[indexPath.row].photoImage ?? "gs://altar-92d12.appspot.com/post_pray_feed/SuGgNEE2drVVBd5fLnw6Q2cbfc12/-LpFra4bipDDspKXcuML.jpg")
             cell.message.text = posts[indexPath.row].message
             cell.nameAutor.text = posts[indexPath.row].author
             cell.praysCount.text = String (posts[indexPath.row].likes) + "Prayed"
             cell.postID = posts[indexPath.row].postID
             
             
             return cell
            
            
        default:
            
            /*
            print ("DEFAULT")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "feed", for: indexPath) as! FeedCollectionViewCell
            cell.fotoAuthor.downloadImage(imgURL: posts[indexPath.row].userPhoto)
            cell.postImagen.downloadImage(imgURL: posts[indexPath.row].photoImage ?? "gs://altar-92d12.appspot.com/post_pray_feed/SuGgNEE2drVVBd5fLnw6Q2cbfc12/-LpFra4bipDDspKXcuML.jpg")
            cell.nameAutor.text = posts[indexPath.row].author
            cell.praysCount.text = String (posts[indexPath.row].likes) + "Prayed"
            cell.postID = posts[indexPath.row].postID
            
            
            return cell
    */
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "feed", for: indexPath) as! FeedCollectionViewCell
            return cell
        }
        
        
    }
    
    
    
   
}


/*
extension PrayViewController: UICollectionViewDelegateFlowLayout {
    
    
  
    
    // MARK: - Collection View Flow Layout Delegate

        //1
    
    
        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            sizeForItemAt indexPath: IndexPath) -> CGSize {
            //2
            let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
            let availableWidth = view.frame.width - paddingSpace
            let widthPerItem = availableWidth / itemsPerRow
            
            return CGSize(width: widthPerItem, height: widthPerItem)
        }
        
        //3
        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            insetForSectionAt section: Int) -> UIEdgeInsets {
            return sectionInsets
        }
        
        // 4
        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return sectionInsets.left
        }

    
 
}
*/

// --------------- DEL TUTORIAL RAYWENDRICH
/*
extension PrayViewController: PinterestLayoutDelegate {
    
    
    
    func collectionView(
        _ collectionView: UICollectionView,
        heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
        
        var imagen = UIImageView ()
        imagen.downloadImage(imgURL: posts[indexPath.row].userPhoto)
        
        
       // return imagen.image!.size.height
        
        return 200.0
        

    }
}

// ------------
*/

