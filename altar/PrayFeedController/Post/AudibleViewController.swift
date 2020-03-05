//
//  AudibleViewController.swift
//  altar
//
//  Created by Juan Moreno on 1/8/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//

import UIKit
import AVFoundation
import Photos
import Firebase

class AudibleViewController: UIViewController, AVAudioRecorderDelegate {
    
    let userProfileImageView: CustomImageView = {
             let iv = CustomImageView()
             iv.contentMode = .scaleAspectFill
             iv.clipsToBounds = true
             iv.backgroundColor = .blue
             return iv
         }()
         
         
         let usernameLabel: UILabel = {
             let label = UILabel()
             label.text = "Username"
             label.font = UIFont(name: "Avenir-Medium", size: 15)
             return label
         }()
    
    let timer = Timer ()
    
    let viewToRercord: UIView = {
           
           let imagen = UIView ()
          
           return imagen
       } ()
    
    let playRercord: UIButton = {
             
             let imagen = UIButton ()
           // imagen.layer.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            imagen.setImage(UIImage(named: "payAudio"), for: .normal)
             imagen.addTarget(self, action: #selector (playAudio), for: .touchUpInside)
                
        
            
             return imagen
         } ()
    
    
    let PlayLalel: UILabel = {
                let label = UILabel()
                label.text = "Audible Prayer"
                label.font = UIFont(name: "Avenir-Medium", size: 14)
                return label
            }()
    
   /*
    let postRercord: UIButton = {
             
             let boton = UIButton ()
             boton.layer.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
             boton.addTarget(self, action: #selector (postAudio), for: .touchUpInside)
             boton.setTitle("Post", for: .normal)
                
        
            
             return boton
         } ()
    */
    var activeMemory: URL!
    var urlTemporario: URL!
    var audioRecorder: AVAudioRecorder?
    var grabacionPlayer: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        playRercord.isEnabled = false
        playRercord.tintColor = .gray
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Post", style: .plain, target: self, action: #selector(postAudio))

        
        view.addSubview(userProfileImageView)
        view.addSubview(usernameLabel)
               
               DispatchQueue.main.async {
                self.usernameLabel.text = advengers.shared.currenUSer["name"] as! String
                          
                    guard let profileuserURL = advengers.shared.currenUSer["photoURL"] else {return}
                self.userProfileImageView.loadImage(urlString: profileuserURL as! String)
               }
               
                userProfileImageView.translatesAutoresizingMaskIntoConstraints = false
                userProfileImageView.layer.borderWidth = 1
               
                userProfileImageView.layer.borderColor = advengers.shared.colorOrange.cgColor
                
                userProfileImageView.layer.cornerRadius = 50 / 2
               userProfileImageView.topAnchor.constraint(equalTo: view.topAnchor, constant:120).isActive = true
               userProfileImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant:15).isActive = true
                userProfileImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
                userProfileImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
             //   userProfileImageView.bottomAnchor.constraint(equalTo: photoImageView.topAnchor, constant: -8).isActive = true

                usernameLabel.translatesAutoresizingMaskIntoConstraints = false
               
            //     usernameLabel.topAnchor.constraint(equalTo: userProfileImageView.topAnchor, constant:10).isActive = true
                usernameLabel.leftAnchor.constraint(equalTo: userProfileImageView.rightAnchor, constant: 8).isActive = true
        usernameLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        usernameLabel.centerYAnchor.constraint(equalTo: userProfileImageView.centerYAnchor).isActive = true

        
        view.backgroundColor = .white
        checkPermissions()
   
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(memoryLongPress))
            recognizer.minimumPressDuration = 0.25
            viewToRercord.addGestureRecognizer(recognizer)
        let image = UIImage(named: "pressRecord")
        let imageView = UIImageView(image: image!)
        let ratio = CGFloat((image?.size.width)!) / CGFloat ((image?.size.height)!)
        
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.width / ratio)
        viewToRercord.addSubview(imageView)
     
        //    viewToRercord.layer.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
      //      viewToRercord.layer.borderColor = UIColor.white.cgColor
      //      viewToRercord.layer.borderWidth = 3
      //      viewToRercord.layer.cornerRadius = 10
        
        view.addSubview(viewToRercord)
        
        view.addSubview(playRercord)
        
     //   view.addSubview(postRercord)
        
        viewToRercord.anchor(top: userProfileImageView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: view.frame.width / ratio)
        viewToRercord.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        playRercord.anchor(top: viewToRercord.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 73, height: 73)
        playRercord.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(PlayLalel)
        PlayLalel.anchor(top: playRercord.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        PlayLalel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
  //      postRercord.anchor(top: playRercord.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 60, height: 60)
   //     postRercord.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
      
        // Do any additional setup after loading the view.
    }
    
    @objc func playAudio ()  {
        
        
        let url = urlTemporario

        do {
            grabacionPlayer = try AVAudioPlayer(contentsOf: url!)
            grabacionPlayer?.play()
        } catch {
            
            print("No Cargo")
            // couldn't load file :(
        }
        
        
    }
  
    @objc func memoryLongPress (sender: UILongPressGestureRecognizer) {
        
        if sender.state == .began {
          
            urlTemporario = getDocumentsDirectory()
                   
            urlTemporario = urlTemporario.appendingPathComponent("recording.m4a")
            
            
            
             animateRecording ()
            recordMemory()
            
        } else if sender.state == .ended {
            
            
            stopAnimation ()
            
            finishRecording(success: true)
            
        }

        
        
    }
    func stopAnimation () {
        UIView.animate(withDuration: 0.5, animations:{
            self.viewToRercord.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, animations: {
                self.viewToRercord.transform = .identity
            })
        })
        
    }
    func animateRecording () {
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: [.repeat, .autoreverse, .beginFromCurrentState],
                       animations: {
                        self.viewToRercord.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)

        }, completion: { _ in
                              UIView.animate(withDuration: 0.5, animations: {
                                  self.viewToRercord.transform = .identity
                              })
                          })
        
    /*
        UIView.animate(withDuration: 0.5, animations:{
                       self.viewToRercord.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                   }, completion: { _ in
                       UIView.animate(withDuration: 0.5, animations: {
                           self.viewToRercord.transform = .identity
                       })
                   })
 */
    }
    
    
    func recordMemory() {
        
        playRercord.isEnabled = false
        playRercord.tintColor = .gray
        
        
        /*
        UIView.animate(withDuration: 0.6,
                       delay: 0.5,
                       options: .curveEaseInOut,
                       animations: {
                        self.viewToRercord.center.x += self.viewToRercord.frame.size.width
                        self.viewToRercord.frame.size.width = 0
        }, completion: { _ in
            self.viewToRercord.backgroundColor = .red
        })
        */
        
         viewToRercord.tintColor = .red

        // this just saves me writing AVAudioSession.sharedInstance() everywhere
        let recordingSession = AVAudioSession.sharedInstance()

        do {
            // 2. configure the session for recording and playback through the speaker
            try recordingSession.setCategory(.playAndRecord, mode: .default, options: .defaultToSpeaker)
            try recordingSession.setActive(true)

            // 3. set up a high-quality recording session
            
            /*
            let settings = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 44100,
                AVNumberOfChannelsKey: 2,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
 */
            let settings:[String:Any] = [AVFormatIDKey:kAudioFormatAppleLossless,
                                         AVEncoderAudioQualityKey:AVAudioQuality.medium.rawValue,
            AVEncoderBitRateKey:160000,
            AVNumberOfChannelsKey:1,
            AVSampleRateKey:24000.0 ] as [String : Any]

            // 4. create the audio recording, and assign ourselves as the delegate
          audioRecorder = try AVAudioRecorder(url: urlTemporario, settings: settings)
          audioRecorder?.delegate = self
          audioRecorder?.record()
            
         
            } catch let error {
            // failed to record!
            print("Failed to record: \(error)")
             finishRecording(success: false)
                }
 
 
            }
    
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    

    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }

    func finishRecording(success: Bool) {
        
        playRercord.tintColor = .clear
        playRercord.isEnabled = true
        // 1
      

        // 2
        audioRecorder?.stop()

        
        /*
        if success {
            do {
                let memoryAudioURL = activeMemory.appendingPathExtension("m4a")
                let fm = FileManager.default

                            // 4
                if fm.fileExists(atPath: memoryAudioURL.path) {
                                try fm.removeItem(at: memoryAudioURL)
                            }

                            // 5
                 try fm.moveItem(at: recordingURL, to: memoryAudioURL)

                            // 6
                           // transcribeAudio(memory: activeMemory)
                        } catch let error {
                            print("Failure finishing recording: \(error)")
                        }
                    }
  */
        
                }

    func checkPermissions() {
        // check status for all three permissions
        let photosAuthorized = PHPhotoLibrary.authorizationStatus() == .authorized
        let recordingAuthorized = AVAudioSession.sharedInstance().recordPermission == .granted
     //   let transcibeAuthorized = SFSpeechRecognizer.authorizationStatus() == .authorized

        // make a single boolean out of all three
        let authorized = photosAuthorized && recordingAuthorized
        // if we're missing one, show the first run screen
        if authorized == false {
            
            requestPhotosPermissions()
           // if let vc = storyboard?.instantiateViewController(withIdentifier: "FirstRun") {
            //    navigationController?.present(vc, animated: true)
            print("Falta permiso")
            }
        }
    
    func requestPhotosPermissions() {
        PHPhotoLibrary.requestAuthorization { [unowned self] authStatus in
            DispatchQueue.main.async {
                if authStatus == .authorized {
                    self.requestRecordPermissions()
                } else {
                    print(" ok ")
                }}}}
    
    func requestRecordPermissions() {
        AVAudioSession.sharedInstance().requestRecordPermission() { [unowned self] allowed in
            
            DispatchQueue.main.async {
                        if allowed {
                            //
                              //self.requestTranscribePermissions()
                        } else {
                            print("Recording permission was declined; please enable it in settings then tap Continue again.")
                        }
                    }
                }
            }

   
    
    @objc func postAudio () {
        
        AppDelegate.instance().showActivityIndicatior()
              
              let uid = Auth.auth().currentUser?.uid
        
              let nombreToDisplay = advengers.shared.currenUSer["name"] ?? "Unknow"
              let userphot = advengers.shared.currenUSer["photoURL"] ?? "No cargo"
              
              let key = advengers.shared.postPrayFeed.childByAutoId().key
              
             // let imageRef = advengers.shared.PostPrayStorage.child(uid!).child("\(key!).jpg")

              
              
             
        
               let data = try! Data(contentsOf: urlTemporario)
               let storageRef = Storage.storage().reference().child("Videos").child(uid!).child(key!)
               let putAudio = storageRef.putData(data, metadata: nil
                          , completion: { (metadata, error) in
                              if let error = error {
                                  print ("Error subiendo Audio a Firebase")
                              }else{
                                 
                                storageRef.downloadURL(completion: { (url, error) in
                                    if let url = url {
                                        
                                        let feed = ["userid": uid,
                                                    "pathtoPost":url.absoluteString,
                                                    "prays": 0,
                                                    "author": nombreToDisplay,
                                                    "userPhoto": userphot,
                                                    "postID": key,
                                                    "creationDate": Date().millisecondsSince1970,
                                                    "postType": advengers.postType.audio.rawValue,
                                                    "message": "audio" as String,
                                                    "imagH:": 0.0,
                                                    "imagW:": 0.0
                                            
                                            
                                                    ] as! [String:Any]
                                        
                                        let postfeed = ["\(key!)" : feed] as! [String:Any]
                                        
                                      //  advengers.shared.postPrayFeed.updateChildValues(postfeed)
                                        guard let currentChurchID = advengers.shared.currenUSer["churchID"] as? String else { return }
                                        advengers.shared.postPrayFeed.child(currentChurchID).updateChildValues(postfeed)
                                        
                                        AppDelegate.instance().dismissActivityIndicator()
                                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UpdateFeed"), object: nil)
                                        _ = self.navigationController?.popViewController(animated: true)
                                        
                                        
                                    }
                                })
                                
                              }
                      })
        
                    putAudio.resume()
        
                    
        
    }
    


        

        
        
        
   /*
        func convertVideo(toMPEG4FormatForVideo inputURL: URL, outputURL: URL, handler: @escaping (AVAssetExportSession) -> Void) {
            try! FileManager.default.removeItem(at: outputURL as URL)
            let asset = AVURLAsset(url: inputURL as URL, options: nil)

            let exportSession = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetHighestQuality)!
            exportSession.outputURL = outputURL
            exportSession.outputFileType = .mp4
            exportSession.exportAsynchronously(completionHandler: {
                handler(exportSession)
            })
        }
        
    }
  
*/

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    

    
    

}
