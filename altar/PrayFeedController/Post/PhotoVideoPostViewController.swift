//
//  PhotoVideoPostViewController.swift
//  altar
//
//  Created by Juan Moreno on 11/12/19.
//  Copyright © 2019 Juan Moreno. All rights reserved.
//

import UIKit
import Firebase

class PhotoVideoPostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
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
    
    let  textoIngresado: UITextView = {
        
        let a = UITextView ()
        
        
        return a
        
    } ()
    
    
    var picker = UIImagePickerController ()
    
    let imageToDisplay: UIImageView = {
        
        let imagen = UIImageView ()
        imagen.contentMode = .scaleAspectFit
        return imagen
    } ()
    
    
    let postIt: UIButton = {
        
               let button = UIButton()
               button.setTitle("Post", for: .normal)
               button.backgroundColor = .black
               button.layer.cornerRadius = 5
               button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
               button.setTitleColor(.white, for: .normal)
            button.addTarget(self, action: #selector (postImageAndText), for: .touchUpInside)
               return button

    } ()
    
    let accessory: UIView = {
          
          let accessoryView = UIView(frame: .zero)
          accessoryView.backgroundColor = .lightGray
          accessoryView.alpha = 0.6
          return accessoryView
      }()
      
      let cancelButton: UIButton = {
           let cancelButton = UIButton(type: .custom)
           cancelButton.setTitle("Done", for: .normal)
           cancelButton.setTitleColor(UIColor.blue, for: .normal)
           cancelButton.addTarget(self, action:
           #selector(nextButton), for: .touchUpInside)
           cancelButton.showsTouchWhenHighlighted = true
           return cancelButton
       }()
      
    @objc func nextButton () {
        self.view.endEditing(true)
    }
    
    
    
    var isImage: UIImage?
    var isVideo: String?
    
    override func viewDidLoad() {
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
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
        usernameLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        usernameLabel.centerYAnchor.constraint(equalTo: userProfileImageView.centerYAnchor).isActive = true
         // usernameLabel.topAnchor.constraint(equalTo: userProfileImageView.topAnchor, constant:10).isActive = true
         usernameLabel.leftAnchor.constraint(equalTo: userProfileImageView.rightAnchor, constant: 8).isActive = true
        
        textoIngresado.delegate = self
        picker.delegate = self
        textoIngresado.text = "Say something about this photo ..."
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Post", style: .plain, target: self, action: #selector(postImageAndText))


        
        if isImage != nil {
            
            DispatchQueue.main.async {
                self.imageToDisplay.image = self.isImage
            }
            
           
        }
        textoIngresado.backgroundColor = .white
        
        
        view.backgroundColor = .white
        
        view.addSubview(imageToDisplay)
        let ratio: CGFloat = isImage!.size.width / isImage!.size.height
        imageToDisplay.anchor(top: userProfileImageView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width , height: view.frame.width / ratio)
      
 
   //     imageToDisplay.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 400, height: 400)

        
         view.addSubview(textoIngresado)
      //  view.addSubview(postIt)
        
        
        textoIngresado.anchor(top: imageToDisplay.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 30, paddingBottom: 80, paddingRight: 30, width: 0, height: 0)
        
        
        addAccessory()
        
       // postIt.heightAnchor.constraint(equalToConstant: 40).isActive = true
       // postIt.widthAnchor.constraint(equalToConstant: 140).isActive = true
       // postIt.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
      //  postIt.topAnchor.constraint(equalTo: textoIngresado.bottomAnchor, constant: 100).isActive = true
             
        
     //     postIt.anchor(top: nil, left: nil, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 100, paddingRight: 0, width: 200, height: 30)
     
      //    postIt.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

       
    }
    

    @objc func postImageAndText(_ sender: Any) {
        
        
        AppDelegate.instance().showActivityIndicatior()
        
        let uid = Auth.auth().currentUser?.uid
        
        let nombreToDisplay = advengers.shared.currenUSer["name"] ?? "Unknow"
        let userphot = advengers.shared.currenUSer["photoURL"] ?? "No cargo"
        
        let key = advengers.shared.postPrayFeed.childByAutoId().key
        
        let imageRef = advengers.shared.PostPrayStorage.child(uid!).child("\(key!).jpg")
        
        let data = isImage?.jpegData(compressionQuality: 0.6)
       
        
        let uploadTask = imageRef.putData(data!, metadata: nil) { (matadata, error) in
            
            if error != nil {
                print(error.debugDescription)
            }
            
            
            imageRef.downloadURL(completion: { (url, error) in
                if let url = url {
                    
                    let feed = ["userid": uid,
                                "pathtoPost":url.absoluteString,
                                "prays": 0,
                                "author": nombreToDisplay,
                                "userPhoto": userphot,
                                "postID": key,
                                "creationDate": Date().millisecondsSince1970,
                                "postType": advengers.postType.textImage.rawValue,
                                "message": self.textoIngresado.text,
                                "imagH:": self.isImage!.size.height,
                                "imagW:": self.isImage!.size.width
                        
                        
                        
                        ] as! [String:Any]
                    
                    let postfeed = ["\(key!)" : feed] as! [String:Any]
                  
                    guard let currentChurchID = advengers.shared.currenUSer["churchID"] as? String else { return }
                    advengers.shared.postPrayFeed.child(currentChurchID).updateChildValues(postfeed)
                 //   advengers.shared.postPrayFeed.updateChildValues(postfeed)
                    
                    AppDelegate.instance().dismissActivityIndicator()
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UpdateFeed"), object: nil)
                    _ = self.navigationController?.popToRootViewController(animated: true)
                    
                    
                }
            })
            
        }
        
        uploadTask.resume()
        
        
    }
    
    func addAccessory() {
              accessory.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 45)
              accessory.translatesAutoresizingMaskIntoConstraints = false
              cancelButton.translatesAutoresizingMaskIntoConstraints = false
       //       charactersLeftLabel.translatesAutoresizingMaskIntoConstraints = false
         //     sendButton.translatesAutoresizingMaskIntoConstraints = false
              textoIngresado.inputAccessoryView = accessory
              accessory.addSubview(cancelButton)
             
       //    cancelButton.anchor(top: nil, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 4, width: 0, height: 0)
           
            //  accessory.addSubview(charactersLeftLabel)
             // accessory.addSubview(sendButton)
         
              NSLayoutConstraint.activate([
              cancelButton.trailingAnchor.constraint(equalTo:
              accessory.trailingAnchor, constant: -20),
              cancelButton.centerYAnchor.constraint(equalTo:
              accessory.centerYAnchor)
              ])
          
          }
    
   @objc func keyboardWillShow(notification: NSNotification) {
    
    guard let userInfo = notification.userInfo else {return}
    guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
    let keyboardFrame = keyboardSize.cgRectValue
    if self.view.frame.origin.y == 0{
        self.view.frame.origin.y -= (keyboardFrame.height - 100)
    }
    
    }
    
    
   @objc func keyboardWillHide(notification: NSNotification) {
    guard let userInfo = notification.userInfo else {return}
    guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
    let keyboardFrame = keyboardSize.cgRectValue
    if self.view.frame.origin.y != 0{
        self.view.frame.origin.y += (keyboardFrame.height - 100)
    }
    }
    
}

extension PhotoVideoPostViewController: UITextViewDelegate {
    
    
    func textViewDidChange(_ textView: UITextView) {
    //    adjustUITextViewHeight(arg: textoIngresado)

    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        textView.text = ""
        
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
      
        
    }
    
    func adjustUITextViewHeight(arg : UITextView)
      {
          arg.translatesAutoresizingMaskIntoConstraints = true
          arg.sizeToFit()
          arg.isScrollEnabled = false
      }
    
}
