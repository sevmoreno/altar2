//
//  EditChurchProfileAllCode.swift
//  altar
//
//  Created by Juan Moreno on 3/16/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//

//
//  NewChurchAllCode.swift
//  altar
//
//  Created by Juan Moreno on 3/15/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//

import Foundation
import Firebase
import FirebaseUI


class NewChurchAllCode: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    var imageToSave: UIImage?
          let accounthelper = AccountHelpers ()
          
          var isUserLoaded = false
    
    
    var ifKeyboardisPressent = false
    
          
    let storageReference = Storage.storage().reference(forURL: "gs://altar-92d12.appspot.com" ).child("users")
         var ref: DatabaseReference!
         
      
         let databaseReference = Database.database().reference()
         
         var selectedChurch = "Favorday Church"
         var churchList = ["Favorday Church","River Church","Rey de Reyes","Not listed"]
    
    let errorLabel: UILabel = {
        
        let a = UILabel ()
        
        a.text = "                   "
        a.textColor = .white
        a.font = UIFont (name: "Avenir", size: 12)
        
        return a
        
    } ()
    
    let contenedor: UIView = {
        
        let a = UIView ()
        
        a.backgroundColor = .red
        
        
        
        return a
        
        
    } ()
    
    let titulo: UILabel = {
        
        let a = UILabel ()
        
        a.font = UIFont(name: "Avenir-Black", size: 24)
        a.text = "Edit church or ministry"
       
        a.backgroundColor = .clear
        a.tintColor = .white
        
        a.textColor = .white
        
        return a
        
    } ()
    
    
    let backgroundName: UIView = {
        
        let a = UIView ()
        
        a.backgroundColor = .white
        
        a.alpha = 0.2
        
        return a
        
        
    } ()
    
    
    
    let name: UITextField = {
        
        let a = UITextField ()
        
        a.textColor = .white
        a.placeholder = "Church Name"
        a.text = "Church Name"
        a.textAlignment = .left
        return a
        
    } ()
    
    
    let addressback: UIView = {
           
           let a = UIView ()
           
           a.backgroundColor = .white
           
           a.alpha = 0.2
           
           return a
           
           
       } ()
       
       
       
       let address: UITextField = {
           
           let a = UITextField ()
           
           a.textColor = .white
           a.placeholder = "Address"
           a.text = "Address"
           a.textAlignment = .left
           return a
           
       } ()
    
    let stateback: UIView = {
              
              let a = UIView ()
              
              a.backgroundColor = .white
              
              a.alpha = 0.2
              
              return a
              
              
          } ()
          
          
          
          let state: UITextField = {
              
              let a = UITextField ()
              
              a.textColor = .white
              a.placeholder = "State"
              a.text = "State"
              a.textAlignment = .left
              return a
              
          } ()
    
    
    let zipcodeback: UIView = {
              
              let a = UIView ()
              
              a.backgroundColor = .white
              
              a.alpha = 0.2
              
              return a
              
              
          } ()
          
          
          
          let zipcode: UITextField = {
              
              let a = UITextField ()
              
              a.textColor = .white
              a.placeholder = "Zip Code"
              a.text = "Zip Code"
              a.textAlignment = .left
              return a
              
          } ()
    
    let countryBack: UIView = {
        
        let a = UIView ()
        
        a.backgroundColor = .white
        
        a.alpha = 0.2
        
        return a
        
        
    } ()
    
    
    
    let country: UITextField = {
        
        let a = UITextField ()
        
        a.textColor = .white
        a.placeholder = "Country"
        a.text = "Country"
        a.textAlignment = .left
        return a
        
    } ()
    let emailback: UIView = {
                 
                 let a = UIView ()
                 
                 a.backgroundColor = .white
                 
                 a.alpha = 0.2
                 
                 return a
                 
                 
             } ()
             
             
             
             let email: UITextField = {
                 
                 let a = UITextField ()
                 
                 a.textColor = .white
                 a.placeholder = "E-mail Address"
                 a.text = "E-mail Address"
                 a.textAlignment = .left
                 return a
                 
             } ()
       
    let phoneBack: UIView = {
                    
                    let a = UIView ()
                    
                    a.backgroundColor = .white
                    
                    a.alpha = 0.2
                    
                    return a
                    
                    
                } ()
                
                
                
                let phonenumber: UITextField = {
                    
                    let a = UITextField ()
                    
                    a.textColor = .white
                    a.placeholder = "Phone number"
                    a.text = "Phone number"
                    a.textAlignment = .left
                    return a
                    
                } ()
    
    let displaybck: UIView = {
                       
                       let a = UIView ()
                       
                       a.backgroundColor = .white
                       
                       a.alpha = 0.2
                       
                       return a
                       
                       
                   } ()
                   
                   
                   
                   let displayname: UITextField = {
                       
                       let a = UITextField ()
                       
                       a.textColor = .white
                       a.placeholder = "Display name"
                       a.text = "Display name"
                       a.textAlignment = .left
                       return a
                       
                   } ()
    let scroollview: UIScrollView = {
        
        let a = UIScrollView ()
        
        a.backgroundColor = .black
        
        return a
        
    } ()
    
    let imagenBackground: UIImageView = {
        
        let a = UIImageView ()
        
        a.image = UIImage(named: "amanecer")
        a.contentMode = .scaleAspectFill
        
        
        return a
        
        
    } ()
    
    
    let graybackground: UIImageView = {
           
           let a = UIImageView ()
           
           a.image = UIImage(named: "bg_dark-1")
           a.contentMode = .scaleAspectFill
           
           
           return a
           
           
       } ()
    
    
    let creatProfile : UIButton = {
        
        let a = UIButton ()
         a.addTarget(self, action: #selector(creatprofile), for: .touchUpInside)
        a.setTitle("Prueba", for: .normal)
        return a
        
    } ()
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        view.addSubview(scroollview)
        
        if ifKeyboardisPressent {
            
            scroollview.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: view.frame.height)
            
        } else {
            
            
            scroollview.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: view.frame.height)
            
            
        }
        
        
        
        
        
        
        
        
        
        scroollview.addSubview(contenedor)
        
  //      contenedor.anchor(top: scroollview.topAnchor, left: scroollview.leftAnchor, bottom: scroollview.bottomAnchor    , right: scroollview.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        
        contenedor.translatesAutoresizingMaskIntoConstraints = false
        
         contenedor.topAnchor.constraint(equalTo: scroollview.topAnchor, constant: 0).isActive = true
         contenedor.rightAnchor.constraint(equalTo: scroollview.rightAnchor, constant: 0).isActive = true
         contenedor.leftAnchor.constraint(equalTo: scroollview.leftAnchor, constant: 0).isActive = true
          contenedor.bottomAnchor.constraint(equalTo: scroollview.bottomAnchor, constant: 0).isActive = true
        contenedor.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        contenedor.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        
        scroollview.bounces = false
      //  scroollview.contentSize.height = 500
        
        
        contenedor.addSubview(imagenBackground)
        
        
        imagenBackground.translatesAutoresizingMaskIntoConstraints = false
        
        

   
        imagenBackground.topAnchor.constraint(equalTo: contenedor.topAnchor, constant: 0).isActive = true
        imagenBackground.bottomAnchor.constraint(equalTo: contenedor.bottomAnchor, constant: 0).isActive = true
        imagenBackground.rightAnchor.constraint(equalTo: contenedor.rightAnchor, constant: 0).isActive = true
        imagenBackground.leftAnchor.constraint(equalTo: contenedor.leftAnchor, constant: 0).isActive = true
        
        
        imagenBackground.contentMode = .scaleToFill
        
        
        
        contenedor.addSubview(graybackground)
               
               
               graybackground.translatesAutoresizingMaskIntoConstraints = false
               
               

          
               graybackground.topAnchor.constraint(equalTo: contenedor.topAnchor, constant: 0).isActive = true
               graybackground.bottomAnchor.constraint(equalTo: contenedor.bottomAnchor, constant: 0).isActive = true
               graybackground.rightAnchor.constraint(equalTo: contenedor.rightAnchor, constant: 0).isActive = true
               graybackground.leftAnchor.constraint(equalTo: contenedor.leftAnchor, constant: 0).isActive = true
               
               
               graybackground.contentMode = .scaleToFill
        
        contenedor.addSubview(creatProfile)
        
        
        
        contenedor.addSubview(titulo)
        
         titulo.translatesAutoresizingMaskIntoConstraints = false
        
        
        titulo.topAnchor.constraint(equalTo: contenedor.topAnchor, constant: 50).isActive = true
        titulo.rightAnchor.constraint(equalTo: contenedor.rightAnchor, constant: -15).isActive = true
        titulo.leftAnchor.constraint(equalTo: contenedor.leftAnchor, constant: 15).isActive = true
        
        titulo.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        titulo.textAlignment = .center
        
        
        
        // **********************************
        
        contenedor.addSubview(backgroundName)
        
         backgroundName.translatesAutoresizingMaskIntoConstraints = false
        
        
        backgroundName.topAnchor.constraint(equalTo: titulo.topAnchor, constant: 60).isActive = true
        backgroundName.rightAnchor.constraint(equalTo: contenedor.rightAnchor, constant: -20).isActive = true
        backgroundName.leftAnchor.constraint(equalTo: contenedor.leftAnchor, constant: 20).isActive = true
        
        backgroundName.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        
        backgroundName.layer.cornerRadius = 22
         backgroundName.layer.masksToBounds = true
        
        contenedor.addSubview(name)

        name.translatesAutoresizingMaskIntoConstraints = false
        
        name.centerYAnchor.constraint(equalTo: backgroundName.centerYAnchor).isActive = true

        name.rightAnchor.constraint(equalTo: backgroundName.rightAnchor, constant: -20).isActive = true
       
        name.leftAnchor.constraint(equalTo: backgroundName.leftAnchor, constant: 20).isActive = true
        
        name.delegate = self
        
        // *********************************************
        
        // **********************************
              
              contenedor.addSubview(addressback)
              
               addressback.translatesAutoresizingMaskIntoConstraints = false
              
              
              addressback.topAnchor.constraint(equalTo: backgroundName.bottomAnchor, constant: 15).isActive = true
              addressback.rightAnchor.constraint(equalTo: contenedor.rightAnchor, constant: -20).isActive = true
              addressback.leftAnchor.constraint(equalTo: contenedor.leftAnchor, constant: 20).isActive = true
              
              addressback.heightAnchor.constraint(equalToConstant: 44).isActive = true
              
              
              addressback.layer.cornerRadius = 22
               addressback.layer.masksToBounds = true
              
              contenedor.addSubview(address)

              address.translatesAutoresizingMaskIntoConstraints = false
              
              address.centerYAnchor.constraint(equalTo: addressback.centerYAnchor).isActive = true

              address.rightAnchor.constraint(equalTo: addressback.rightAnchor, constant: -20).isActive = true
             
              address.leftAnchor.constraint(equalTo: addressback.leftAnchor, constant: 20).isActive = true
              
              address.delegate = self
              
              // *********************************************
              
        
        // **********************************
                     
                     contenedor.addSubview(stateback)
                     
                      stateback.translatesAutoresizingMaskIntoConstraints = false
                     
                     
                     stateback.topAnchor.constraint(equalTo: addressback.bottomAnchor, constant: 15).isActive = true
                     stateback.rightAnchor.constraint(equalTo: contenedor.rightAnchor, constant: -20).isActive = true
                     stateback.leftAnchor.constraint(equalTo: contenedor.leftAnchor, constant: 20).isActive = true
                     
                     stateback.heightAnchor.constraint(equalToConstant: 44).isActive = true
                     
                     
                     stateback.layer.cornerRadius = 22
                      stateback.layer.masksToBounds = true
                     
                     contenedor.addSubview(state)

                     state.translatesAutoresizingMaskIntoConstraints = false
                     
                     state.centerYAnchor.constraint(equalTo: stateback.centerYAnchor).isActive = true

                     state.rightAnchor.constraint(equalTo: stateback.rightAnchor, constant: -20).isActive = true
                    
                     state.leftAnchor.constraint(equalTo: stateback.leftAnchor, constant: 20).isActive = true
                     
                     state.delegate = self
                     
                     // *********************************************
                     
        // **********************************
                           
                           contenedor.addSubview(zipcodeback)
                           
                            zipcodeback.translatesAutoresizingMaskIntoConstraints = false
                           
                           
                           zipcodeback.topAnchor.constraint(equalTo: stateback.bottomAnchor, constant: 15).isActive = true
                           zipcodeback.rightAnchor.constraint(equalTo: contenedor.rightAnchor, constant: -20).isActive = true
                           zipcodeback.leftAnchor.constraint(equalTo: contenedor.leftAnchor, constant: 20).isActive = true
                           
                           zipcodeback.heightAnchor.constraint(equalToConstant: 44).isActive = true
                           
                           
                           zipcodeback.layer.cornerRadius = 22
                            zipcodeback.layer.masksToBounds = true
                           
                           contenedor.addSubview(zipcode)

                           zipcode.translatesAutoresizingMaskIntoConstraints = false
                           
                           zipcode.centerYAnchor.constraint(equalTo: zipcodeback.centerYAnchor).isActive = true

                           zipcode.rightAnchor.constraint(equalTo: zipcodeback.rightAnchor, constant: -20).isActive = true
                          
                           zipcode.leftAnchor.constraint(equalTo: zipcodeback.leftAnchor, constant: 20).isActive = true
                           
                           zipcode.delegate = self
                           
                           // *********************************************
                           // **********************************
                                  
                                  contenedor.addSubview(countryBack)
                                  
                                   countryBack.translatesAutoresizingMaskIntoConstraints = false
                                  
                                  
                                  countryBack.topAnchor.constraint(equalTo: zipcodeback.bottomAnchor, constant: 15).isActive = true
                                  countryBack.rightAnchor.constraint(equalTo: contenedor.rightAnchor, constant: -20).isActive = true
                                  countryBack.leftAnchor.constraint(equalTo: contenedor.leftAnchor, constant: 20).isActive = true
                                  
                                  countryBack.heightAnchor.constraint(equalToConstant: 44).isActive = true
                                  
                                  
                                  countryBack.layer.cornerRadius = 22
                                   countryBack.layer.masksToBounds = true
                                  
                                  contenedor.addSubview(country)

                                  country.translatesAutoresizingMaskIntoConstraints = false
                                  
                                  country.centerYAnchor.constraint(equalTo: countryBack.centerYAnchor).isActive = true

                                  country.rightAnchor.constraint(equalTo: countryBack.rightAnchor, constant: -20).isActive = true
                                 
                                  country.leftAnchor.constraint(equalTo: countryBack.leftAnchor, constant: 20).isActive = true
                                  
                                  country.delegate = self
                                  
                                  // *********************************************
                           
              // **********************************
               
               contenedor.addSubview(emailback)
               
                emailback.translatesAutoresizingMaskIntoConstraints = false
               
               
               emailback.topAnchor.constraint(equalTo: countryBack.bottomAnchor, constant: 15).isActive = true
               emailback.rightAnchor.constraint(equalTo: contenedor.rightAnchor, constant: -20).isActive = true
               emailback.leftAnchor.constraint(equalTo: contenedor.leftAnchor, constant: 20).isActive = true
               
               emailback.heightAnchor.constraint(equalToConstant: 44).isActive = true
               
               
               emailback.layer.cornerRadius = 22
                emailback.layer.masksToBounds = true
               
               contenedor.addSubview(email)

               email.translatesAutoresizingMaskIntoConstraints = false
               
               email.centerYAnchor.constraint(equalTo: emailback.centerYAnchor).isActive = true

               email.rightAnchor.constraint(equalTo: emailback.rightAnchor, constant: -20).isActive = true
              
               email.leftAnchor.constraint(equalTo: emailback.leftAnchor, constant: 20).isActive = true
               
               email.delegate = self
               
               // *********************************************
        
        // **********************************
                     
                     contenedor.addSubview(phoneBack)
                     
                      phoneBack.translatesAutoresizingMaskIntoConstraints = false
                     
                     
                     phoneBack.topAnchor.constraint(equalTo: emailback.bottomAnchor, constant: 15).isActive = true
                     phoneBack.rightAnchor.constraint(equalTo: contenedor.rightAnchor, constant: -20).isActive = true
                     phoneBack.leftAnchor.constraint(equalTo: contenedor.leftAnchor, constant: 20).isActive = true
                     
                     phoneBack.heightAnchor.constraint(equalToConstant: 44).isActive = true
                     
                     
                     phoneBack.layer.cornerRadius = 22
                      phoneBack.layer.masksToBounds = true
                     
                     contenedor.addSubview(phonenumber)

                     phonenumber.translatesAutoresizingMaskIntoConstraints = false
                     
                     phonenumber.centerYAnchor.constraint(equalTo: phoneBack.centerYAnchor).isActive = true

                     phonenumber.rightAnchor.constraint(equalTo: phoneBack.rightAnchor, constant: -20).isActive = true
                    
                     phonenumber.leftAnchor.constraint(equalTo: phoneBack.leftAnchor, constant: 20).isActive = true
                     
                     phonenumber.delegate = self
                     
                     // *********************************************
        
        
        // **********************************
                            
                            contenedor.addSubview(displaybck)
                            
                             displaybck.translatesAutoresizingMaskIntoConstraints = false
                            
                            
                            displaybck.topAnchor.constraint(equalTo: phoneBack.bottomAnchor, constant: 15).isActive = true
                            displaybck.rightAnchor.constraint(equalTo: contenedor.rightAnchor, constant: -20).isActive = true
                            displaybck.leftAnchor.constraint(equalTo: contenedor.leftAnchor, constant: 20).isActive = true
                            
                            displaybck.heightAnchor.constraint(equalToConstant: 44).isActive = true
                            
                            
                            displaybck.layer.cornerRadius = 22
                             displaybck.layer.masksToBounds = true
                            
                            contenedor.addSubview(displayname)

                            displayname.translatesAutoresizingMaskIntoConstraints = false
                            
                            displayname.centerYAnchor.constraint(equalTo: displaybck.centerYAnchor).isActive = true

                            displayname.rightAnchor.constraint(equalTo: displaybck.rightAnchor, constant: -20).isActive = true
                           
                            displayname.leftAnchor.constraint(equalTo: displaybck.leftAnchor, constant: 20).isActive = true
                            
                            displayname.delegate = self
                            
                            // *********************************************
          
        
            creatProfile.translatesAutoresizingMaskIntoConstraints = false
             creatProfile.topAnchor.constraint(equalTo: displayname.bottomAnchor, constant: 50).isActive = true
              creatProfile.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            creatProfile.widthAnchor.constraint(equalToConstant: 300).isActive = true
            creatProfile.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        
        
        creatProfile.backgroundColor = UIColor.rgb(red: 247, green: 131, blue: 97)
        creatProfile.layer.cornerRadius = 22
        creatProfile.layer.masksToBounds = true
        creatProfile.setTitleColor(.white , for: .normal)
        creatProfile.setTitle("Sign in", for: .normal)
        creatProfile.setTitleColor(UIColor.white.withAlphaComponent(0.3), for: .highlighted )
        creatProfile.applyGradient(colors: [WelcomeViewController.UIColorFromRGB(0xF78361).cgColor,WelcomeViewController.UIColorFromRGB(0xF54B64).cgColor])
        
        creatProfile.isEnabled = false
        
        
        contenedor.addSubview(errorLabel)
        
        errorLabel.anchor(top: creatProfile.bottomAnchor, left: contenedor.leftAnchor, bottom: nil, right: contenedor.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0)
        
        errorLabel.textAlignment = .center
         
       //  imagenBackground.anchor(top: contenedor.topAnchor, left: contenedor.leftAnchor, bottom: contenedor.bottomAnchor    , right: contenedor.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
    }
    
    
    var sizeScrool: CGFloat = 0.0
    
    override func viewDidLoad() {
        
        
        accounthelper.loadCurrentUserInfo(completionHandler: { (success) -> Void in
                     
                     if success {
                         self.isUserLoaded = true
                        self.creatProfile.isEnabled = true
                        
                     }
                         
                     
                 })
        
        
      let notificationCenter = NotificationCenter.default
                                notificationCenter.addObserver(self, selector: #selector(keyboardWillHideNew), name: UIResponder.keyboardWillHideNotification, object: nil)
                                notificationCenter.addObserver(self, selector: #selector(keyboardWillShowNew), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
                            // And that's it!
                         }

                    @objc func keyboardWillShowNew(notification: NSNotification) {
                        
                        print(view.frame.height)
                        
                     sizeScrool = view.frame.height - (getKeyboardHeight(notification: notification))
                     self.scroollview.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = false
                        
                     scroollview.heightAnchor.constraint(equalToConstant: sizeScrool).isActive = true
                     
                     
                        
//
//                           if view.frame.origin.y >= 0 {
//                               scroollview.heightAnchor.constraint(equalToConstant: sizeScrool).isActive = true
//                              // view.frame.origin.y -= (getKeyboardHeight(notification: notification) - 100)
//                               print("Se va a mostrar")
//                           }
                       }
    
                       @objc func keyboardWillHideNew(notification: NSNotification) {
                        
                        
                        scroollview.constraints.forEach { (constraint) in
                                     if constraint.firstAttribute == .height {
                                         constraint.constant = view.frame.height
                                     }
                                 }
                        
                        
                        
                      //  scroollview.heightAnchor.constraint(equalToConstant: sizeScrool).isActive = false
                   
                           // self.scroollview.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
                            self.view.layoutIfNeeded()
                       
                        
                       
                       // scroollview.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
                        
                        print(view.frame.height)

//                           if (self.view.frame.origin.y < 0) {
//                             //  view.frame.origin.y += getKeyboardHeight(notification: notification)
//                             view.frame.origin.y = 0
//                            scroollview.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
//
//
//                           }
                       }
                       
                       func unsubscribeFromKeyboardNotifications() {
                           NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
                           NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
                       }
                       
                       
                       
                       func getKeyboardHeight(notification: NSNotification) -> CGFloat {
                           let userInfo = notification.userInfo
                           let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
                           return keyboardSize.cgRectValue.height
                       }
                
        //        @objc func churchSe
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
               textField.text = ""
               
           }
           
           
           func textFieldShouldReturn(_ textField: UITextField) -> Bool {
               self.view.endEditing(true)
               return false
           }
    
    
    
    
    @objc func creatprofile(_ sender: Any) {
                
                name.text != "Name" &&
                displayname.text != "Display name" &&
                email.text != "Email"
                
                
                guard name.text != "", email.text != "", displayname.text != "", name.text != "Name",
                displayname.text != "Display name",
                email.text != "Email"
                
                    else {
                     errorLabel.text = "Please add your Church name, email adrress, and display name."
                    return}
                
                
                guard displayname.text!.count > 1 && displayname.text!.count < 20  else {
                    errorLabel.text = "Display name must be less than 20 characters."
                    return
                }
                
                
                if name.text != "" && email.text != "" && displayname.text != "" &&
                    name.text != "Name" &&
                    displayname.text != "Display name" &&
                    email.text != "Email"
                    
                    
                    {
                    
                    guard let usuarioNumber = Auth.auth().currentUser?.uid else {return}
                        accounthelper.creatChurch(userID: usuarioNumber, name: name.text!, address: address.text ?? "", state: state.text ?? "", country: country.text ?? "", zipCode: zipcode.text ?? "", email: email.text!, facebook: "", instragram: "", webSite: "" ?? "", phoneNumber: phonenumber.text ?? "", displayname: displayname.text!, completionHandler: { (success) -> Void in
                        
                        
                        
                        if success {
    //                        self.ref = self.databaseReference
    //
    //                        let userinfo: [String:Any] = ["church": advengers.shared.currentChurch, "churchID": advengers.shared.currentChurchInfo.uidChurch]
    //
    //                        guard let userID = Auth.auth().currentUser?.uid else {return}
    //
    //                        self.ref.child("users").child(userID).updateChildValues(userinfo)
    //
    //                        self.accounthelper.loadFirstContent()
                          //   self.performSegue(withIdentifier: "welcome", sender: self)
                            self.navigationController?.popToRootViewController(animated: true)
                          //  advengers.shared.isPastor =  true
                            advengers.shared.currentChurch = self.displayname.text!
                            
                        }
                        
                        
                    })
                    
                    
                }
    
    
}

}
