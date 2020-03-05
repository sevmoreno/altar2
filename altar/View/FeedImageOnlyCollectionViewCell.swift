//
//  FeedImageOnlyCollectionViewCell.swift
//  altar
//
//  Created by Juan Moreno on 11/18/19.
//  Copyright © 2019 Juan Moreno. All rights reserved.
//

import UIKit
import Firebase

class FeedImageOnlyCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var fotoAuthor: UIImageView!
    @IBOutlet weak var nameAutor: UILabel!
    @IBOutlet weak var praysCount: UILabel!
    @IBOutlet weak var postImagen: UIImageView!
    
    @IBOutlet weak var prayForIt: UIButton!
    var postID: String!
    
    @IBAction func prayForIT(_ sender: Any) {
        
        advengers.shared.postPrayFeed.childByAutoId().key
        print(postID)
        
        advengers.shared.postPrayFeed.child(self.postID!).observeSingleEvent(of: .value) { (data, cadena) in
            
            if let contendio = data.value as? [String:AnyObject] {
                if  var junta: [String] = contendio["peopleWhoPrayed"] as? [String]
                {
                    
                    
                    junta.append(Auth.auth().currentUser!.uid)
                    
                    let updatePrayed: [String:AnyObject] = ["peopleWhoPrayed/": junta as AnyObject]
                    advengers.shared.postPrayFeed.child(self.postID).updateChildValues(updatePrayed)
                    
                    let updateCount: [String:AnyObject] = ["prays": junta.count as AnyObject]
                    advengers.shared.postPrayFeed.child(self.postID).updateChildValues(updateCount)
                    self.praysCount.text = "\(String(junta.count))"
                    
                }
                
                // let updatePrayed: [String:AnyObject] = ["peopleWhoPrayed/": [Auth.auth().currentUser?.uid] as AnyObject]
                
            }
            /*
             if let contendio = data.value as? [String:AnyObject]
             {
             if let updatePrayed: [String:AnyObject] = ["peopleWhoPrayed/\(self.postID)": Auth.auth().currentUser?.uid] {
             
             //advengers.shared.postPrayFeed.child(self.postID).updateChildValues(updatePrayed)
             }
             
             
             }
             */
        }
        
        prayForIt.isEnabled = false
        advengers.shared.postPrayFeed.child(self.postID!).removeAllObservers()
        
        
    }
}
