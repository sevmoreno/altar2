//
//  PowerOfWorshipViewController.swift
//  altar
//
//  Created by Juan Moreno on 1/6/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//

import UIKit
import AVFoundation
// import WebKit
// import Alamofire
import Firebase



class PowerOfWorshipViewController:  UIViewController, AVAudioPlayerDelegate{
    
    
    
    //  var channelActivo = wChannel(dictionary: ["":""])
    
    var audioPlayer: AVAudioPlayer?
    let storage = Storage.storage()
    var delegate: AudibleDelegate?
    var indexPlaylist = 0
    var isPlaying = false
    
    var cannalActivo = wChannel()
    
    lazy var statusAudio: UILabel = {
        let label2 = UILabel ()
        label2.font = UIFont(name: "Avenir-Medium", size: 12)
        label2.text = "Loading audio file ..."
        label2.textColor = .white
        //   button.setImage(UIImage(named: "cellPrayIcon")?.withRenderingMode(.alwaysOriginal), for: .normal)
        // button.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
        return label2
    }()
    
    
    
    
    lazy var nameChannel: UILabel = {
        let label2 = UILabel ()
        label2.font = UIFont(name: "Avenir-Heavy", size: 20)
        label2.text = "You prayed 1"
        label2.textColor = .white
        label2.textAlignment = .center
        
        return label2
    }()
    
    
    lazy var subtitulo: UILabel = {
        let label2 = UILabel ()
        label2.font = UIFont(name: "Avenir-Medium", size: 15)
        label2.text = "0000"
        
        return label2
    }()
    
    
    lazy var commentCount: UILabel = {
        let label2 = UILabel ()
        label2.font = UIFont(name: "Avenir-Medium", size: 15)
        label2.text = "    "
        
        return label2
    }()
    
    
    let backgroundChannel: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        
        return iv
    }()
    
    lazy var audioView: UIButton = {
        let iv = UIButton(type: .system)

        iv.setImage(#imageLiteral(resourceName: "payAudio").withRenderingMode(.alwaysOriginal), for: .normal)
        iv.alpha = 0.6

        iv.addTarget(self, action: #selector (activarChannel), for: .touchUpInside)
        return iv
    }()
    
    
    
    lazy var audioViewBack: UIView = {
        
        let a = UIView()
        let fondo: String = {
            
            return "fondo" + String(Int.random(in: 1..<5))
        } ()
        
        let imagen = UIImageView(image: UIImage(named: fondo))
        
        imagen.contentMode = .scaleAspectFit
        
        //   a.bounds = CGRect(x: 0, y: 0, width: frame.width, height: 80)
        a.addSubview(imagen)
        a.alpha = 0.6
        
        
        return a
    } ()
    
    
    let tituloCancion: UILabel = {
           let label = UILabel()
           label.text = ""
        label.textColor = .white
           label.font = UIFont(name: "Avenir-Heavy", size: 22)
           return label
       }()
    
    
    let estadodelPlay: UILabel = {
           let label = UILabel()
           label.text = ""
        label.textColor = .white
           label.font = UIFont(name: "Avenir", size: 14)
           return label
       }()
    
    
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let optionsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("•••", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    @objc func Logout () {
        
        let settingsController = SettingsViewController()
        // navigationController?.pushViewController(signUpController, animated: true)
        
        present(settingsController, animated: true, completion: nil)
    }
    
    
    @objc func addPlaylist () {
        
        performSegue(withIdentifier: "addPlaylist", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        navigationController?.navigationBar.backgroundColor = advengers.shared.colorBlue
               navigationController?.navigationBar.barTintColor = advengers.shared.colorBlue
               
               navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "settingsincon"), style: .plain, target: self, action: #selector(Logout))
               
               navigationItem.leftBarButtonItem?.tintColor = advengers.shared.colorOrange
               
               
               let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,
                                     NSAttributedString.Key.font:UIFont(name: "Avenir-Heavy", size: 15)]
               navigationController?.navigationBar.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
               
               
               
               
               if advengers.shared.isPastor {
                   
                   // navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+ Devotional", style: .plain, target: self, action: #selector(addDevotional))
                   navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Select Channel", style: .plain, target: self, action: #selector(addPlaylist))
                   
               }
               
               let textAttributes2 = [NSAttributedString.Key.foregroundColor: advengers.shared.colorOrange,
                                      NSAttributedString.Key.font:UIFont(name: "Avenir-Heavy", size: 12)]
               
               navigationItem.rightBarButtonItem?.setTitleTextAttributes(textAttributes2 as [NSAttributedString.Key : Any], for: .normal)
               
               
               navigationItem.rightBarButtonItem?.tintColor = advengers.shared.colorOrange
               
               navigationItem.title = advengers.shared.currentChurch
    }
    
    override func viewDidLoad() {
      //  audioPlayer?.delegate = self
        
        view.backgroundColor = advengers.shared.colorBlue
        // TODO: REFACTORIAR, OJO CON LAS FUNCONES QUE EJCUTAN LOS BOTONES // ----------------------------
        // ---------------------------------------------------------------------------------------------
//        navigationController?.navigationBar.backgroundColor = advengers.shared.colorBlue
//        navigationController?.navigationBar.barTintColor = advengers.shared.colorBlue
//
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "settingsincon"), style: .plain, target: self, action: #selector(Logout))
//
//        navigationItem.leftBarButtonItem?.tintColor = advengers.shared.colorOrange
//
//
//        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,
//                              NSAttributedString.Key.font:UIFont(name: "Avenir-Heavy", size: 15)]
//        navigationController?.navigationBar.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
//
//
//
//
//        if advengers.shared.isPastor {
//
//            // navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+ Devotional", style: .plain, target: self, action: #selector(addDevotional))
//            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Select Channel", style: .plain, target: self, action: #selector(addPlaylist))
//
//        }
//
//        let textAttributes2 = [NSAttributedString.Key.foregroundColor: advengers.shared.colorOrange,
//                               NSAttributedString.Key.font:UIFont(name: "Avenir-Heavy", size: 12)]
//
//        navigationItem.rightBarButtonItem?.setTitleTextAttributes(textAttributes2 as [NSAttributedString.Key : Any], for: .normal)
//
//
//        navigationItem.rightBarButtonItem?.tintColor = advengers.shared.colorOrange
//
//        navigationItem.title = advengers.shared.currentChurch
        
        // -----------------------------------------------------------------------------------------
        
        
        view.addSubview(backgroundChannel)
        
        backgroundChannel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        
        view.addSubview(audioView)
        
        audioView.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 100, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        
        print("Current church codigo")
        print(advengers.shared.currenUSer["churchID"] as? String)
        loadCurrentChurch(codigo: advengers.shared.currenUSer["churchID"] as? String ?? "")
        
        
        
        print(advengers.shared.currentChurchInfo.channelActive)
        audioView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        audioView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        loadActiveChannel(codigo: advengers.shared.currentChurchInfo.channelActive)
        
        
        view.addSubview(nameChannel)
        
        
        nameChannel.anchor(top: audioView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 50, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width - 20, height: 0)
        nameChannel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        view.addSubview(subtitulo)
        
        subtitulo.textAlignment = .center
        subtitulo.textColor = .white
        
        
        subtitulo.anchor(top: nameChannel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width - 20, height: 0)
        subtitulo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(tituloCancion)
        view.addSubview(estadodelPlay)
        
        tituloCancion.anchor(top: audioView.centerYAnchor, left: nil, bottom: nil, right: nil, paddingTop: 100, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 400, height: 0)
        tituloCancion.centerXAnchor.constraint(equalTo: audioView.centerXAnchor).isActive = true
        tituloCancion.textAlignment = .center
        tituloCancion.sizeToFit()
        estadodelPlay.anchor(top: nil, left: nil, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 80, paddingRight: 0, width: 200, height: 0)
        estadodelPlay.textAlignment = .center
        estadodelPlay.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    var urlSongs = [wSong] ()
    
    typealias CompletionHandler = (_ :Bool) -> Void
    
    
    func loadCurrentChurch (codigo: String) {
        
        //  let referenciaDB = Database.database()
        
        // .observeSingleEvent(of: .value, with: { (snapshot) in
        
        print("Este es el codigo")
        print(codigo)
        
        let userPostRef = Database.database().reference().child("Churchs").child(codigo)
        //let userPostRef = Database.database().reference().child("Media_Channels")
        userPostRef.observeSingleEvent(of: .value, with: { (data) in
            
            print("Entro a ver")
            print(data.value)
            if let devoFeed = data.value as? [String:Any] {
                
                
                advengers.shared.currentChurchInfo = Church(dictionary: devoFeed)
                
         
                
                
            }
            
            
        }, withCancel: { (err) in
            print("Failed to fetch like info for post:", err)
        })
        
        
    }
    
    
    func loadActiveChannel (codigo: String) {
        
        //  let referenciaDB = Database.database()
        
        // .observeSingleEvent(of: .value, with: { (snapshot) in
        
        print("Este es el codigo")
        print(codigo)
        
        let userPostRef = Database.database().reference().child("Media_Channels").child(codigo)
        //let userPostRef = Database.database().reference().child("Media_Channels")
        userPostRef.observeSingleEvent(of: .value, with: { (data) in
            
            print("Entro a ver")
            print(data.value)
            if let devoFeed = data.value as? [String:Any] {
                
                
                
                self.cannalActivo.load(dictionary: devoFeed)
                print("Esta es la info del active channel:")
                //  print(self.cannalActivo.church)
                print(self.cannalActivo.title)
                
                for nombre in self.cannalActivo.lista
                {
                    print(nombre)
                }
                
                
                
                DispatchQueue.main.async {
                    self.backgroundChannel.loadImage(urlString: self.cannalActivo.photoURL)
                    self.nameChannel.text = self.cannalActivo.title
                    self.subtitulo.text = self.cannalActivo.subtitle
                }
                
                
                
            }
            
            
        }, withCancel: { (err) in
            print("Failed to fetch like info for post:", err)
        })
        
        
    }
    
    
    func loadTrack (track: String, completionHandler: @escaping CompletionHandler) -> wSong {
        let userPostRef = Database.database().reference().child("Media_Songs").child(track)
        
        var Acancion = wSong()
        userPostRef.observeSingleEvent(of: .value, with: { (data) in
            
            print("Entro a ver")
            print(data.value)
            if let devoFeed = data.value as? [String:Any] {
                
                Acancion.load(dictionary: devoFeed)
                
               // self.urlSongs.append(cancion)
                
               
            }
            
            completionHandler(true)
            
            self.channelActivo = true
            
          
            
        }, withCancel: { (err) in
            
            
            print("Failed to fetch like info for post:", err)
        })
        
        
        return Acancion
    }
    
    
    var channelActivo = false
    
  
    
    @objc func activarChannel ()  {
        
        
        // tengo un array con los codigos
        // necesito saber las duraciones: trackDuation, totalChannelDuraction
        // necesito saber cuando se activo el canal: dateActivation
        // necesito saber cuando lo actvioahora.... nowTime
        
        
        //
        
        // searchdate = dateActivation
        // for searchdate < now {
        //  for tema in channelduraction {
        //          searchdate = searchdate + tema
        //     if seachDate >= now {
        //              tema -> esta sonando
        //      }
        //  }
        //}
        //
        //
        // u otra forma
        //  nowTime - dateActivation = globalDeTiempo / totalChannelDuration = cuantas veces playlist
        //
        //  porDonde = (cuantas veces playlist * totalChannelDuration) + date/Activation
        
        //  for tema in channelduraction {
        //          porDonde = porDonde + tema
        //     if porDonde >= now {
        //              tema -> esta sonando
        //      }
        
        //
        
        
        
        // 1 CARGAMOS TODOS LOS TEMAS
        
        
        if !isPlaying {
                   
                   
                   audioView.setImage(#imageLiteral(resourceName: "pausebutton").withRenderingMode(.alwaysOriginal), for: .normal)
                   isPlaying = true
        
    
          
            for (index,track) in cannalActivo.lista.enumerated() {
                      
                     let a = loadTrack (track: track, completionHandler: { (true) -> Void in
                          
//                          if self.channelActivo != false {
//                              self.playNow ()
//                          }
                        
                        if index == self.cannalActivo.lista.endIndex-1 {
                    
                            let time = NSDate ()
                            
                            
                            let cuantasVeces = (Int(time.timeIntervalSince1970) - advengers.shared.currentChurchInfo.channelActiveTime) / self.cannalActivo.channelDuration
                            print("Cuantas Veces")
                            print(cuantasVeces)
                            var porDonde = (cuantasVeces * self.cannalActivo.channelDuration ) + advengers.shared.currentChurchInfo.channelActiveTime
                            print("Por Donde antes del loop")
                            print(porDonde)
                            for (index,cancion) in self.urlSongs.enumerated() {
                                
                                
                                                                  print("index loop")
                                                                  print(index)
            
                                
                                if porDonde >= Int (time.timeIntervalSince1970){
                                  
                                   let seginThetrack = porDonde - Int (time.timeIntervalSince1970)
                                    
                                    print("index antes")
                                    print(index)
                                    self.indexPlaylist = index
                                    self.playNow (index: index, segPosition:seginThetrack )
                                    self.tituloCancion.text = self.urlSongs[index].title
                                    self.tituloCancion.sizeToFit()
                                    return
                                }
                                
                                porDonde = porDonde + cancion.durationSeg
                            }
                            
                            
                            
                            
                            
                        }
                        
                        
                          
                      })
                     /// isPlaying = true
                    urlSongs.append(a)
                  }
        
        
        
          } else {
              
              audioView.setImage(#imageLiteral(resourceName: "payAudio").withRenderingMode(.alwaysOriginal), for: .normal)
              isPlaying = false
             estadodelPlay.text = ""
              audioPlayer?.stop()
          }
                  
       
        

        
        
        /* ESto para ver donde lo ponemos*/
       
            
          
            
      
        
         /*  -------*/
    }
    
    func playNow (index: Int, segPosition: Int) {
        
        print("llego a play now")
        print(index)
        print(urlSongs[index].songURL as? String)
        
        let httpsReference = storage.reference(forURL: urlSongs[index].songURL)
        estadodelPlay.text = "Loading ..."
        httpsReference.getData(maxSize: 100 * 1024 * 1024) { data, error in
            if let error = error {
                print("Error Playing")
                print(error.localizedDescription)
            } else {
                
                self.playContent(data: data!, segPosition: segPosition)
                self.statusAudio.isHidden = true
                
            }
            
        }
        
        
        //     let url = URL(fileURLWithPath: post!.photoImage)
        
        //   print ("Click ok")
        
        //  print(url.absoluteString)
        
        //
        //                  } else {
        //
        //                      audioView.setImage(#imageLiteral(resourceName: "payAudio").withRenderingMode(.alwaysOriginal), for: .normal)
        //                      audioPlayer?.stop()
        //                  }
        
    }
    
    
    
    
    
    func playContent (data: Data, segPosition: Int)
        
    {
        
           print (" Poscicion en Segundos")
           print(segPosition)
        
        do {
            

            audioPlayer = try AVAudioPlayer(data: data)
            audioPlayer!.delegate = self
            audioPlayer?.play()
            print("Audio Player duration")
            print (audioPlayer?.duration)
            
           // audioPlayer?.play(atTime: Double(segPosition))
            
            
            //audioPlayer?.play(atTime: 1)
            
            print("Playing ....")
            estadodelPlay.text = "Playing ...."
        } catch {
            estadodelPlay.text = "No Playing - Error in Conection"
            //print(url.absoluteString)
        }
        
        
        
        
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
       // audioRecorder = nil
        print ( " Termino la song " )
        
        indexPlaylist = indexPlaylist + 1
        
        if indexPlaylist == urlSongs.count {
            
            indexPlaylist = 0
            
            self.playNow (index: indexPlaylist, segPosition: 0)
            
        } else {
            
            self.playNow (index: indexPlaylist, segPosition: 0)
            
            
        }
        
        
        
        self.tituloCancion.text = self.urlSongs[indexPlaylist].title
        
    }
    
 
    
    
}





