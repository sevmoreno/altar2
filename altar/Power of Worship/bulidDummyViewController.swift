//
//  bulidDummyViewController.swift
//  altar
//
//  Created by Juan Moreno on 2/12/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//
import Firebase
import UIKit
import AVFoundation

class bulidDummyViewController: UIViewController {
    
    
    
    
    let songinproces = songInProcess()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        
        //
        //        postSong(Nombre: "Here I Am to Worship", completionHandler: { (success) -> Void in
        //
        //        })
        
        
        
        
//        let imagen = "amanecer"
//
//        let urlimagen = postImage(foto: imagen ,completionHandler: { (success, urlphoto) -> Void in
//
//            if (success) {
//                self.postChannels (nombre: "Time in God", subtitulo: "Worship Instrumental", imagen: urlphoto, lista: ["Here I Am to Worship","Here I Am to Worship","Here I Am to Worship"])
//            }
//          })
//
        
     
        //   postChannels (nombre: "A Solas Con Dios", imagen: "devoback7", lista: ["AsolasconDios","AsolasconDios","AsolasconDios"])
        
        //  creatChurch (userID: Auth.auth().currentUser?.uid ?? "", name: "Favorday Church", address: "3400 Pacific Ave", state: "California", country: "USA", zipCode: "90807", email: "", facebook: "", instragram: "", webSite: "", phoneNumber: "")
        
        
        loadCurrentChurch(codigo: "66888A34-D2C7-43A8-AAE4-655DA8285541")
        
    }
    
    
    // Lista de nombres
    
    
    
    
    
    func postChannels (nombre: String, subtitulo: String, imagen: String, lista: [String]) {
        
        var channelDuration = 0
        var listaDeCanciones = [String] ()
        let key = advengers.shared.postPrayFeed.childByAutoId().key
        
        //let imageRef = advengers.shared.PostPrayStorage.child(uid!).child("\(key!).jpg")
        let uuid = UUID().uuidString
        
        let iglesia = advengers.shared.currentChurch
        let userPostRef = Database.database().reference().child("Media_Channels")
        let ref = userPostRef
        
        
//        var imagen1 = ""
//
//        repeat {
//
//        let urlimagen = postImage(foto: imagen,completionHandler: { (success, urlphoto) -> Void in
//
//
//        })
//            imagen1 = urlimagen
//        } while imagen1 == ""
//
        
       
        let time = NSDate ()
                        
                        for item in lista {
                            
                            postSong(Nombre: item, completionHandler: { (success) -> Void in
                                channelDuration = channelDuration + success.duration
                                
                                listaDeCanciones.append(success.codigo)
                                
                                
                                let diction = ["author" : Auth.auth().currentUser?.uid,
                                                          "title" : nombre,
                                                          "lista" : listaDeCanciones,
                                                          "photoURL" : imagen,
                                                          "subtitle" : subtitulo,
                                                          "channelID" : uuid,
                                                          "channelDuration" : channelDuration,
                                                          "creationDate" : Int(time.timeIntervalSince1970)
                                               ] as? [String:Any]
                                           
                                           //       let song = wSong (dictionary: diction!)
                                           
                                           
                                           
                                           ref.child(uuid).updateChildValues(diction!) { (err, ref) in
                                               if let err = err {
                                                   //self.navigationItem.rightBarButtonItem?.isEnabled = true
                                                   print("Failed to save post to DB", err)
                                                   return
                                               }
                                               
                                               print("Successfully saved Imagen del Channel")
                                               print("Total Duration:")
                                               print(channelDuration)
                                               
                                           }
                                
                            })
                            
                           
                            
                        }

        
        
    }
}



func creatChurch (userID: String, name: String, address: String?, state: String, country: String, zipCode: String?,email: String?,facebook: String?,instragram: String?, webSite: String?, phoneNumber: String?) {
    
    let userPostRef = Database.database().reference().child("Churchs")
    
    let uuid = UUID().uuidString
    
    let diction = ["userID" : userID,
                   "name" : name,
                   "address" : address,
                   "country" : country,
                   "state": state,
                   "zipCode" : zipCode,
                   "email" : email,
                   "facebook" : facebook,
                   "instragram" : instragram,
                   "webSite" : webSite,
                   "phoneNumber" : phoneNumber,
                   "uidChurch" : uuid
        
    ]
    
    userPostRef.child(uuid).updateChildValues(diction as [String : Any]) { (err, ref) in
        if let err = err {
            //self.navigationItem.rightBarButtonItem?.isEnabled = true
            print("Failed to save post to DB", err)
            return
        }
        
        print("Successfully saved new Church to DB")
        
    }
    
    
    
}






func postSong (Nombre: String,completionHandler: @escaping (_ songIn: songInProcess) -> Void){
    
    
    var temporarioSong = songInProcess ()
    
    let key = advengers.shared.postPrayFeed.childByAutoId().key
    
    //let imageRef = advengers.shared.PostPrayStorage.child(uid!).child("\(key!).jpg")
    let uuid = UUID().uuidString
    
    let iglesia = advengers.shared.currentChurch
    let userPostRef = Database.database().reference().child("Media_Songs")
    let ref = userPostRef
    //  let filename = NSUUID().uuidString
    let storageRefDB = Storage.storage().reference().child("Media_Songs").child(uuid)
    
    
    let urlPath = Bundle.main.url(forResource: Nombre, withExtension: "mp3")
    
    
    
    
    let data = try! Data(contentsOf: urlPath!)
    var audioPlayer: AVAudioPlayer?
    audioPlayer = try! AVAudioPlayer(data: data)
    audioPlayer?.play()
    print("Playing ....")
    print(uuid)
    print("Duration ...")
    let duration = Int(audioPlayer!.duration)
    
    print(duration)
    
    
    
    //     guard let imagensincompresion = UIImage(named: nombre) else {return}
    
    //     guard let imagen = imagensincompresion.jpegData(compressionQuality: 0.5) else { return }
    
    
    storageRefDB.putData(data, metadata: nil, completion: { (metadata, err) in
        
        if let err = err {
            print("Failed to upload profile image:", err)
            return
        }
        
        // Firebase 5 Update: Must now retrieve downloadURL
        storageRefDB.downloadURL(completion: { (downloadURL, err) in
            if let err = err {
                print("Failed to fetch downloadURL:", err)
                return
            }
            
            guard let backgroundURL = downloadURL?.absoluteString else { return }
            
            
            //                    self.author = dictionary["author"] as? String ?? ""
            //                           self.title = dictionary["title"] as? String ?? ""
            //                           self.songID = dictionary["songID"] as? String
            //
            //                           self.durationSeg = dictionary["durationSeg"] as? Int ?? 0
            //
            //                            self.songURL = dictionary["songURL"] as? String
            temporarioSong.codigo = uuid
            temporarioSong.duration = duration
            
            let diction = ["author" : "",
                           "title" : Nombre,
                           "songID" : uuid,
                           "durationSeg" : duration,
                           "songURL" : backgroundURL
                
                ] as? [String:Any]
            
            //   let song = wSong (dictionary: diction!)
            
            
            
            ref.child(uuid).updateChildValues(diction!) { (err, ref) in
                if let err = err {
                    //self.navigationItem.rightBarButtonItem?.isEnabled = true
                    print("Failed to save post to DB", err)
                    completionHandler(temporarioSong)
                    return
                }
                
                completionHandler(temporarioSong)
                print("Successfully saved post to DB")
                
                
            }
            
            
        })
    })
    
    
    
    
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
func postImage (foto: String,completionHandler: @escaping (_ success:Bool, _ urlphoto: String) -> Void) -> String {
    
    
    var urlDeLaImange: String = ""
    
    
    
    let key = advengers.shared.postPrayFeed.childByAutoId().key
    
    let imageRef = advengers.shared.PostPrayStorage.child("channelImage").child("\(foto).jpg")
    
    let imagen = UIImage(named: foto)
    
    let data = imagen!.jpegData(compressionQuality: 0.6)
    
    
    
    let uploadTask = imageRef.putData(data!, metadata: nil) { (matadata, error) in
        
        if error != nil {
            print(error.debugDescription)
        }
        
        
        imageRef.downloadURL(completion: { (url, error) in
            if let url = url {
                
                
               // urlDeLaImange = url.absoluteString
                urlDeLaImange = url.absoluteString
                completionHandler(true,urlDeLaImange)
            }
        })
        
    }
    uploadTask.resume()
     
     
    
    return urlDeLaImange
    
}

//    @objc func postAudio () {
//
//           AppDelegate.instance().showActivityIndicatior()
//
//                 let uid = Auth.auth().currentUser?.uid
//
//                 let nombreToDisplay = advengers.shared.currenUSer["name"] ?? "Unknow"
//                 let userphot = advengers.shared.currenUSer["photoURL"] ?? "No cargo"
//
//                 let key = advengers.shared.postPrayFeed.childByAutoId().key
//
//                // let imageRef = advengers.shared.PostPrayStorage.child(uid!).child("\(key!).jpg")
//
//
//
//
//
//                  let data = try! Data(contentsOf: urlTemporario)
//                  let storageRef = Storage.storage().reference().child("Videos").child(uid!).child(key!)
//                  let putAudio = storageRef.putData(data, metadata: nil
//                             , completion: { (metadata, error) in
//                                 if let error = error {
//                                     print ("Error subiendo Audio a Firebase")
//                                 }else{
//
//                                   storageRef.downloadURL(completion: { (url, error) in
//                                       if let url = url {
//
//                                           let feed = ["userid": uid,
//                                                       "pathtoPost":url.absoluteString,
//                                                       "prays": 0,
//                                                       "author": nombreToDisplay,
//                                                       "userPhoto": userphot,
//                                                       "postID": key,
//                                                       "creationDate": Date().millisecondsSince1970,
//                                                       "postType": advengers.postType.audio.rawValue,
//                                                       "message": "audio" as String,
//                                                       "imagH:": 0.0,
//                                                       "imagW:": 0.0
//
//
//                                                       ] as! [String:Any]
//
//                                           let postfeed = ["\(key!)" : feed] as! [String:Any]
//
//                                           advengers.shared.postPrayFeed.updateChildValues(postfeed)
//
//                                           AppDelegate.instance().dismissActivityIndicator()
//                                           NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UpdateFeed"), object: nil)
//                                           _ = self.navigationController?.popViewController(animated: true)
//
//
//                                       }
//                                   })
//
//                                 }
//                         })
//
//                       putAudio.resume()
//
//
//
//       }
//

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */


