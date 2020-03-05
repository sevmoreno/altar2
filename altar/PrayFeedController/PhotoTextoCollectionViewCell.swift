//
//  PhotoTextoCollectionViewCell.swift
//  altar
//
//  Created by Juan Moreno on 1/8/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//

import UIKit
import Firebase

protocol textImageDelegate {
    func textImageDelegate_didTapComment(post: Posts)
    func textImageDelegate_didLike(for cell: PhotoTextoCollectionViewCell)
    func deletCellD(for cell: PhotoTextoCollectionViewCell)
}


class PhotoTextoCollectionViewCell: UICollectionViewCell, UIGestureRecognizerDelegate {
 

        var delegate: textImageDelegate?
        
        var post: Posts? {
            
            didSet {
               
                
                
                
                guard let postImageUrl = post?.photoImage else { return }
              //  likeButton.setImage(post?.hasLiked == true ? #imageLiteral(resourceName: "like_selected").withRenderingMode(.alwaysOriginal) : #imageLiteral(resourceName: "like_unselected").withRenderingMode(.alwaysOriginal), for: .normal)
                
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
               // let fecha = Date(milliseconds: Int64(post?.creationDate ?? 0))
                   
                praysDate.text = fecha!.timeAgoDisplay()
                
                setupAttributedCaption()
                
                
            }
            
        }
        

    
        
        fileprivate func setupAttributedCaption() {
            guard let post = self.post else { return }
            
            let attributedText = NSMutableAttributedString(string: "\(post.message ?? "Defaul Value")", attributes: [NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 15)])
            
           // attributedText.append(NSAttributedString(string: " \(post.message ?? "Defaul Value")", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]))
            
         //   attributedText.append(NSAttributedString(string: "\n\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 4)]))
            
         //   let timeAgoDisplay = post.timeAgoDisplay()
         //   attributedText.append(NSAttributedString(string: timeAgoDisplay, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.gray]))
            captionLabel.isScrollEnabled = false
            captionLabel.attributedText = attributedText
            
        }
    
        lazy var praysDate: UILabel = {
               let label2 = UILabel ()
               label2.font = UIFont(name: "Avenir-Medium", size: 12)
               label2.text = "You prayed 1"
            label2.textColor = .lightGray
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
        
        var photoImageView: CustomImageView = {
            let iv = CustomImageView()
            //  iv.contentMode = .scaleAspectFill
            
            iv.contentMode = .scaleAspectFit
            iv.clipsToBounds = true
            return iv
        }()
        
        let usernameLabel: UILabel = {
            let label = UILabel()
            label.text = "Username"
            label.font = UIFont(name: "Avenir-Medium", size: 15)
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
            button.setImage(UIImage(named: "cellPrayIcon")?.withRenderingMode(.alwaysOriginal), for: .normal)
            button.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
            return button
        }()
    
        lazy var likeCount: UILabel = {
          let label2 = UILabel ()
          label2.font = UIFont(name: "Avenir-Medium", size: 15)
          label2.text = "0000"
       //   button.setImage(UIImage(named: "cellPrayIcon")?.withRenderingMode(.alwaysOriginal), for: .normal)
         // button.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
          return label2
      }()
      
        
        @objc func handleLike() {
            print("Handling like from within cell...")
           delegate?.textImageDelegate_didLike(for: self)
        }
        
        lazy var commentButton: UIButton = {
            let button = UIButton(type: .system)
             button.setImage(UIImage(named: "cellComment Icone")?.withRenderingMode(.alwaysOriginal), for: .normal)
            button.addTarget(self, action: #selector(handleComment), for: .touchUpInside)
            //button.addTarget(self, action: #selector(clickcomment), for: .touchUpInside)
            
            return button
        }()
        
        lazy var commentCount: UILabel = {
                let label2 = UILabel ()
                label2.font = UIFont(name: "Avenir-Medium", size: 15)
                label2.text = "    "
             //   button.setImage(UIImage(named: "cellPrayIcon")?.withRenderingMode(.alwaysOriginal), for: .normal)
               // button.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
                return label2
            }()
            
        
        
        @objc func handleComment() {
            print("Trying to show comments...")
            guard let post = post else { return }
            
            
            delegate?.textImageDelegate_didTapComment(post: post)
            
        }
        
        let sendMessageButton: UIButton = {
            let button = UIButton(type: .system)
            button.setImage(#imageLiteral(resourceName: "icon-comment").withRenderingMode(.alwaysOriginal), for: .normal)
            return button
        }()
        
        let bookmarkButton: UIButton = {
            let button = UIButton(type: .system)
            button.setImage(#imageLiteral(resourceName: "icon-like").withRenderingMode(.alwaysOriginal), for: .normal)
            return button
        }()
        
        let captionLabel: UITextView = {
            let textView = UITextView()
            textView.font = UIFont.systemFont(ofSize: 14)
            textView.isEditable = false
            textView.backgroundColor = .white
            textView.isScrollEnabled = false
            return textView
        }()
        
        
    let viewContenedro: UIView = {
        
        let a = UIView ()
        
       
        
        return a
        
    } ()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            
            
          

               
            defaultCell()
        
            
        
          
            
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
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func defaultCell () {
            
            
            addSubview(userProfileImageView)
            addSubview(usernameLabel)
            
            
            photoImageView.contentMode = .scaleAspectFill
            photoImageView.clipsToBounds = true
            addSubview(photoImageView)
            
            let stackView = UIStackView(arrangedSubviews: [likeButton,likeCount,commentButton,commentCount])
            stackView.distribution = .fillProportionally
            addSubview(captionLabel)
            addSubview(stackView)
            
            userProfileImageView.translatesAutoresizingMaskIntoConstraints = false
            userProfileImageView.layer.cornerRadius = 50 / 2
            userProfileImageView.topAnchor.constraint(equalTo: topAnchor, constant:15).isActive = true
            userProfileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant:15).isActive = true
            userProfileImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
            userProfileImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
            userProfileImageView.bottomAnchor.constraint(equalTo: photoImageView.topAnchor, constant: -8).isActive = true
            
            // --------------------------------- BORDER COLOR -----------------------
            
            userProfileImageView.layer.borderWidth = 1
            userProfileImageView.layer.borderColor = advengers.shared.colorOrange.cgColor
            
            // -------------------------
            
            
           // userProfileImageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
           // userProfileImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            
           // userProfileImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
            
            usernameLabel.translatesAutoresizingMaskIntoConstraints = false
           
             usernameLabel.topAnchor.constraint(equalTo: userProfileImageView.topAnchor, constant:10).isActive = true
            usernameLabel.leftAnchor.constraint(equalTo: userProfileImageView.rightAnchor, constant: 8).isActive = true
            
              
           //  usernameLabel.anchor(top: topAnchor, left: userProfileImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
            
            // NEW CODE
            
     

            photoImageView.translatesAutoresizingMaskIntoConstraints = false
            photoImageView.topAnchor.constraint(equalTo: userProfileImageView.bottomAnchor, constant: 8).isActive = true
            photoImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
            photoImageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
            photoImageView.bottomAnchor.constraint(equalTo: captionLabel.topAnchor ).isActive = true
            photoImageView.widthAnchor.constraint(equalToConstant: frame.width).isActive = true
           
            
            captionLabel.anchor(top: photoImageView.bottomAnchor, left: leftAnchor, bottom: stackView.topAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
            
            addSubview(praysDate)
            praysDate.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 30, width: 0, height: 0)
            praysDate.centerYAnchor.constraint(equalTo: usernameLabel.centerYAnchor).isActive = true
            
            stackView.anchor(top: captionLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: -8, paddingRight: 0, width: 200, height: 50)
           
            
            
            
            
            
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
        }
        
      
     /*
        fileprivate func setupActionButtons() {

            let stackView = UIStackView(arrangedSubviews: [likeButton,likeCount,commentButton,commentCount])
            stackView.distribution = .fillEqually
            
            addSubview(stackView)
            stackView.anchor(top: captionLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 4, paddingBottom: -8, paddingRight: 0, width: 200, height: 50)
            
            
        }
      */
    

    }


