//
//  ChannelSeleccionadoViewController.swift
//  altar
//
//  Created by Juan Moreno on 2/20/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//
import Firebase
import UIKit
import AVFoundation

class ChannelSeleccionadoViewController: UIViewController {

    
           var canciones = [wSong] ()
    
            var audioPlayer: AVAudioPlayer?

           var cannal: wChannel? {
               
               didSet {
                  
                     guard let imagenDevo = cannal!.photoURL else { return }
                   
                    imagenDevocional.loadImage(urlString: imagenDevo)
                   
                   guard let titulotext = cannal?.title else { return }
                   
                   titulo.text = titulotext
                   
                   
                   subTitulo.text = cannal?.subtitle
                   
                   let fecha = cannal?.creationDate
                            //  let fecha = Date(milliseconds: Int64(post?.creationDate ?? 0))
                              
                 //x  praysDate.text = fecha!.timeAgoDisplay()
                   /*
                   
                   guard let postImageUrl = post?.photoImage else { return }
             
                   
                   photoImageView.loadImage(urlString: postImageUrl)

                   usernameLabel.text = post?.author
                   guard let profileuserURL = post?.userPhoto else {return}
                   userProfileImageView.loadImage(urlString: profileuserURL)


                   // --------------- CODE POST DESIGN   --------------------------
                   if post!.likes  > 0 {
                       likeButton.setImage(UIImage(named: "cellprayiconRed")?.withRenderingMode(.alwaysOriginal), for: .normal)
                   
                   } else {
                       
                       likeButton.setImage(UIImage(named: "cellPrayIcon")?.withRenderingMode(.alwaysOriginal), for: .normal)
                   }
                   
                   likeCount.text = " " + String(post!.likes) + " Praying "
                   
                   if let tiene = post?.comments {
                   commentCount.text = String(tiene)
                   }
                   
                   let fecha = post?.creationDate
                 //  let fecha = Date(milliseconds: Int64(post?.creationDate ?? 0))
                   
                   praysDate.text = fecha!.timeAgoDisplay()
                   
                   // ==========================================================
                   setupAttributedCaption()
                   
                  */
               }
               

           }
           
           lazy var audioView: UIButton = {
                   let iv = UIButton(type: .system)
                  // iv.setTitle("Play", for: .normal)
                   iv.setImage(#imageLiteral(resourceName: "payAudio").withRenderingMode(.alwaysOriginal), for: .normal)
                iv.alpha = 0.6
                 //  iv.setTitleColor(.black, for: .normal)
                   //  iv.contentMode = .scaleAspectFill
                //   iv.layer.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)


            iv.addTarget(self, action: #selector (actiononPlay), for: .touchUpInside)
                   return iv
               }()

    @objc func actiononPlay () {
               
        if isPlaying {
            
            audioView.setImage(#imageLiteral(resourceName: "payAudio").withRenderingMode(.alwaysOriginal), for: .normal)
            audioPlayer?.stop()
            status.text = "               "
        }
               
           }
    
           
           lazy var imagenDevocional: CustomImageView = {
               let iv = CustomImageView()
               
               
               iv.contentMode = .scaleToFill
               
               iv.clipsToBounds = true
               iv.layer.masksToBounds = true
               iv.contentMode = .scaleAspectFit
               iv.layer.cornerRadius = 22
    
               return iv
           }()
           
           lazy var titulo: UILabel = {
                     let label2 = UILabel ()
                     label2.font = UIFont(name: "Avenir-Black", size: 25)
                     label2.text = "You prayed 1"
                  label2.textColor = .white
                  //   button.setImage(UIImage(named: "cellPrayIcon")?.withRenderingMode(.alwaysOriginal), for: .normal)
                    // button.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
                     return label2
                 }()
           
//           lazy var praysDate: UILabel = {
//                        let label2 = UILabel ()
//                        label2.font = UIFont(name: "Avenir-Black", size: 12)
//                        label2.text = ""
//                        label2.textColor = .white
//                        label2.layer.backgroundColor = advengers.shared.colorOrange.cgColor
//               label2.layer.cornerRadius = 5
//               label2.padding = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
//                     //   button.setImage(UIImage(named: "cellPrayIcon")?.withRenderingMode(.alwaysOriginal), for: .normal)
//                       // button.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
//                        return label2
//                    }()
       
       lazy var subTitulo: UILabel = {
           let label2 = UILabel ()
           label2.font = UIFont(name: "Avenir-Black", size: 14)
           label2.text = "Instrumentl Praise & Worship"
        label2.textColor = .white
           label2.alpha = 0.8
        //   button.setImage(UIImage(named: "cellPrayIcon")?.withRenderingMode(.alwaysOriginal), for: .normal)
          // button.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
           return label2
       }()
    
    
    lazy var status: UILabel = {
          let label2 = UILabel ()
          label2.font = UIFont(name: "Avenir-Black", size: 14)
          label2.text = "                 "
       label2.textColor = .white
        label2.textAlignment = .center
          label2.alpha = 0.8
       //   button.setImage(UIImage(named: "cellPrayIcon")?.withRenderingMode(.alwaysOriginal), for: .normal)
         // button.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
          return label2
      }()
    
    
    var selectChannel: UIButton = {
        
        
             let a = UIButton ()
    
             a.backgroundColor = UIColor.rgb(red: 247, green: 131, blue: 97)
             a.layer.cornerRadius = 22
             a.layer.masksToBounds = true
             a.setTitleColor(.white , for: .normal)
             a.setTitle("Select Channel", for: .normal)
             a.setTitleColor(UIColor.white.withAlphaComponent(0.3), for: .highlighted )
             a.addTarget(self, action: #selector (selectChannelActive), for: .touchUpInside)
             return a
         }()
    
    
    @objc func selectChannelActive () {
        
        let time = NSDate ()
        let codigoIglesia  = advengers.shared.currenUSer["churchID"] as? String
        loadCurrentChurch(codigo: codigoIglesia!)
        let tiempo: Int = Int(time.timeIntervalSince1970)
        let dictionario = ["channelActiveTime":tiempo,
        
                           "channelActive": cannal?.channelID
        ] as? [String:Any]
        let userPostRef = Database.database().reference().child("Churchs").child(codigoIglesia!).updateChildValues(dictionario!)
        _ = navigationController?.popToRootViewController(animated: true)
        
                                       //   userPostRef.observeSingleEvent(of: .value, with: { (data) in
//
//                                                     print("Entro a ver")
//                                                     print(data.value)
//                                                      if let devoFeed = data.value as? [String:Any] {
//                                                          let cancion = wSong()
//                                                          cancion.load(dictionary: devoFeed)
//
//                                                          self.canciones.append(cancion)
//
//
//                                                                        }
//
//                                                     completionHandler(true)
//
//                                       //      self.channelActivo = true
//
//                                                    }, withCancel: { (err) in
//
//                                                     completionHandler(false)
//                                                     print("Failed to fetch like info for post:", err)
//                                                    })
//
//
//                 }
        
        
        
    }
    
    var tabladeCanciones = UITableView ()
        
     
           
           func loadTracks (track: String, completionHandler: @escaping (_ :Bool) -> Void) {
               let userPostRef = Database.database().reference().child("Media_Songs").child(track)
                                
                                    userPostRef.observeSingleEvent(of: .value, with: { (data) in
                                               
                                        
                                                if let devoFeed = data.value as? [String:Any] {
                                                    let cancion = wSong()
                                                    cancion.load(dictionary: devoFeed)
                                                    
                                                    self.canciones.append(cancion)
                                                   
                                                   
                                                                  }
                                               
                                               completionHandler(true)

                                 //      self.channelActivo = true
                                       
                                              }, withCancel: { (err) in
                                               
                                               completionHandler(false)
                                               print("Failed to fetch like info for post:", err)
                                              })
                                    
               
           }
  
      var isPlaying = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tabladeCanciones.delegate = self
        tabladeCanciones.dataSource = self
        tabladeCanciones.backgroundColor = .clear
        
        for codigo in cannal!.lista {
            
            loadTracks(track: codigo, completionHandler: { (success) -> Void in
           print(success)
                self.tabladeCanciones.reloadData()
            })
            
            
        }


        tabladeCanciones.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        view.backgroundColor = advengers.shared.colorBlue
        
        view.addSubview(imagenDevocional)
                     
                     imagenDevocional.contentMode = .scaleAspectFill
        imagenDevocional.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 100, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 300,height: 300)
                   imagenDevocional.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(status)
        status.anchor(top: nil, left: nil, bottom: imagenDevocional.bottomAnchor, right:nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: 100, height: 0)
        status.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(audioView)
        audioView.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 250, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 50,height: 50)
        audioView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    //    audioView.centerYAnchor.constraint(equalTo: imagenDevocional.centerYAnchor).isActive = true
        
                     view.addSubview(titulo)
                     
        titulo.anchor(top: imagenDevocional.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        titulo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
                     
                     view.addSubview(subTitulo)
                     
                     
                     subTitulo.anchor(top: titulo.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
                subTitulo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        
        view.addSubview(tabladeCanciones)
        tabladeCanciones.anchor(top: subTitulo.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 4, paddingLeft: 0, paddingBottom: 150, paddingRight: 0, width: 0, height: 0)
        
        
        view.addSubview(selectChannel)
       selectChannel.anchor(top: tabladeCanciones.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 40)
        selectChannel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//
        selectChannel.backgroundColor = UIColor.rgb(red: 247, green: 131, blue: 97)
               selectChannel.layer.cornerRadius = 22
               selectChannel.layer.masksToBounds = true
               selectChannel.setTitleColor(.white , for: .normal)
               selectChannel.setTitle("Select Channel", for: .normal)
               selectChannel.setTitleColor(UIColor.white.withAlphaComponent(0.3), for: .highlighted )
               selectChannel.applyGradient(colors: [WelcomeViewController.UIColorFromRGB(0xF78361).cgColor,WelcomeViewController.UIColorFromRGB(0xF54B64).cgColor])
//
                   //  imagenDevocional.image = UIImage(named: "devoback1")
                     
                     
//                     view.addSubview(praysDate)
//                     praysDate.anchor(top: nil, left: titulo.leftAnchor, bottom: titulo.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: 0, height: 0)
                     
        // Do any additional setup after loading the view.
    }
    

 func loadCurrentChurch (codigo: String) {
    
    //  let referenciaDB = Database.database()
    
    // .observeSingleEvent(of: .value, with: { (snapshot) in
    
    print("Este es el codigo")
    print(codigo)
    
    let userPostRef = Database.database().reference().child("Churchs").child(codigo)
    //let userPostRef = Database.database().reference().child("Media_Channels")
    userPostRef.observeSingleEvent(of: .value, with: { (data) in
        
      
        if let devoFeed = data.value as? [String:Any] {
            
            
            advengers.shared.currentChurchInfo = Church(dictionary: devoFeed)
            
          
            
            
        }
        
        
    }, withCancel: { (err) in
        print("Failed to fetch like info for post:", err)
    })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}



extension ChannelSeleccionadoViewController: UITableViewDelegate, UITableViewDataSource {


func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   // return users.count
    
    return canciones.count
    
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
    
    
    var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UITableViewCell
    

     cell.backgroundColor = .clear
    cell.textLabel?.textAlignment = .center
    cell.textLabel?.textColor = .white
    cell.textLabel?.alpha = 0.80
    cell.textLabel?.font = UIFont(name: "Avenir", size: 14)
    cell.textLabel?.text = canciones[indexPath.row].title
    
    
    
 
    cell.detailTextLabel?.textAlignment = .center
    cell.detailTextLabel?.textColor = .white
    cell.detailTextLabel?.alpha = 0.80
    cell.detailTextLabel?.font = UIFont(name: "Avenir", size: 10)
    //cell.detailTextLabel?.text = canciones[indexPath.row].author ?? "unknown"
    cell.detailTextLabel?.text = "unknown"
    return cell
    
}
     
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        isPlaying = true
        audioView.setImage(#imageLiteral(resourceName: "pausebutton").withRenderingMode(.alwaysOriginal), for: .normal)
        
        self.status.text = "Loading ...."
        let storage = Storage.storage()
                      
                       let httpsReference = storage.reference(forURL: canciones[indexPath.row].songURL)

                                       httpsReference.getData(maxSize: 100 * 1024 * 1024) { data, error in
                                        
                                         if let error = error {
                                           print("Error Playing")
                                           print(error.localizedDescription)
                                         } else {

                                             self.playContent(data: data!)
                                            // self.statusAudio.isHidden = true

                                         }

                                     }
        
    }
        

    
        func playContent (data: Data)
                  
              {
                  
                  
                  do {
                      
                      audioPlayer = try AVAudioPlayer(data: data)
                      audioPlayer?.play()
                    status.text = "Playing ...."
                      print("Playing ....")
                    
                  } catch {
                      print ("No Playing")
                      //print(url.absoluteString)
                  }
                  
                  
                  
                  
              }
    
    
    
    
}


