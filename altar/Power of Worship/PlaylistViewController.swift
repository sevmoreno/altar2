//
//  PlaylistViewController.swift
//  altar
//
//  Created by Juan Moreno on 1/16/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase

class PlayListViewController: UICollectionViewController,  UICollectionViewDelegateFlowLayout   {
    
    
       let cellId = "cellId"
       var channel = [wChannel] ()
       
       override func viewDidLoad() {
            NotificationCenter.default.addObserver(self, selector: #selector(reloadChannesl), name: NSNotification.Name("reloadChannesl"), object: nil)
        
    //       collectionView?.register(DevotionalCollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerWord")

        
           collectionView?.register(ChannelCollectionViewCell.self, forCellWithReuseIdentifier: "oldWord")
          // collectionView?.register(textOnlyCell.self, forCellWithReuseIdentifier: "textOnlyCelll")
         collectionView?.backgroundColor = advengers.shared.colorBlue
        

           //navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Prayer", style: .plain, target: self, action: #selector(addprayer))
        
        self.collectionView.reloadData()
        
        
        
         //   navigationItem.title = advengers.shared.currentChurch
        
        // TODO: REFACTORIAR, OJO CON LAS FUNCONES QUE EJCUTAN LOS BOTONES // ----------------------------
               // ---------------------------------------------------------------------------------------------
               navigationController?.navigationBar.backgroundColor = advengers.shared.colorBlue
               navigationController?.navigationBar.barTintColor = advengers.shared.colorBlue
               
           //    navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "settingsincon"), style: .plain, target: self, action: #selector(settings))
        
             navigationItem.leftBarButtonItem?.tintColor = advengers.shared.colorOrange
               
               
               let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,
                                     NSAttributedString.Key.font:UIFont(name: "Avenir-Heavy", size: 15)]
               navigationController?.navigationBar.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
               
               
               
               
               if advengers.shared.isPastor {
                   
                   navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Select Channel", style: .plain, target: self, action: #selector(addDevotional))
                   
               }
        
               let textAttributes2 = [NSAttributedString.Key.foregroundColor: advengers.shared.colorOrange,
                                             NSAttributedString.Key.font:UIFont(name: "Avenir-Heavy", size: 12)]
               
               navigationItem.rightBarButtonItem?.setTitleTextAttributes(textAttributes2 as [NSAttributedString.Key : Any], for: .normal)
               navigationItem.rightBarButtonItem?.tintColor = advengers.shared.colorOrange
               
               navigationItem.title = advengers.shared.currentChurch
               
               // -----------------------------------------------------------------------------------------
        
        
        loadChannels ()

       
           
       }
    
    
    @objc func reloadChannesl () {
        channel.removeAll()
        loadChannels()
        collectionView?.reloadData()
    }
    
    @objc func settings () {
        
        
              let settingsController = SettingsViewController()
             // navigationController?.pushViewController(signUpController, animated: true)
              
               present(settingsController, animated: true, completion: nil)
    }
    
    func loadChannels () {
        
      //  let referenciaDB = Database.database()
        
        // .observeSingleEvent(of: .value, with: { (snapshot) in
          let userPostRef = Database.database().reference().child("Media_Channels")
            userPostRef.observeSingleEvent(of: .value, with: { (data) in
            
            
             if let devoFeed = data.value as? [String:NSDictionary] {
                                   
                                   for (_,value) in devoFeed
                                   {
                                    
                                    var channelT  = wChannel()
                                    channelT.load(dictionary: value as! [String : Any])
                                    
            //                        devocional.title = value["title"] as? String
            //                        devocional.message = value["texto"] as? String
            //                        devocional.urltexto = value["urltexto"] as? String
            //                        devocional.creationDate = value["creationDate"] as? String
                                  //  print(value)
//                          f
                                    
                                    self.channel.append(channelT)
                                    
                                    print("Esta es la lista de cannales:")
                                    print(channelT.lista)
                                    print(channelT.title)
                                    
                                    //   let temporarioPost = Posts (dictionary: value as! [String : Any])
                                       
                                      
                       //                self.photos.append(temporariost)
                         //              self.collectionView.reloadData()

                                    self.collectionView.reloadData()
                                   }
                                   
                                   
                               }
            
            
           }, withCancel: { (err) in
            print("Failed to fetch like info for post:", err)
           })
        
        
        
       /*
        
        Database.database().reference().child ("devocionales").child(advengers.shared.currentChurch).queryOrderedByKey().observe(.value) { (data) in
                   
                  // self.photos.removeAll()
                   
                   if let devoFeed = data.value as? [String:NSDictionary] {
                       
                       for (_,value) in devoFeed
                       {

                        var devocional  = Devo (dictionary: value as! [String : Any])
                        
//                        devocional.title = value["title"] as? String
//                        devocional.message = value["texto"] as? String
//                        devocional.urltexto = value["urltexto"] as? String
//                        devocional.creationDate = value["creationDate"] as? String
                      //  print(value)
                    print(devocional.title!)
                    print(devocional.message!)
                        print(devocional.photoURL!)
                        
                        self.devos.append(devocional)
                        
                        
                        //   let temporarioPost = Posts (dictionary: value as! [String : Any])
                           
                          
           //                self.photos.append(temporariost)
             //              self.collectionView.reloadData()

                        self.collectionView.reloadData()
                       }
                       
                       
                   }
               }
        
        */
        
    }
    
    
    
    
       
       @objc func addDevotional () {
           
           performSegue(withIdentifier: "buildDummy", sender: self)

       }
       
       

       
       func loadCurrentUserInfo () {
              
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
                  
              }
              
              
              
          }
    
    
    
 // ------------------------------------------------------------------------ HEADER  -----------------------------------------------------------------------------------
    
  /*
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerWord", for: indexPath) as! DevotionalCollectionViewCell
        header.viewGeneral.backgroundColor = .red
        
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        if devos.count == 1 {
            
            return CGSize(width: view.frame.width, height: view.frame.height)
            
        } else {
        
        
        return CGSize(width: view.frame.width, height: view.frame.height)
            
            
        }
        
        
    }
    
*/
    
    // ------------------------------------------------------------------------------------------------------------------------------------------------------------------
    
    // ------------------------------------------------------------------ COLLECTION CELLS -----------------------------------------------------------------------------

       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

              return 3.0

      }
       
  
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

   
        return CGSize(width: view.frame.width, height: view.frame.height / 4)
    }
    
       
       override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          
          print ("Devos Count")
          print(channel.count)
        
          return channel.count
        
            // return photos.count
       }
       
       override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           
        
    
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "oldWord", for: indexPath) as? ChannelCollectionViewCell
      
        
        cell?.post = channel[indexPath.row]
        return cell!
        
       }
 
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    //    performSegue(withIdentifier: "aChannelSelecction", sender: self)
       
          let a = ChannelSeleccionadoViewController ()
        
        a.cannal = channel[indexPath.row]
        
        navigationController?.pushViewController(a, animated: true)
        
    }
    
    

        
       
    
}
