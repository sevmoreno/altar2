

import UIKit
import AVFoundation
import Firebase

class PhotoStreamViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, ImageOnlyDelegate,textOnlyDelegate, textImageDelegate, AudibleDelegate  {
    
    func deletCellD(for cell: AnnotatedPhotoCell) {
        
        guard let indexPath = collectionView?.indexPath(for: cell) else { return }
        
        var post =  self.photos[indexPath.item]
        
        guard let postId = post.postID else { return }
        
        Database.database().reference().child("post_pray_feed").child(advengers.shared.currentChurchInfo.uidChurch).child(postId).removeValue()
        
        self.collectionView?.deleteItems(at: [indexPath])
        self.photos.remove(at: indexPath.row)
        self.collectionView.reloadData()
    }
    
    func deletCellD(for cell: PhotoTextoCollectionViewCell) {
        guard let indexPath = collectionView?.indexPath(for: cell) else { return }
        
        var post =  self.photos[indexPath.item]
        
        guard let postId = post.postID else { return }
        
        Database.database().reference().child("post_pray_feed").child(advengers.shared.currentChurchInfo.uidChurch).child(postId).removeValue()
        
        self.collectionView?.deleteItems(at: [indexPath])
        self.photos.remove(at: indexPath.row)
        self.collectionView.reloadData()
    }
    
    func deletCellD(for cell: AudioCollectionViewCell) {
        
        guard let indexPath = collectionView?.indexPath(for: cell) else { return }
        
        var post =  self.photos[indexPath.item]
        
        guard let postId = post.postID else { return }
        
        Database.database().reference().child("post_pray_feed").child(advengers.shared.currentChurchInfo.uidChurch).child(postId).removeValue()
        
        self.collectionView?.deleteItems(at: [indexPath])
        self.photos.remove(at: indexPath.row)
        self.collectionView.reloadData()
        
    }
    
    
    
    func deletCellD(for cell: textOnlyCell) {
        
        guard let indexPath = collectionView?.indexPath(for: cell) else { return }
        
        var post =  self.photos[indexPath.item]
        
        guard let postId = post.postID else { return }
        
        Database.database().reference().child("post_pray_feed").child(advengers.shared.currentChurchInfo.uidChurch).child(postId).removeValue()
        
        self.collectionView?.deleteItems(at: [indexPath])
        self.photos.remove(at: indexPath.row)
        self.collectionView.reloadData()
    }
    
    func AudibleDelegate_didTapComment(post: Posts) {
        
        print("llego al protocolo")
        
        let commentsController = CommentsController(collectionViewLayout: UICollectionViewFlowLayout())
        commentsController.post = post
        navigationController?.pushViewController(commentsController, animated: true)
    }
    
    func AudibleDelegate_didLike(for cell: AudioCollectionViewCell) {
        
        
        print("llego al protocolo")
        
        guard let indexPath = collectionView?.indexPath(for: cell) else { return }
        
        var post =  self.photos[indexPath.item]
        
        
        
        guard let postId = post.postID else { return }
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        
        post.hasLiked = true
        let values = [uid: post.hasLiked]
        
        
        
        
        //      let values = [uid: post.hasLiked == true ? 0 : 1]
        Database.database().reference().child("likes").child(postId).updateChildValues(values) { (err, _) in
            
            if let err = err {
                print("Failed to like post lista de likes", err)
                return
            }
            
            print("Lista de likes ok.")
            
            
            post.likes = post.likes + 1
            
            let cuentadeLikes = ["prays": post.likes!,
                                 
            ]
            guard let currentChurchID = advengers.shared.currenUSer["churchID"] as? String else { return }
            Database.database().reference().child("post_pray_feed").child(currentChurchID).child(postId).updateChildValues(cuentadeLikes) { (err, _) in
                
                if let err = err {
                    print("Failed to like post:", err)
                    return
                }
                
                print("Successfully actualiza el post")
                
                
                
                //     self.handleUpdateFeed()
                
                
                self.photos[indexPath.item] = post
                
                self.collectionView?.reloadItems(at: [indexPath])
                
            }
            
            
            
        }
        
    }
    
    
    func textImageDelegate_didTapComment(post: Posts) {
        
        print("llego al protocolo")
        
        let commentsController = CommentsController(collectionViewLayout: UICollectionViewFlowLayout())
        commentsController.post = post
        navigationController?.pushViewController(commentsController, animated: true)
    }
    
    func textImageDelegate_didLike(for cell: PhotoTextoCollectionViewCell) {
        

        
        guard let indexPath = collectionView?.indexPath(for: cell) else { return }
        
        var post =  self.photos[indexPath.item]

        
        
        guard let postId = post.postID else { return }
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        
        post.hasLiked = true
        let values = [uid: post.hasLiked]
        
        
        
        
        //      let values = [uid: post.hasLiked == true ? 0 : 1]
        Database.database().reference().child("likes").child(postId).updateChildValues(values) { (err, _) in
            
            if let err = err {
                print("Failed to like post lista de likes", err)
                return
            }
            
            print("Lista de likes ok.")
            
            
            post.likes = post.likes + 1
            
            let cuentadeLikes = ["prays": post.likes!,
                                 
            ]
            
            guard let currentChurchID = advengers.shared.currenUSer["churchID"] as? String else { return }
            Database.database().reference().child("post_pray_feed").child(currentChurchID).child(postId).updateChildValues(cuentadeLikes) { (err, _) in
                
                if let err = err {
                    print("Failed to like post:", err)
                    return
                }
                
                print("Successfully actualiza el post")
                
                
                
                self.photos[indexPath.item] = post
                
                self.collectionView.reloadData()
              //  self.collectionView?.reloadItems(at: [indexPath])
                
            }
            
            
            
        }
        
        
        
    }
    
    // TEXT & IMAGE FRECATORE THIS PLEASE  !!!
    
    
    func textOnlyDelegate_didTapComment(post: Posts) {
        
        print("llego al protocolo")
        
        let commentsController = CommentsController(collectionViewLayout: UICollectionViewFlowLayout())
        commentsController.post = post
        navigationController?.pushViewController(commentsController, animated: true)
        
    }
    
    func textOnlyDelegate_didLike(for cell: textOnlyCell) {

        
        guard let indexPath = collectionView?.indexPath(for: cell) else { return }
        
        var post =  self.photos[indexPath.item]

        
        guard let postId = post.postID else { return }
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        
        post.hasLiked = true
        let values = [uid: post.hasLiked]
        
        
        
        
        //      let values = [uid: post.hasLiked == true ? 0 : 1]
        Database.database().reference().child("likes").child(postId).updateChildValues(values) { (err, _) in
            
            if let err = err {
                print("Failed to like post lista de likes", err)
                return
            }
            
            print("Lista de likes ok.")
            
            
            post.likes = post.likes + 1
            
            let cuentadeLikes = ["prays": post.likes!,
                                 
            ]
            
            guard let currentChurchID = advengers.shared.currenUSer["churchID"] as? String else { return }
            Database.database().reference().child("post_pray_feed").child(currentChurchID).child(postId).updateChildValues(cuentadeLikes) { (err, _) in
                
                if let err = err {
                    print("Failed to like post:", err)
                    return
                }
                
                print("Successfully actualiza el post")
                
                
                
                
                
                self.photos[indexPath.item] = post
                
                self.collectionView?.reloadItems(at: [indexPath])
                
            }
            
            
            
        }
        
        
        
        
    }
    
    
    
    //------------------------ ImageOnlyDelegate
    
    func ImageOnlyDelegate_didLike(for cell: AnnotatedPhotoCell) {

        
        guard let indexPath = collectionView?.indexPath(for: cell) else { return }
        
        var post =  self.photos[indexPath.item]

        guard let postId = post.postID else { return }
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        
        post.hasLiked = true
        let values = [uid: post.hasLiked]
        
        Database.database().reference().child("likes").child(postId).updateChildValues(values) { (err, _) in
            
            if let err = err {
                print("Failed to like post lista de likes", err)
                return
            }
            
            print("Lista de likes ok.")
            
            
            post.likes = post.likes + 1
            
            let cuentadeLikes = ["prays": post.likes!,
                                 
            ]
            
            guard let currentChurchID = advengers.shared.currenUSer["churchID"] as? String else { return }
            Database.database().reference().child("post_pray_feed").child(currentChurchID).child(postId).updateChildValues(cuentadeLikes) { (err, _) in
                
                if let err = err {
                    print("Failed to like post:", err)
                    return
                }
                
                print("Successfully actualiza el post")
                
                
                
                self.photos[indexPath.item] = post
                
                self.collectionView?.reloadItems(at: [indexPath])
                
            }
            
            
            
        }
        
        
        
    }
    
    
    
    func ImageOnlyDelegate_didTapComment(post: Posts) {
        print("llego al protocolo")
        
        let commentsController = CommentsController(collectionViewLayout: UICollectionViewFlowLayout())
        commentsController.post = post
        navigationController?.pushViewController(commentsController, animated: true)
    }
    
    
    //------------------------------------------------------
    
    /*
     
     func didLike(for cell: AnnotatedPhotoCell) {
     
     print("llego al protocolo")
     guard let indexPath = collectionView?.indexPath(for: cell) else { return }
     
     var post =  self.photos[indexPath.item]
     
     
     
     
     guard let postId = post.postID else { return }
     
     guard let uid = Auth.auth().currentUser?.uid else { return }
     
     let values = [uid: post.hasLiked == true ? 0 : 1]
     Database.database().reference().child("likes").child(postId).updateChildValues(values) { (err, _) in
     
     if let err = err {
     print("Failed to like post:", err)
     return
     }
     
     print("Successfully liked post.")
     
     post.hasLiked = !post.hasLiked
     
     self.photos[indexPath.item] = post
     
     self.collectionView?.reloadItems(at: [indexPath])
     
     }
     }
     
     func didLike(for cell: textOnlyCell) {
     guard let indexPath = collectionView?.indexPath(for: cell) else { return }
     
     var post =  self.photos[indexPath.item]
     print(post.message)
     
     
     
     guard let postId = post.postID else { return }
     
     guard let uid = Auth.auth().currentUser?.uid else { return }
     
     let values = [uid: post.hasLiked == true ? 0 : 1]
     Database.database().reference().child("likes").child(postId).updateChildValues(values) { (err, _) in
     
     if let err = err {
     print("Failed to like post:", err)
     return
     }
     
     print("Successfully liked post.")
     
     post.hasLiked = !post.hasLiked
     
     self.photos[indexPath.item] = post
     
     self.collectionView?.reloadItems(at: [indexPath])
     
     }
     }
     
     
     
     func didTapComment(post: Posts) {
     print("Message coming from HomeController")
     
     let commentsController = CommentsController(collectionViewLayout: UICollectionViewFlowLayout())
     commentsController.post = post
     navigationController?.pushViewController(commentsController, animated: true)
     }
     
     */
    
    let cellId = "cellId"
    var photos = [Posts] ()
    let refreshControl = UIRefreshControl()
    let accountHelper = AccountHelpers()
    
    
    
    override func viewDidLoad() {
        // NotificationCenter.default.addObserver(self, selector: #selector(handleDelete), name: NSNotification.Name(rawValue: "DeleteCell"), object: nil)
        accountHelper.loadCurrentUserInfo(completionHandler: { (success) -> Void in
            
            if success {
              
                self.loadEverything ()
                
                self.accountHelper.loadCurrentChurch(codigo: advengers.shared.currenUSer["churchID"] as! String,completionHandler: { (success) -> Void in
                    
                    if success {
                        
                        
                    }
                    
                })
            }
            
        })
        //   loadCurrentUserInfo ()
        
        
        // collectionView?.contentInset = UIEdgeInsets(top: 23, left: 16, bottom: 10, right: 16)
        
       
        
    }
    
    
    @objc func handleDelete (index: Int) {
        
        print("Delete")
    }
    
    
    func loadEverything () {
        // NotificationCenter.default.addObserver(self, selector: #selector(handleUpdateFeed), name: NSNotification.Name("Up"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleUpdateFeed), name: NSNotification.Name(rawValue: "UpdateFeed"), object: nil)
        
        collectionView?.register(AnnotatedPhotoCell.self, forCellWithReuseIdentifier: "OtraPostCell")
        collectionView?.register(textOnlyCell.self, forCellWithReuseIdentifier: "textOnlyCelll")
        
        collectionView?.register(PhotoTextoCollectionViewCell.self, forCellWithReuseIdentifier: "textImageCell")
        
        
        collectionView?.register(AudioCollectionViewCell.self, forCellWithReuseIdentifier: "audioCell")
        
        collectionView?.backgroundColor =  UIColor.rgb(red: 32, green: 36, blue: 47)
        
        
        //               // TODO: REFACTORIAR, OJO CON LAS FUNCONES QUE EJCUTAN LOS BOTONES // ----------------------------
        //               // ---------------------------------------------------------------------------------------------
        //               navigationController?.navigationBar.backgroundColor = advengers.shared.colorBlue
        //               navigationController?.navigationBar.barTintColor = advengers.shared.colorBlue
        //
        //               navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "settingsincon"), style: .plain, target: self, action: #selector(logoutFirebase))
        //               navigationItem.leftBarButtonItem?.tintColor = advengers.shared.colorOrange
        //
        //
        //               let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,
        //                                     NSAttributedString.Key.font:UIFont(name: "Avenir-Heavy", size: 15)]
        //               navigationController?.navigationBar.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
        //
        //
        //
        //               navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+ Prayer", style: .plain, target: self, action: #selector(addprayer))
        //               let textAttributes2 = [NSAttributedString.Key.foregroundColor: advengers.shared.colorOrange,
        //                                      NSAttributedString.Key.font:UIFont(name: "Avenir-Heavy", size: 17)]
        //
        //               navigationItem.rightBarButtonItem?.setTitleTextAttributes(textAttributes2 as [NSAttributedString.Key : Any], for: .normal)
        //               navigationItem.rightBarButtonItem?.tintColor = advengers.shared.colorOrange
        //
        //               navigationItem.title = advengers.shared.currentChurch
        
        
        collectionView.reloadData()
        // -----------------------------------------------------------------------------------------
        
        // ----------- solo para tener impresas las fuentes BORRAR LUEGO
        /*
         for family: String in UIFont.familyNames {
         print("\(family)")
         for names: String in UIFont.fontNames(forFamilyName: family) {
         print("== \(names)")
         }
         }
         */
        // ---------------------
        
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView?.refreshControl = refreshControl
        
        fetchPost ()
        
        
        
        
    }
    
    
    
    
    @objc func handleRefresh() {
        photos.removeAll()
        fetchPost ()
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
        }
    }
    
    @objc func handleUpdateFeed() {
        
        
        
        photos.removeAll()
        collectionView.reloadData()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+ Prayer", style: .plain, target: self, action: #selector(addprayer))
        let textAttributes2 = [NSAttributedString.Key.foregroundColor: advengers.shared.colorOrange,
                               NSAttributedString.Key.font:UIFont(name: "Avenir-Heavy", size: 17)]
        
        navigationItem.rightBarButtonItem?.setTitleTextAttributes(textAttributes2 as [NSAttributedString.Key : Any], for: .normal)
        navigationItem.rightBarButtonItem?.tintColor = advengers.shared.colorOrange
        fetchPost ()
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // TODO: REFACTORIAR, OJO CON LAS FUNCONES QUE EJCUTAN LOS BOTONES // ----------------------------
        // ---------------------------------------------------------------------------------------------
        navigationController?.navigationBar.backgroundColor = advengers.shared.colorBlue
        navigationController?.navigationBar.barTintColor = advengers.shared.colorBlue
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "settingsincon"), style: .plain, target: self, action: #selector(logoutFirebase))
        navigationItem.leftBarButtonItem?.tintColor = advengers.shared.colorOrange
        
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,
                              NSAttributedString.Key.font:UIFont(name: "Avenir-Heavy", size: 15)]
        navigationController?.navigationBar.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
        
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+ Prayer", style: .plain, target: self, action: #selector(addprayer))
        let textAttributes2 = [NSAttributedString.Key.foregroundColor: advengers.shared.colorOrange,
                               NSAttributedString.Key.font:UIFont(name: "Avenir-Heavy", size: 17)]
        
        navigationItem.rightBarButtonItem?.setTitleTextAttributes(textAttributes2 as [NSAttributedString.Key : Any], for: .normal)
        navigationItem.rightBarButtonItem?.tintColor = advengers.shared.colorOrange
        
        navigationItem.title = advengers.shared.currentChurch
    }
    
    @objc func logoutFirebase () {
        
        
        
        
//
//
        let settingsController = SettingsViewController()
//
//
      //    navigationController?.pushViewController(settingsController, animated: true)
        
     let navController = UINavigationController(rootViewController: settingsController)
        
       present(navController, animated: true, completion: nil)
    
    }
    
    
    @objc func addprayer () {
        
        performSegue(withIdentifier: "prueba", sender: self)
        
    }
    
    
    func fetchPost () {
        
        guard let currentChurchID = advengers.shared.currenUSer["churchID"] as? String else { return }
        
        //  ref.observeSingleEvent(of: .value, with: { (snapshot) in
        //  print("Fechea ")
        advengers.shared.postPrayFeed.child(currentChurchID).observeSingleEvent(of: .value, with: { (data) in
            
            // self.photos.removeAll()
            
            if let postfeed = data.value as? [String:NSDictionary] {
                
                for (_,value) in postfeed
                {
                    
                    
                    let temporarioPost = Posts (dictionary: value as! [String : Any])
                    print("Esta lleyendo la altura ???")
                    print(temporarioPost.photoW)
                    print(temporarioPost.photoH)
                    print("---------------------")
                    print(self.view.frame.width)
                    print(self.view.frame.height)
                    
                    
                    
                    self.photos.append(temporarioPost)
                    
                    self.photos.sort(by: { (p1, p2) -> Bool in
                        return p1.creationDate?.compare(p2.creationDate!) == .orderedDescending
                    })
                    
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                    
                    
                    
                }
                
                
            }
        })
    }
    
    func loadCurrentUserInfo () {
        
        advengers.shared.usersStatusRef.queryOrderedByKey().observe(.value) { (datasnap) in
            
            guard let userinfo = datasnap.value as? [String:NSDictionary] else {return}
            
            
            for (key, value) in userinfo {
                
                if key == Auth.auth().currentUser?.uid {
                    advengers.shared.currenUSer["userid"] = value["userid"] as? String
                    advengers.shared.currenUSer["email"] = value["email"] as? String
                    advengers.shared.currenUSer["name"] = value["name"] as? String
                    advengers.shared.currenUSer["photoURL"] = value["photoURL"] as? String
                    advengers.shared.currenUSer["church"] = value["church"] as? String
                    advengers.shared.currentChurch = (value["church"] as? String)!
                }
            }
            
        }
        
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 3.0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        if photos[indexPath.row].postType == advengers.postType.textOnly.rawValue {
            
            
            let botones: CGFloat = 50.0
            let usuarioInfo: CGFloat = 50.0
            
            let dummyframe = CGRect(x: 0, y: 0, width: view.frame.width, height: 1000)
            let dummycell = textOnlyCell (frame: dummyframe)
            dummycell.captionLabel.text = photos[indexPath.row].message
            
            
            
            
            let size = CGSize(width: view.frame.width, height: .infinity)
            let texto = dummycell.captionLabel.sizeThatFits(size)
            
            
            return CGSize(width: view.frame.width, height:  usuarioInfo + botones + texto.height + 50 )
            
        }
        
        if photos[indexPath.row].postType == advengers.postType.textImage.rawValue {
            
            let botones: CGFloat = 50.0
            let usuarioInfo: CGFloat = 50.0
            
            let dummyframe = CGRect(x: 0, y: 0, width: view.frame.width, height: 1000)
            let dummycell = textOnlyCell (frame: dummyframe)
            dummycell.captionLabel.text = photos[indexPath.row].message
            
            
            
            
            let size = CGSize(width: view.frame.width, height: .infinity)
            let texto = dummycell.captionLabel.sizeThatFits(size)
            
            let imageRatio = CGFloat(photos[indexPath.row].photoW! / photos[indexPath.row].photoH!)
            
            
            return CGSize(width: view.frame.width, height:  usuarioInfo + botones + texto.height  + (view.frame.width /  imageRatio)  ) 
            
            
        }
        
        if photos[indexPath.row].postType == advengers.postType.audio.rawValue {
            let botones: CGFloat = 50.0
            let usuarioInfo: CGFloat = 50.0
            
            
            return CGSize(width: view.frame.width, height:  usuarioInfo + botones + 200 )
            
            
            
            
            
            
        }
            
            
            
        else {
            
            
            let botones: CGFloat = 50.0
            let usuarioInfo: CGFloat = 50.0
            
            
            
            let imageRatio = CGFloat(photos[indexPath.row].photoW! / photos[indexPath.row].photoH!)
            
            
            return CGSize(width: view.frame.width, height:  usuarioInfo + botones + (view.frame.width /  imageRatio) )
            
        }
        
        
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch photos[indexPath.item].postType {
            
        case advengers.postType.imageOnly.rawValue:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OtraPostCell", for: indexPath as IndexPath) as! AnnotatedPhotoCell
            cell.contentView.backgroundColor = .white
            cell.delegate = self
            cell.post = photos[indexPath.item]
            return cell
            
            
        case advengers.postType.textOnly.rawValue:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "textOnlyCelll", for: indexPath as IndexPath) as! textOnlyCell
            cell.contentView.backgroundColor = .white
            cell.delegate = self
            cell.post = photos[indexPath.item]
            return cell
            
            //textImage
            
        case advengers.postType.textImage.rawValue:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "textImageCell", for: indexPath as IndexPath) as! PhotoTextoCollectionViewCell
            cell.delegate = self
            cell.contentView.backgroundColor = .white
            cell.post = photos[indexPath.item]
            return cell
            
        case advengers.postType.audio.rawValue:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "audioCell", for: indexPath as IndexPath) as! AudioCollectionViewCell
            cell.delegate = self
            cell.contentView.backgroundColor = .white
            cell.post = photos[indexPath.item]
            return cell
            
        default:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "textOnlyCelll", for: indexPath as IndexPath) as! textOnlyCell
            cell.contentView.backgroundColor = .white
            cell.post = photos[indexPath.item]
            cell.delegate = self
            return cell
        }
        
        
        
    }
    
    /* TODO: PEFRECCIONAR ESTA FUNCION
     
     override func collectionView(_ collectionView: UICollectionView,
     didEndDisplaying cell: UICollectionViewCell,
     forItemAt indexPath: IndexPath) {
     
     if photos[indexPath.item].postType == advengers.postType.audio.rawValue {
     let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "audioCell", for: indexPath as IndexPath) as! AudioCollectionViewCell
     
     print("Se fue la Cel de Audio")
     cell.audioPlayer?.stop()
     }
     }
     */
    
}



/*
 func didLike(for cell: AnnotatedPhotoCell) {
 
 print("llego al protocolo")
 guard let indexPath = collectionView?.indexPath(for: cell) else { return }
 
 var post =  self.photos[indexPath.item]
 print(post.message)
 
 
 
 guard let postId = post.postID else { return }
 
 guard let uid = Auth.auth().currentUser?.uid else { return }
 
 let values = [uid: post.hasLiked == true ? 0 : 1]
 Database.database().reference().child("likes").child(postId).updateChildValues(values) { (err, _) in
 
 if let err = err {
 print("Failed to like post:", err)
 return
 }
 
 print("Successfully liked post.")
 
 post.hasLiked = !post.hasLiked
 
 self.photos[indexPath.item] = post
 
 self.collectionView?.reloadItems(at: [indexPath])
 
 }
 }
 */
