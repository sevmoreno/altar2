//
//  PrayViewController.swift
//  altar
//
//  Created by Juan Moreno on 9/13/19.
//  Copyright © 2019 Juan Moreno. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import MessageKit
import SDWebImage
import InputBarAccessoryView

class UsersViewController: UIViewController, UIScrollViewDelegate {
    
    
    
    
    @IBOutlet weak var tablaUsuarios: UITableView!
    
    @IBOutlet weak var contenedor: UIView!
    
    var users = [User] ()
    @IBOutlet weak var pageController: UIPageControl!
    var slides:[Slide3Type] = []
    var eventos:[Event] = []
    @IBOutlet var scrollView: UIScrollView!
    
    
    // let chat = ChatViewController ()
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageController.currentPage = Int(pageIndex)
        
        let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
        let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x
        
        //       vertical
        let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
        let currentVerticalOffset: CGFloat = scrollView.contentOffset.y
        
        let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
        let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset
        
        
 
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
  
        setupSlideScrollView(slides: slides)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.backgroundColor = advengers.shared.colorBlue
        navigationController?.navigationBar.barTintColor = advengers.shared.colorBlue
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "settingsincon"), style: .plain, target: self, action: #selector(logout))
        
        navigationItem.leftBarButtonItem?.tintColor = advengers.shared.colorOrange
        
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,
                              NSAttributedString.Key.font:UIFont(name: "Avenir-Heavy", size: 15)]
        navigationController?.navigationBar.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
        
        
        
        
        if advengers.shared.isPastor {
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+ Event", style: .plain, target: self, action: #selector(addEnvent))
            
        }
        
        let textAttributes2 = [NSAttributedString.Key.foregroundColor: advengers.shared.colorOrange,
                               NSAttributedString.Key.font:UIFont(name: "Avenir-Heavy", size: 15)]
        
        navigationItem.rightBarButtonItem?.setTitleTextAttributes(textAttributes2 as [NSAttributedString.Key : Any], for: .normal)
        navigationItem.rightBarButtonItem?.tintColor = advengers.shared.colorOrange
        
        navigationItem.title = advengers.shared.currentChurch
    }
    
    
    
    
    
    override func viewDidLoad() {
      
       // mewMessageSearch ()
        super.viewDidLoad()
        
        generateEvents ()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: NSNotification.Name(rawValue: "loadEvent"), object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(deleteEvent), name: NSNotification.Name(rawValue: "deleteEvent"), object: nil)
        // loadEvent
        //   contenedor.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        
        tablaUsuarios.backgroundColor = advengers.shared.colorBlue
        
        tablaUsuarios.delegate = self
        tablaUsuarios.dataSource = self
        
        view.backgroundColor = advengers.shared.colorBlue
        scrollView.delegate = self
        
        
    
        retriveUsers ()
        
        
        newSearchForMessage ()
        
        
 
    }
    
    var messages: [Message] = []
    private var docReference: DocumentReference?
    
    
    var fistTime = false
    func newSearchForMessage () {
        
        // Aqui agarro las COLLECCIONES DONDE USUARIO ESTE
        let databaseMessageRef = Firestore.firestore().collection("Chats").whereField("users", arrayContains: Auth.auth().currentUser?.uid ?? "Not Found User 1")
      
        
        
        // AGARRO LOS DOCUMENTOS BAJO LA COLLECION CHATS Y QUE SEAN DEL USUARIO
    
        databaseMessageRef.getDocuments {  querySnapshot, error in
        guard let snapshot = querySnapshot else {
          print("Error listening for channel updates: \(error?.localizedDescription ?? "No error")")
          return
        }
            
            
            
         // AHORA TENGO TODOS LOS DOCUMENTOS
            print("Encontro esta cantidad de Documentos o chats digamos")
            print(snapshot.documents.count)
            
            for cadaChat in snapshot.documents {
             
                // CREAMOS UN LISTENER PARA CADA DOCUMENTO Y LEEMOS UN CREAMOS LISTENER PARA CADA THREAD
                cadaChat.reference.collection("thread").order(by: "created", descending: false).addSnapshotListener(includeMetadataChanges: true, listener: { (threadQuery, error) in
                    
                    
                    if let error = error {
                        print("Error: \(error)")
                        return
                    } else {
                        
                        print("Cuenta cuantos mensajes hay en el chat: \(threadQuery?.documents.count)")
                        let source = threadQuery?.metadata.isFromCache
                        if source! { return }
                        print("Es del cache o nuevot \(source)")
                        // HORA LO QUE HAGO ES QUE EL LISENER SE DISPARE CUANDO SOLO HAY UN CAMBIO EN LA PRIERMA DATA
                        threadQuery?.documentChanges.forEach { diff in
                            
                            if (diff.type == .added) {
                                
                               // print("New chat: \(diff.document.data())")
                               print("NUEVO ELEMENTO DE CHAT ")
                            }
                            if (diff.type == .modified) {
                                //   print("Modified city: \(diff.document.data())")
                            }
                            if (diff.type == .removed) {
                                // print("Removed city: \(diff.document.data())")
                            }
                        }
                        
                    }
                        
                    
                })
                
                
            }
        
        
        }
            
            
    }
    
 
        
    func generateEvents () {
        slides.removeAll()
        eventos.removeAll()
        
        print("Lllego a buscar eventos")
        
        loadEvents(completionHandler: { (success) -> Void in
            
            
            
            if self.eventos.count == 0 {
                
                let slide1 = Slide3Type ()
                
                print("Creando uno vacio")
                
                slide1.photoImageView.image = UIImage(named: "Background")
                slide1.usernameLabel.text =  ""
                
                self.slides.append(slide1)
                //  self.setupSlideScrollView(slides: self.slides)
                
                
                
            } else  {
                
                
                self.slides = self.createSlides()
                self.setupSlideScrollView(slides: self.slides)
                
                
            }

        })
        
        
        if self.eventos.count == 0 {
            
            let slide1 = Slide3Type ()
            
            print("Creando uno vacio")
            
            slide1.photoImageView.image = UIImage(named: "Background")
            slide1.usernameLabel.text =  "All your event in one place"
            
            self.slides.append(slide1)
            self.setupSlideScrollView(slides: self.slides)
            
        }
        
    }

    
    func loadEvents (completionHandler: @escaping (_ success:Bool) -> Void) {
   
        guard let currentChurchID = advengers.shared.currenUSer["churchID"] as? String else { return }
        Database.database().reference().child ("Events").child(currentChurchID).observeSingleEvent(of: .value, with: { (data) in
            
            
            if let devoFeed = data.value as? [String:NSDictionary] {
                
                for (_,value) in devoFeed
                {
                    
                    let even  = Event (dictionary: value as! [String : Any])
                    
                    
                    
                    
                    self.eventos.append(even)
                    
                    
                    let a = Slide3Type ()
                    
                    a.even?.photoURL = even.photoURL
                    a.even?.title = even.title
                    
                    self.slides.append(a)
        
                }
                
                completionHandler(true)
            }
            
            
        }, withCancel: { (err) in
            print("Failed to fetch like info for post:", err)
            completionHandler(false)
        })
    }
    
    
    func createSlides() -> [Slide3Type] {
        
        var fechados = [Slide3Type] ()

        for elementos in eventos {
            
            let slide1 = Slide3Type ()
            
            
            slide1.photoImageView.loadImage(urlString: elementos.photoURL)
            slide1.usernameLabel.text =  elementos.title
            
            fechados.append(slide1)
            //            }
            
        }
   
        return fechados
    }
    
    //
    func setupSlideScrollView(slides : [Slide3Type]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 383)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: 383)
        scrollView.isPagingEnabled = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        tap.numberOfTapsRequired = 1
        scrollView.addGestureRecognizer(tap)
        pageController.numberOfPages = slides.count
        scrollView.contentInsetAdjustmentBehavior = .never
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: 383)
            scrollView.addSubview(slides[i])
        }
    }
    
    @objc func doubleTapped () {
        print ("Double tap")
        print (pageController.currentPage)
        advengers.shared.eventolSeleccinado = eventos[pageController.currentPage]
        advengers.shared.eventolSeleccinadoIndex = pageController.currentPage
        
        let devocionalSeleccionado = EventoSeleccionado ()
        // performSegue(withIdentifier: "aEvent", sender: self)
        navigationController?.pushViewController(devocionalSeleccionado, animated: true)
        
    }
    

    @objc func addEnvent()  {
        
        performSegue(withIdentifier: "addEvent", sender: self)
    }
    
    func retriveUsers () -> Void {
        
        advengers.shared.usersStatusRef.queryOrderedByKey().observe(.value) { (datasnap) in
            let usersRead = datasnap.value as! [ String : NSDictionary]
            //self.users.removeAll()
            
            for (_,value) in usersRead {
                
                
                if let userid = value["userid"] as? String {
                    
                    
                    
                    if userid != Auth.auth().currentUser?.uid
                    {
                        if advengers.shared.currentChurch == value["church"] as? String {
                            
                            let userToShow = User()
                            userToShow.setup(uid: value["userid"] as? String ?? "", dictionary:  value as! [String : Any])
                            
                            //                            let userToShow = User(uid: value["userid"] as? String ?? "", dictionary: value as! [String : Any])
                            //                            userToShow.userID = value["userid"] as? String ?? ""
                            //                            userToShow.fullName = value["name"] as? String ?? ""
                            //                            userToShow.email = value["email"] as? String ?? ""
                            //                            userToShow.photoUser = value["photoURL"] as? String ?? ""
                            
                            self.users.append(userToShow)
                            self.tablaUsuarios.reloadData()
                            
                        }
                        
                        
                    }
                }
            }
            
            
            
        }
        // advengers.shared.usersStatusRef.removeAllObservers()
        
    }
    
    @IBAction func logout(_ sender: Any) {
        
        
        let settingsController = SettingsViewController()
        // navigationController?.pushViewController(signUpController, animated: true)
        
        present(settingsController, animated: true, completion: nil)
        
    }
    
    @IBAction func reloadData(_ sender: Any) {
        
        
        print(self.users.count)
        
     //   self.users = users.sorted { $0.fullName < $1.fullName }
        self.tablaUsuarios.reloadData()
        
        DispatchQueue.main.async {
            self.generateEvents()
        }
        
        
    }
    
    
    @objc func deleteEvent () {
        
        
        
        Database.database().reference().child("Events").child(advengers.shared.eventolSeleccinado.church).child(advengers.shared.eventolSeleccinado.postID).removeValue()
        eventos.remove(at: advengers.shared.eventolSeleccinadoIndex)
        
        
        DispatchQueue.main.async {
            self.generateEvents()
        }
        
        
    }
    
}



extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return users.count
        
        return users.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellA", for: indexPath) as! UsuariosUITableTableViewCell
        
        cell.foto.loadImage(urlString: users[indexPath.row].photoUser)
        
        DispatchQueue.main.async {
//            print("este es el full name")
//            print(self.users[indexPath.row].fullName)
            cell.nombre.text = self.users[indexPath.row].fullName
//            print(cell.nombre.text)
        }
        
        
      
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
         let chat = ChatViewController ()
        chat.user2Name = users[indexPath.row].fullName
        chat.user2UID = users[indexPath.row].uid
        chat.user2ImgUrl = users[indexPath.row].photoUser
        navigationController?.pushViewController(chat, animated: true)
        
        
    }
    
    
    
}



extension UsersViewController: UITextViewDelegate {
    
    
}
