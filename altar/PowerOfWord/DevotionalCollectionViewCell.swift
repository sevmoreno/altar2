//
//  DevotionalCollectionViewCell.swift
//  altar
//
//  Created by Juan Moreno on 1/6/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//

import Firebase

protocol devotionalDelegate {

    func deletCellD(for cell: DevotionalCollectionViewCell)
}

class DevotionalCollectionViewCell: UICollectionViewCell, UIGestureRecognizerDelegate {
    
    
     var delegate: devotionalDelegate?
    
    var post: Devo? {
        
        didSet {
           
              guard let imagenDevo = post!.photoURL else { return }
            
             imagenDevocional.loadImage(urlString: imagenDevo)
            imagenDevocional.contentMode = .scaleAspectFill
            guard let titulotext = post?.title else { return }
            
            titulo.text = titulotext
            
            
            let fecha = post?.creationDate
                     //  let fecha = Date(milliseconds: Int64(post?.creationDate ?? 0))
                       
            praysDate.text = fecha!.timeAgoDisplay()
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
    
    
    
    
    lazy var imagenDevocional: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
          iv.clipsToBounds = true
       iv.backgroundColor = .blue
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
    
    lazy var praysDate: UILabel = {
                 let label2 = UILabel ()
                 label2.font = UIFont(name: "Avenir-Medium", size: 12)
                 label2.text = ""
                 label2.textColor = .white
                 label2.layer.backgroundColor = advengers.shared.colorOrange.cgColor
        label2.layer.cornerRadius = 5
        label2.padding = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
              //   button.setImage(UIImage(named: "cellPrayIcon")?.withRenderingMode(.alwaysOriginal), for: .normal)
                // button.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
                 return label2
             }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    addSubview(imagenDevocional)
        
    imagenDevocional.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        addSubview(titulo)
        
        titulo.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 15, paddingBottom: 30, paddingRight: 0, width: frame.size.width, height: 0)
       // titulo.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        
      //  imagenDevocional.image = UIImage(named: "devoback1")
        
        
        addSubview(praysDate)
        praysDate.anchor(top: nil, left: titulo.leftAnchor, bottom: titulo.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: 0, height: 0)
        
        //titulo.heightAnchor.constraint(equalToConstant: 140).isActive = true
       // titulo.widthAnchor.constraint(equalToConstant: 140).isActive = true
      //  titulo.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
     //   titulo.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 40).isActive = true

        
//        addSubview(imagenDevocional)
//        
//        addSubview(titulo)
//        
////        imagenDevocional.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: imagenDevocional.frame.width, height: 0)
////
////        titulo.anchor(top: nil, left: leftAnchor, bottom: imagenDevocional.bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: 0, height: 0)
//        
//        addSubview(imagenDevocional)
//        imagenDevocional.translatesAutoresizingMaskIntoConstraints = false
//    
//        imagenDevocional.heightAnchor.constraint(equalToConstant: 140).isActive = true
//        imagenDevocional.widthAnchor.constraint(equalToConstant: 140).isActive = true
//        imagenDevocional.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//        imagenDevocional.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
////
//
       
        let swipeCell = UISwipeGestureRecognizer(target: self, action: #selector(hiddenContainerViewTapped))
                swipeCell.direction = .left
                swipeCell.delegate = self
                
                addGestureRecognizer(swipeCell)

            }
            
            
            @objc func hiddenContainerViewTapped () {
                
                
                if advengers.shared.isPastor == true {

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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
