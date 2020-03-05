//
//  textOnlyCell.swift
//  altar
//
//  Created by Juan Moreno on 12/22/19.
//  Copyright © 2019 Juan Moreno. All rights reserved.
//

import UIKit
import Firebase

protocol textOnlyDelegate {
    func textOnlyDelegate_didTapComment(post: Posts)
    func textOnlyDelegate_didLike(for cell: textOnlyCell)
    func deletCellD(for cell: textOnlyCell)
}




class textOnlyCell: UICollectionViewCell, UIGestureRecognizerDelegate {
    
    var delegate: textOnlyDelegate?
    
    var post: Posts? {
        
        didSet {

                       usernameLabel.text = post?.author
                       guard let profileuserURL = post?.userPhoto else {return}
                       userProfileImageView.loadImage(urlString: profileuserURL)
            
            
            
         //   likeButton.setImage(post?.hasLiked == true ? #imageLiteral(resourceName: "pray").withRenderingMode(.alwaysOriginal) : #imageLiteral(resourceName: "pray2").withRenderingMode(.alwaysOriginal), for: .normal)
       
            
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
      

    
            setupAttributedCaption()
            
            
        }
        
    }
    

    
    fileprivate func setupAttributedCaption() {
        guard let post = self.post else { return }
        
        let attributedText = NSMutableAttributedString(string: " \(post.message ?? "Defaul Value")", attributes: [NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 15)])
        
     //   attributedText.append(NSAttributedString(string: " \(post.message ?? "Defaul Value")", attributes: [NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 15)]))
        
     //   attributedText.append(NSAttributedString(string: "\n\n", attributes: [NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 15)]))

        
        captionLabel.attributedText = attributedText
    }
    

    
    
    
    
    // NEW DESGIN CODE  ----------------------------------
    
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
    
    // --------------------------------------------------------------------
    
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
        print("Handling like from within cell...text only")
        delegate?.textOnlyDelegate_didLike(for: self)
    }
    
    lazy var commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "icon-comment-1").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleComment), for: .touchUpInside)
        //button.addTarget(self, action: #selector(clickcomment), for: .touchUpInside)
        
        return button
    }()
    
    
    
    @objc func handleComment() {
        print("Trying to show comments...on only text")
        guard let post = post else { return }
        
        delegate?.textOnlyDelegate_didTapComment(post: post)
        
    }
    
    let sendMessageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "icon-play").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let bookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "icon-play").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    
    let captionLabel: UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: "Avenir-Book", size: 15)
        textView.isEditable = false
        //        label.numberOfLines = 0
        //        label.backgroundColor = .lightGray
        textView.isScrollEnabled = false
        return textView
    }()
    
 //   let captionLabel: UILabel = {
 //       let label = UILabel()
 //       label.numberOfLines = 0
 //       label.isScrollEnabled = false
 //       return label
 //   }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
            
    
        
             addSubview(userProfileImageView)
             addSubview(usernameLabel)
             addSubview(optionsButton)
        
            
        userProfileImageView.layer.borderWidth = 1
        userProfileImageView.layer.borderColor = advengers.shared.colorOrange.cgColor

           
             userProfileImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 15, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
             userProfileImageView.layer.cornerRadius = 50 / 2
             
             usernameLabel.anchor(top: userProfileImageView.topAnchor, left: userProfileImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
             
         addSubview(praysDate)
        praysDate.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 30, width: 0, height: 0)
         praysDate.centerYAnchor.constraint(equalTo: usernameLabel.centerYAnchor).isActive = true
            //  optionsButton.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 44, height: 0)
             

             
          
             
             addSubview(captionLabel)
             captionLabel.anchor(top: userProfileImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
             
             let stackView = UIStackView(arrangedSubviews: [likeButton,likeCount,commentButton,commentCount])
            stackView.distribution = .fillProportionally
                    
            addSubview(stackView)
         //   addSubview(praysCount)
           stackView.anchor(top: captionLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 8, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 200, height: 50)
      //  praysCount.anchor(top: captionLabel.bottomAnchor, left: nil, bottom: bottomAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, width: 100, height: 50)
           // praysCount.text = "Hola"
           // addSubview(praysCount)
           // praysCount.centerYAnchor.constraint(equalTo: stackView.centerYAnchor).isActive = true
            //raysCount.rightAnchor.constraint(equalTo: rightAnchor, constant: 8).isActive = true
             
            
            

////        addSubview(scrollView)
////        scrollView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: frame.width, height: frame.height)
//
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hiddenContainerViewTapped))
//        //scrollView.addGestureRecognizer(tapGestureRecognizer)
//
//        textOnlyCell.U
        
        //        let contenedor = UIView()
        //
        //        addSubview(contenedor)
        //
        //        contenedor.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        //        contenedor.backgroundColor = .red
        //        contenedor.alpha = 0.40
        //        contenedor.isUserInteractionEnabled = true
        //        contenedor.addGestureRecognizer(swipeCell)
                //textOnlyCell?.addGestureRecognizer(swipeCell)
        
        if advengers.shared.isPastor == true {
        let swipeCell = UISwipeGestureRecognizer(target: self, action: #selector(hiddenContainerViewTapped))
        swipeCell.direction = .left
        swipeCell.delegate = self
        
        addGestureRecognizer(swipeCell)
        }
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
    
  
   
    fileprivate func setupActionButtons() {
        
       

        
    }
    
}

