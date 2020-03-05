//
//  AudioCollectionViewCell.swift
//  altar
//
//  Created by Juan Moreno on 1/9/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase


protocol AudibleDelegate {
    func AudibleDelegate_didTapComment(post: Posts)
    func AudibleDelegate_didLike(for cell: AudioCollectionViewCell)
    func deletCellD(for cell: AudioCollectionViewCell)
}


class AudioCollectionViewCell: UICollectionViewCell, UIGestureRecognizerDelegate {
    
    var audioPlayer: AVAudioPlayer?
    let storage = Storage.storage()
    var delegate: AudibleDelegate?
    
    var isPlaying = false
    
    var post: Posts? {
        
        didSet {
            
            
            
            
            //              guard let postImageUrl = post?.photoImage else { return }
            
            //            photoImageView.loadImage(urlString: postImageUrl)
            
            usernameLabel.text = post?.author
            guard let profileuserURL = post?.userPhoto else {return}
            userProfileImageView.loadImage(urlString: profileuserURL)
            guard let urlA = post?.userPhoto  else {return}
            
            
            // setupAttributedCaption()
            
            
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
            //  let fecha = Date(milliseconds: Int64(post?.creationDate ?? 0))
            let fecha = post?.creationDate
            praysDate.text = fecha!.timeAgoDisplay()
            // ==========================================================
            
            
            
            
        }
        
    }
    
    
    
    fileprivate func setupAttributedCaption() {
        guard let post = self.post else { return }
        
        let attributedText = NSMutableAttributedString(string: post.author, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        
        attributedText.append(NSAttributedString(string: " \(post.message ?? "Defaul Value")", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]))
        
        attributedText.append(NSAttributedString(string: "\n\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 4)]))
        
        //   let timeAgoDisplay = post.timeAgoDisplay()
        //   attributedText.append(NSAttributedString(string: timeAgoDisplay, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.gray]))
        captionLabel.isScrollEnabled = false
        captionLabel.attributedText = attributedText
        
    }
    
    lazy var statusAudio: UILabel = {
           let label2 = UILabel ()
           label2.font = UIFont(name: "Avenir-Medium", size: 12)
           label2.text = "Loading audio file ..."
           label2.textColor = .white
           //   button.setImage(UIImage(named: "cellPrayIcon")?.withRenderingMode(.alwaysOriginal), for: .normal)
           // button.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
           return label2
       }()
    
    
    
    
    lazy var praysDate: UILabel = {
        let label2 = UILabel ()
        label2.font = UIFont(name: "Avenir-Medium", size: 12)
        label2.text = "You prayed 1"
        label2.textColor = .lightGray
        //   button.setImage(UIImage(named: "cellPrayIcon")?.withRenderingMode(.alwaysOriginal), for: .normal)
        // button.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
        return label2
    }()
    
    
    lazy var likeCount: UILabel = {
        let label2 = UILabel ()
        label2.font = UIFont(name: "Avenir-Medium", size: 15)
        label2.text = "0000"
        //   button.setImage(UIImage(named: "cellPrayIcon")?.withRenderingMode(.alwaysOriginal), for: .normal)
        // button.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
        return label2
    }()
    
    
    lazy var commentCount: UILabel = {
        let label2 = UILabel ()
        label2.font = UIFont(name: "Avenir-Medium", size: 15)
        label2.text = "    "
        //   button.setImage(UIImage(named: "cellPrayIcon")?.withRenderingMode(.alwaysOriginal), for: .normal)
        // button.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
        return label2
    }()
    
    
    let userProfileImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .blue
        return iv
    }()
    
    lazy var audioView: UIButton = {
        let iv = UIButton(type: .system)
       // iv.setTitle("Play", for: .normal)
        iv.setImage(#imageLiteral(resourceName: "payAudio").withRenderingMode(.alwaysOriginal), for: .normal)
      //  iv.setTitleColor(.black, for: .normal)
        //  iv.contentMode = .scaleAspectFill
        iv.layer.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        
        
        
     


        //  iv.contentMode = .scaleAspectFit
        // iv.clipsToBounds = true
        iv.addTarget(self, action: #selector (hadlePlay), for: .touchUpInside)
        return iv
    }()
    
    

    lazy var audioViewBack: UIView = {
        
        let a = UIView()
        let fondo: String = {
            
            return "fondo" + String(Int.random(in: 1..<5))
        } ()
        
        let imagen = UIImageView(image: UIImage(named: fondo))
        
        imagen.contentMode = .scaleAspectFit
    
        a.bounds = CGRect(x: 0, y: 0, width: frame.width, height: 80)
        a.addSubview(imagen)
        a.alpha = 0.6
        
        
        return a
    } ()
    
 
    
    
    
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
    
    lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "icon-like").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
        return button
    }()
    
    @objc func handleLike() {
        print("Handling like from within cell...")
       delegate?.AudibleDelegate_didLike(for: self)
    }
    
    lazy var commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "icon-comment-1").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleComment), for: .touchUpInside)
        //button.addTarget(self, action: #selector(clickcomment), for: .touchUpInside)
        
        return button
    }()
    
    
    
    @objc func handleComment() {
        print("Trying to show comments...")
        guard let post = post else { return }
        
         delegate?.AudibleDelegate_didTapComment(post: post)
        
    }
    
    let sendMessageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "icon-play-1").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let bookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "icon-play").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let captionLabel: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 14)
        
        textView.backgroundColor = .lightGray
        textView.isScrollEnabled = false
        return textView
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //     print("Este es el frame de la cell: \(frame.width),\(frame.height)")
        
        
        
        
        defaultCell()
        
        
        
        
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func defaultCell () {
        
        
        addSubview(userProfileImageView)
        addSubview(usernameLabel)
        
        
        //addSubview(audioViewBack)
        addSubview(audioView)
        
        
        
        //     addSubview(userProfileImageView)
        //    addSubview(usernameLabel)
        addSubview(optionsButton)
        
        
        userProfileImageView.layer.borderWidth = 1
        userProfileImageView.layer.borderColor = advengers.shared.colorOrange.cgColor
        
        
        userProfileImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 15, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
        userProfileImageView.layer.cornerRadius = 50 / 2
        
        usernameLabel.anchor(top: userProfileImageView.topAnchor, left: userProfileImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        addSubview(praysDate)
        praysDate.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 30, width: 0, height: 0)
        praysDate.centerYAnchor.constraint(equalTo: usernameLabel.centerYAnchor).isActive = true
        
        
        addSubview(statusAudio)
        
        
        
        
        
        /*
         let stackView = UIStackView(arrangedSubviews: [likeButton,likeCount,commentButton,commentCount])
         stackView.distribution = .fillEqually
         
         addSubview(stackView)
         
         userProfileImageView.translatesAutoresizingMaskIntoConstraints = false
         userProfileImageView.layer.cornerRadius = 40 / 2
         userProfileImageView.topAnchor.constraint(equalTo: topAnchor, constant:8).isActive = true
         userProfileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant:8).isActive = true
         userProfileImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
         userProfileImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
         userProfileImageView.bottomAnchor.constraint(equalTo: audioView.topAnchor, constant: -8).isActive = true
         // userProfileImageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
         // userProfileImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
         
         // userProfileImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
         
         usernameLabel.translatesAutoresizingMaskIntoConstraints = false
         
         usernameLabel.topAnchor.constraint(equalTo: userProfileImageView.topAnchor, constant:10).isActive = true
         usernameLabel.leftAnchor.constraint(equalTo: userProfileImageView.rightAnchor, constant: 8).isActive = true
         
         
         //  usernameLabel.anchor(top: topAnchor, left: userProfileImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
         
         // NEW CODE
         
         */
        
        let stackView = UIStackView(arrangedSubviews: [likeButton,likeCount,commentButton,commentCount])
        stackView.distribution = .fillProportionally
        addSubview(stackView)
        //   addSubview(praysCount)
   //     stackView.anchor(top: captionLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 8, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 120, height: 50)
        
       
        //  audioView.widthAnchor.constraint(equalToConstant: frame.width).isActive = true
        
        /*
        audioView.translatesAutoresizingMaskIntoConstraints = false
               audioView.topAnchor.constraint(equalTo: userProfileImageView.bottomAnchor, constant: 8).isActive = true
               audioView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
               audioView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
               audioView.bottomAnchor.constraint(equalTo: stackView.topAnchor ).isActive = true
        */

        audioView.anchor(top: userProfileImageView.bottomAnchor, left: leftAnchor, bottom: stackView.topAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 120)
       stackView.anchor(top: audioView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 200, height: 50)
        
        
        statusAudio.anchor(top: nil, left: nil, bottom: audioView.bottomAnchor, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: 0, height: 0)
        
        statusAudio.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        statusAudio.isHidden = true
        
        /*
         stackView.translatesAutoresizingMaskIntoConstraints = false
         stackView.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 0).isActive = true
         stackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
         stackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
         stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
         stackView.widthAnchor.constraint(equalToConstant: 120).isActive = true
         stackView.heightAnchor.constraint(equalToConstant: 120).isActive = true
         
         */
        
        
        //      stackView.anchor(top: captionLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 4, paddingBottom: -8, paddingRight: 0, width: 120, height: 50)
        
        // setupUser()
        
        //  addSubview(optionsButton)
        //  addSubview(photoImageView)
        
        //  userProfileImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        
        
        
        //    optionsButton.anchor(top: topAnchor, left: nil, bottom: photoImageView.topAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 44, height: 0)
        
        
        
        //   photoImageView.anchor(top: nil, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        // photoImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        
        
        
        //   addSubview(captionLabel)
        
        //   captionLabel.anchor(top: photoImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        
        
        //   setupActionButtons()
        
             let swipeCell = UISwipeGestureRecognizer(target: self, action: #selector(hiddenContainerViewTapped))
                swipeCell.direction = .left
                swipeCell.delegate = self
                
                addGestureRecognizer(swipeCell)

            }
            
            
            @objc func hiddenContainerViewTapped () {

             if post?.userID == Auth.auth().currentUser?.uid || advengers.shared.isPastor == true {

                       print("Swiper no Swiper !!!!")
                       
                       let contenedor = UIView()

                       addSubview(contenedor)
                       
                       contenedor.anchor(top: topAnchor, left: nil, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 100, height: 0)
                       contenedor.backgroundColor = .red
                       
                       let deleteB = UIButton ()
                       
                       deleteB.addTarget(self, action: #selector(borrar), for: .touchDown)
                      // deleteB.titleLabel?.text = "Delete"
                     //  deleteB.tintColor = .white
                       deleteB.setTitle("Delete", for: .normal)
                       deleteB.setTitleColor(.white, for: .normal)
                       
                       contenedor.addSubview(deleteB)
                       deleteB.translatesAutoresizingMaskIntoConstraints = false
                       deleteB.centerXAnchor.constraint(equalTo: contenedor.centerXAnchor).isActive = true
                       deleteB.centerYAnchor.constraint(equalTo: contenedor.centerYAnchor).isActive = true
                           
                       }
               
            }
            
            @objc func borrar() {
        //        let imageDataDict = ["index": self.]
        //        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "DeleteCell"), object: nil,userInfo: imageDataDict)
                
                delegate?.deletCellD(for: self)
            }
        
    
    
    
    /*
    fileprivate func setupActionButtons() {
        
        let stackView = UIStackView(arrangedSubviews: [likeButton, commentButton])
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        stackView.anchor(top: captionLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 4, paddingBottom: -8, paddingRight: 0, width: 120, height: 50)
        
        
    }
    */
    
    
    @objc func hadlePlay ()  {
        
        
        isPlaying = !isPlaying
        
        if isPlaying{
            audioView.setImage(#imageLiteral(resourceName: "pausebutton").withRenderingMode(.alwaysOriginal), for: .normal)
        
        statusAudio.isHidden = false
            
        let httpsReference = storage.reference(forURL: post!.photoImage)
        
        httpsReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                // Uh-oh, an error occurred!
            } else {
                
                
                self.playContent(data: data!)
                self.statusAudio.isHidden = true
                // Data for "images/island.jpg" is returned
                //let image = URL(data: data!)
                
            }
            
            
            
        }
        
        
        let url = URL(fileURLWithPath: post!.photoImage)
        
        print ("Click ok")
        print (post!.photoImage)
        print(url.absoluteString)
        
        
        } else {
            
            audioView.setImage(#imageLiteral(resourceName: "payAudio").withRenderingMode(.alwaysOriginal), for: .normal)
            audioPlayer?.stop()
        }
        
    }
    
    func playContent (data: Data)
        
    {
        
        
        do {
            
            audioPlayer = try AVAudioPlayer(data: data)
            audioPlayer?.play()
            print("Playing ....")
        } catch {
            print ("No Playing")
            //print(url.absoluteString)
        }
        
        
        
        
    }
    
    
    
    
}
