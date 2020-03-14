//
//  EventoSeleccionado.swift
//  altar
//
//  Created by Juan Moreno on 2/18/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//

import Foundation
import UIKit

import Firebase

//protocol deleteDelegate {
//
//    func deleteEvennt(controller:UIViewController)
//}
class EventoSeleccionado: UIViewController {
    
    var devo = Event(dictionary: ["text":"text"])
    let imagen: CustomImageView = {
               let iv = CustomImageView()
               iv.contentMode = .scaleAspectFill
            
               iv.clipsToBounds = true
               iv.backgroundColor = .blue
               return iv
           }()
           
    
    lazy var titulo: UILabel = {
                 let label2 = UILabel ()
                 label2.font = UIFont(name: "Avenir-Heavy", size: 25)
                 label2.text = "You prayed 1"
              label2.textColor = .white
              //   button.setImage(UIImage(named: "cellPrayIcon")?.withRenderingMode(.alwaysOriginal), for: .normal)
                // button.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
        label2.textAlignment = .center
                 return label2
             }()
       
    lazy var deleteButton : UIButton = {
        
        
        
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "trash")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(deleteEvent), for: .touchUpInside)
        
      return button
        
    } ()
    
    @objc func deleteEvent () {
        
        
        print("Pimer llamado")
        //delegate?.deleteEvennt(controller: self)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "deleteEvent"), object: nil)
        //deleteEvent
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    let textoDevocional: UITextView = {
        
        let a = UITextView ()
        
        
        return a
        
    } ()
    
     //var delegate: deleteDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
      //  devo = advengers.shared.devocionalSeleccinado
        
     //   view.backgroundColor = .white
       // textoDevocional.loadAttributedText(urlString: devo.urltexto)
        
        view.addSubview(imagen)
        
        view.addSubview(titulo)
        
        view.addSubview(textoDevocional)
        
        if advengers.shared.isPastor {
        view.addSubview(deleteButton)
        
        deleteButton.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 100, paddingLeft: 15, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
            
                       
                      textoDevocional.delegate = self
                      addAccessory()
                      navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editDevo))
        
        } else {
            textoDevocional.isEditable = false
            
        }
        imagen.loadImage(urlString: advengers.shared.eventolSeleccinado.photoURL!)
        
        titulo.text = advengers.shared.eventolSeleccinado.title
        titulo.textAlignment = .center
        titulo.font = UIFont(name: "Avenir-Heavy", size: 18)
   //     view.addSubview(textoDevocional)
        titulo.numberOfLines = 0
        imagen.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 300)
        
       
        titulo.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 10, paddingRight: 0, width: 0, height: 0)
        titulo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titulo.centerYAnchor.constraint(equalTo: imagen.centerYAnchor).isActive = true

        
        textoDevocional.anchor(top: imagen.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0, height: 0)
        
        let loading = NSAttributedString(string: "Loading...")
        DispatchQueue.main.async {
                           self.textoDevocional.attributedText = loading
                           }
      //  print(devo.urltexto)
    //   print(devo.title)
    //    guard let url = URL(string: devo.urltexto) else { return }
        guard let url = URL(string: advengers.shared.eventolSeleccinado.urltexto) else { return }
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                if let err = err {
                    print("Failed to fetch HTML:", err)
                    return
                }
                

               // if let attributedString = try! NSAttributedString(data: data!, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
                let attributedString = try! NSAttributedString(data: data!, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
                    print("Este es el texto que bajo")
                    print(attributedString)
                    
                   DispatchQueue.main.async {
                    self.textoDevocional.attributedText = attributedString
                    }
          //
               
        }.resume()
        
        
  tamanodefault = view.frame.height - imagen.frame.height - 200
                
                let notificationCenter = NotificationCenter.default
                                    notificationCenter.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
                                    notificationCenter.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
                                // And that's it!
                             }
            
            
            var tamanodefault = CGFloat()

                        @objc func keyboardWillShow(notification: NSNotification) {
                            
                            
                          //  let size = CGSize(width: view.frame.width, height: .infinity)
                          //  let estimatedSize = devText.sizeThatFits(size)
                            
                            
                            textoDevocional.constraints.forEach { (constraint) in
                                if constraint.firstAttribute == .height {
                                    constraint.constant = tamanodefault - getKeyboardHeight(notification: notification) + 70
                                }
                            }
                            
                //               if view.frame.origin.y >= 0 {
                //
                //                view.frame.origin.y -=
                //
                //
                //              view.reloadInputViews()
                //
                //
                //                print("Se va a mostrar")
                //               }
                           }
                           
                           @objc func keyboardWillHide(notification: NSNotification) {
                               textoDevocional.constraints.forEach { (constraint) in
                                
                                   if constraint.firstAttribute == .height {
                                       constraint.constant = tamanodefault
                                   }
                               }
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
            @objc func editDevo () {
                
                textoDevocional.isEditable = true
                navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Post", style: .plain, target: self, action: #selector(postEdit))
                
            }
            
            @objc func postEdit (){
                
                        
                 
                
                
                        let currentChurchID = advengers.shared.currentChurchInfo.uidChurch
                       //  guard let currentChurchID = advengers.shared.currenUSer["churchID"] as? String else { return }
                        let userPostRef = Database.database().reference().child("Events").child(currentChurchID)
                        
                let uidtoEdit = advengers.shared.eventolSeleccinado.postID
                        
                        let ref = userPostRef.child(uidtoEdit!)
                      var fondo = advengers.shared.eventolSeleccinado.photoURL
                        if advengers.shared.fondoSeleccionado == "" {
                            fondo = "https://firebasestorage.googleapis.com/v0/b/altar-92d12.appspot.com/o/backgroundsDevSR%2F-M-qdkcToEv4HU051_Iq?alt=media&token=c81ad0f4-ee3b-459c-89f2-7b5be3f7c7b6"
                        } else {
                            fondo = advengers.shared.fondoSeleccionado
                        }

                       
                        let attrString = textoDevocional.attributedText
                        guard let x = attrString else {return}
                        var resultHtmlText = ""
                        do {

                            let r = NSRange(location: 0, length: x.length)
                            let att = [NSAttributedString.DocumentAttributeKey.documentType: NSAttributedString.DocumentType.html]
                            let d = try x.data(from: r, documentAttributes: att)

                            if let h = String(data: d, encoding: .utf8) {
                                resultHtmlText = h
                                
                   // ------------------------------------ ACA SALVAMOS AL STORAGE LA DATA  ---------------------------------
                                let filename = NSUUID().uuidString
                                let storageRefDB = Storage.storage().reference().child("Events").child(currentChurchID).child(filename)
                                storageRefDB.putData(d, metadata: nil, completion: { (metadata, err) in
                                    
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
                                        
                                        guard let htmlfileURL = downloadURL?.absoluteString else { return }
                                        
                                        guard let uid = Auth.auth().currentUser?.uid else {return}
                                    
                //
                //                        self.author = dictionary["author"] as? String ?? ""
                //                                      self.church = dictionary["church"] as? String ?? ""
                //                                      self.title = dictionary["title"] as? String
                //                                      self.urltexto = dictionary["urltexto"] as? String
                //                                      self.photoURL = dictionary["photoURL"] as? String
                //
                //
                //                                      self.postID = dictionary["postID"] as? String ?? ""
                //                                      self.message = dictionary["message"] as? String ?? ""
                //
                //                               let secondsFrom1970 = dictionary["creationDate"] as? Int64 ?? 0
                                     //   let devfondo = devocionalFondo ()
                                    
                                                              
                                        
                                        
                                        
                                        let event = ["urltexto": htmlfileURL,
                                                    "church" : currentChurchID,
                                                    "author": Auth.auth().currentUser?.uid,
                                                    "message": self.textoDevocional.text ,
                                                    "photoURL": fondo ,
                                                    "postID": uidtoEdit,
                                                    
                                                    "title": self.titulo.text!,
                                                    "creationDate": Date().millisecondsSince1970] as [String : Any]
                                        
                                        ref.updateChildValues(event) { (err, ref) in
                                            if let err = err {
                                                //self.navigationItem.rightBarButtonItem?.isEnabled = true
                                                print("Failed to save post to DB", err)
                                                return
                                            }
                                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadDevotional"), object: nil)
                                            print("Successfully saved post to DB")
                                            
                                        }
                      
                                
                                    })
                                })
                                

                                
                            }
                        }
                        catch {
                            print("utterly failed to convert to html!!! \n>\(x)<\n")
                        }
                        print(resultHtmlText)
                        
                
                         NotificationCenter.default.post(name: NSNotification.Name("loadEvent"), object: nil)
                        
                        _ = navigationController?.popViewController(animated: true)

                
            }
            
            var attributedString = NSMutableAttributedString(string: "")
            var devocionalRichText = [NSAttributedString] ()
            
             var attributes = [
                          
                        //  NSAttributedString.Key.underlineStyle : 1,
                          NSAttributedString.Key.foregroundColor : UIColor.black,
                          NSAttributedString.Key.font: UIFont(name: "Avenir-Book", size: 15)
                        //  NSAttributedString.Key.strokeWidth : 3.0
                             
                          ] as [NSAttributedString.Key : Any]
               
               var boldActive = false
               var italicIsActive = false
               
               lazy var accessory: UIView = {
                   let accessoryView = UIView(frame: .zero)
                   //accessoryView.backgroundColor = .lightGray
                   accessoryView.alpha = 0.6
                   return accessoryView
               }()
               let IndexButton: UIButton = {
                   let cancelButton = UIButton(type: .custom)
                  // cancelButton.setTitle("Index", for: .normal)
                   let imagen = UIImage(named: "indexButton")
                   cancelButton.setImage(imagen?.withRenderingMode(.alwaysOriginal), for: .normal)
                   cancelButton.setTitleColor(UIColor.red, for: .normal)
                   cancelButton.addTarget(self, action:
                   #selector(indexButtonAction), for: .touchUpInside)
                   cancelButton.showsTouchWhenHighlighted = true
                   return cancelButton
               }()
               
               let captialsButton: UIButton = {
                    let cancelButton = UIButton(type: .custom)
                 //   cancelButton.setTitle("Aa", for: .normal)
                   let imagen = UIImage(named: "capitalButton")
                         cancelButton.setImage(imagen?.withRenderingMode(.alwaysOriginal), for: .normal)
                   // cancelButton.setTitleColor(UIColor.red, for: .normal)
                    cancelButton.addTarget(self, action:
                    #selector(capitalButtonAction), for: .touchUpInside)
                    cancelButton.showsTouchWhenHighlighted = true
                    return cancelButton
                }()
               
               
               lazy var boldsButton: UIButton = {
                       let cancelButton = UIButton(type: .custom)
                     //  cancelButton.setTitle("n", for: .normal)
                      // cancelButton.setTitleColor(UIColor.red, for: .normal)
                   let imagen = UIImage(named: "boldbutton")
                   cancelButton.setImage(imagen?.withRenderingMode(.alwaysOriginal), for: .normal)
                          // cancelButton.setTitleColor(UIColor.red, for: .normal)
                       cancelButton.addTarget(self, action:
                       #selector(boldlButtonAction), for: .touchUpInside)
                       cancelButton.showsTouchWhenHighlighted = true
                       return cancelButton
                   }()
              
               
               let italicButton: UIButton = {
                           let cancelButton = UIButton(type: .custom)
                          // cancelButton.setTitle("i", for: .normal)
                          // cancelButton.setTitleColor(UIColor.red, for: .normal)
                   
                   let imagen = UIImage(named: "italicButton")
                   cancelButton.setImage(imagen?.withRenderingMode(.alwaysOriginal), for: .normal)
                           cancelButton.addTarget(self, action:
                           #selector(italicButtonAction), for: .touchUpInside)
                           cancelButton.showsTouchWhenHighlighted = true
                           return cancelButton
                       }()
               
              let bigger: UIButton = {
                       let cancelButton = UIButton(type: .custom)
                       // cancelButton.setTitle("+", for: .normal)
                      // cancelButton.setTitleColor(UIColor.red, for: .normal)
               
               let imagen = UIImage(named: "bigtypoButton")
               cancelButton.setImage(imagen?.withRenderingMode(.alwaysOriginal), for: .normal)
                       cancelButton.addTarget(self, action:
                       #selector(biggerButtonAction), for: .touchUpInside)
                       cancelButton.showsTouchWhenHighlighted = true
                       return cancelButton
                   }()
               
               let fontSize: UILabel = {
                   
                   let a = UILabel ()
                   
                   a.font = UIFont(name: "Avenir",size: 15)
                   a.textColor = .white
                   a.text = String (15)
                   a.sizeToFit()
                 //  a.sizeThatFits(10)
                   return a
                   
               } ()
               
               let small: UIButton = {
                        let cancelButton = UIButton(type: .custom)
                       // cancelButton.setTitle("-", for: .normal)
                       // cancelButton.setTitleColor(UIColor.red, for: .normal)
                   
                   let imagen = UIImage(named: "smalltypoButton")
                      cancelButton.setImage(imagen?.withRenderingMode(.alwaysOriginal), for: .normal)
                        cancelButton.addTarget(self, action:
                        #selector(smallButtonAction), for: .touchUpInside)
                        cancelButton.showsTouchWhenHighlighted = true
                        return cancelButton
                    }()
               
               let doneButton: UIButton = {
                        let cancelButton = UIButton(type: .custom)
                   
                   let imagen = UIImage(named: "doneButton")
                   cancelButton.setImage(imagen?.withRenderingMode(.alwaysOriginal), for: .normal)
                     //   cancelButton.setTitle("Done", for: .normal)
                       // cancelButton.setTitleColor(UIColor.red, for: .normal)
                        cancelButton.addTarget(self, action:
                        #selector(doneButtonAction), for: .touchUpInside)
                        cancelButton.showsTouchWhenHighlighted = true
                        return cancelButton
                    }()
                
               func addAccessory() {
                   accessory.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 45)
                   accessory.backgroundColor = UIColor.rgb(red: 36, green: 42, blue: 55)
                   accessory.translatesAutoresizingMaskIntoConstraints = false
                 //  IndexButton.translatesAutoresizingMaskIntoConstraints = false
                 //  IndexButton.translatesAutoresizingMaskIntoConstraints = false
                //   boldsButton.translatesAutoresizingMaskIntoConstraints = false
                   fontSize.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 10, height: 0)
                 //  let stackView = UIStackView(arrangedSubviews: [IndexButton, boldsButton, italicButton,small,fontSize
                 //  ,bigger,doneButton ])
                          
                   
                   let stackView = UIStackView(arrangedSubviews: [IndexButton, boldsButton, italicButton,small,bigger,doneButton ])
                       stackView.translatesAutoresizingMaskIntoConstraints = false
               
                   stackView.distribution = .fillEqually
                       stackView.axis = .horizontal
                       stackView.spacing = 2
                          
                    accessory.addSubview(stackView)
                   
                       stackView.anchor(top: accessory.topAnchor, left: accessory.leftAnchor, bottom: accessory.bottomAnchor, right: accessory.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: accessory.frame.width, height: accessory.frame.height)
                   textoDevocional.inputAccessoryView = accessory
                   
                   /*
                   accessory.addSubview(IndexButton)
                   accessory.addSubview(captialsButton)
                   accessory.addSubview(boldsButton)
                   accessory.addSubview(italicButton)
                   accessory.addSubview(bigger)
                   accessory.addSubview(small)
                   accessory.addSubview(doneButton)
                   NSLayoutConstraint.activate([
                   IndexButton.leadingAnchor.constraint(equalTo:
                   accessory.leadingAnchor, constant: 20),
                   IndexButton.centerYAnchor.constraint(equalTo:
                   accessory.centerYAnchor),
                   captialsButton.centerXAnchor.constraint(equalTo:
                   accessory.centerXAnchor),
                   captialsButton.centerYAnchor.constraint(equalTo:
                   accessory.centerYAnchor),
                   boldsButton.trailingAnchor.constraint(equalTo:
                   accessory.trailingAnchor, constant: -20),
                   boldsButton.centerYAnchor.constraint(equalTo:
                   accessory.centerYAnchor)
                   ])
            */
               }
               
               
               @objc func indexButtonAction () {
                
                
                let arbitraryValue: Int = textoDevocional.selectedRange.location
                      let contentFirstPosition = textoDevocional.contentOffset
                   
                   print("Index Button")
                   print(textoDevocional.selectedRange)
                          
                          //devText.attributedText!
                          
                         // attributedString.append(secondString)
                         // let rango = devText.selectedRange
                         // let prueba = devText.attributedText as! NSMutableAttributedString
                          
                         // prueba.addAttribute(.foregroundColor, value: UIColor.red, range: rango)
                         // devText.attributedText = prueba
                   let creatMutable = NSMutableAttributedString(attributedString: textoDevocional.attributedText)
                          
                   creatMutable.addAttribute(.foregroundColor, value: UIColor.red, range: textoDevocional.selectedRange)
                   textoDevocional.attributedText = creatMutable
                
            //    textoDevocional.textRange(from: textoDevocional, to: <#T##UITextPosition#>)
                if let newPosition = textoDevocional.position(from: textoDevocional.beginningOfDocument, offset: arbitraryValue) {

                           textoDevocional.selectedTextRange = textoDevocional.textRange(from: newPosition, to: newPosition)
                      
                       }
                       
                       textoDevocional.setContentOffset(contentFirstPosition, animated: true)
                   
               }
               
               @objc func capitalButtonAction () {
                   
                   
               }
               
               @objc func boldlButtonAction () {
                
            
                let arbitraryValue: Int = textoDevocional.selectedRange.location
                let contentFirstPosition = textoDevocional.contentOffset
                 
               
                   
                   if textoDevocional.selectedRange.length == 0 {
                       
                       if boldActive {
                           let imagen = UIImage(named: "notbold")
                           self.attributes[NSAttributedString.Key.font] = UIFont(name: "Avenir-Book", size: 12)
                           
                           DispatchQueue.main.async {
                               self.boldsButton.setImage(imagen?.withRenderingMode(.alwaysOriginal), for: .normal)
                           }
                           boldActive = false
                       } else {
                           let imagen = UIImage(named: "boldbutton")
                           self.attributes[NSAttributedString.Key.font] = UIFont(name: "Avenir-Heavy", size: 12)
                                          DispatchQueue.main.async {
                                              self.boldsButton.setImage(imagen?.withRenderingMode(.alwaysOriginal), for: .normal)
                                          }
                           boldActive = true
                       }
                       
                   }
                   
                   let creatMutable = NSMutableAttributedString(attributedString: textoDevocional.attributedText)
                   
                   creatMutable.enumerateAttribute(.font, in: textoDevocional.selectedRange) { value, range, stop in
                       if let font = value as? UIFont {
                         
                     
                           
                           if font.fontDescriptor.symbolicTraits.contains(.traitBold) {
                             
                               print("Es Bold")
                               let imagen = UIImage(named: "notbold")
                              
                                             // cancelButton.setTitleColor(UIColor.red, for: .normal)
                               
                               creatMutable.addAttribute(.font, value: UIFont(name: "Avenir-Book", size: font.pointSize), range: textoDevocional.selectedRange)
                               
                               DispatchQueue.main.async {
                                   self.boldsButton.setImage(imagen?.withRenderingMode(.alwaysOriginal), for: .normal)
                               }
                                
                                
                               // creatMutable.addAttribute(.foregroundColor, value: UIColor.red, range: range)
                           } else {
                               
                                print("NO Es Bold")
                               let imagen = UIImage(named: "boldbutton")
                     
                               creatMutable.addAttribute(.font, value: UIFont(name: "Avenir-Heavy", size: font.pointSize), range: textoDevocional.selectedRange)
                               
                               DispatchQueue.main.async {
                                   self.boldsButton.setImage(imagen?.withRenderingMode(.alwaysOriginal), for: .normal)
                               }
                               
                           }
                           
                           textoDevocional.attributedText = creatMutable
                           
                       }
                   }
                   
                
               
                if let newPosition = textoDevocional.position(from: textoDevocional.beginningOfDocument, offset: arbitraryValue) {

                    textoDevocional.selectedTextRange = textoDevocional.textRange(from: newPosition, to: newPosition)
               
                }
                
                textoDevocional.setContentOffset(contentFirstPosition, animated: true)
                
             
               }
               

               @objc func italicButtonAction () {
                   
                   let arbitraryValue: Int = textoDevocional.selectedRange.location
                         let contentFirstPosition = textoDevocional.contentOffset
                   
                   if textoDevocional.selectedRange.length == 0 {
                       
                       if italicIsActive {
                           let imagen = UIImage(named: "italicButton")
                           self.attributes[NSAttributedString.Key.font] = UIFont(name: "Avenir-Book", size: 12)
                           
                           DispatchQueue.main.async {
                               self.italicButton.setImage(imagen?.withRenderingMode(.alwaysOriginal), for: .normal)
                           }
                           italicIsActive = false
                           
                       } else {
                           let imagen = UIImage(named: "notitalick")
                           self.attributes[NSAttributedString.Key.font] = UIFont(name: "Avenir-BookOblique", size: 12)
                           DispatchQueue.main.async {
                                   self.italicButton.setImage(imagen?.withRenderingMode(.alwaysOriginal), for: .normal)
                                          }
                           italicIsActive = true
                       }
                       
                   }
                   
                   
                   let creatMutable = NSMutableAttributedString(attributedString: textoDevocional.attributedText)
                         
                         creatMutable.enumerateAttribute(.font, in: textoDevocional.selectedRange) { value, range, stop in
                             if let font = value as? UIFont {
                               
                           
                                 
                                 if font.fontDescriptor.symbolicTraits.contains(.traitItalic) {
                                   
                                     print("Es Italic")
                                     let imagen = UIImage(named: "notitalick")
                                    
                                                   // cancelButton.setTitleColor(UIColor.red, for: .normal)
                                     
                                     creatMutable.addAttribute(.font, value: UIFont(name: "Avenir-Book", size: font.pointSize), range: textoDevocional.selectedRange)
                                     
                                     DispatchQueue.main.async {
                                         self.italicButton.setImage(imagen?.withRenderingMode(.alwaysOriginal), for: .normal)
                                     }
                                      
                                      
                                     // creatMutable.addAttribute(.foregroundColor, value: UIColor.red, range: range)
                                 } else {
                                     
                                      print("NO Es Italic")
                                     let imagen = UIImage(named: "italicButton")
                           
                                     creatMutable.addAttribute(.font, value: UIFont(name: "Avenir-BookOblique", size: font.pointSize), range: textoDevocional.selectedRange)
                                     
                                     DispatchQueue.main.async {
                                         self.italicButton.setImage(imagen?.withRenderingMode(.alwaysOriginal), for: .normal)
                                     }
                                     
                                 }
                                 
                                 textoDevocional.attributedText = creatMutable
                                 
                             }
                         }
                         
                if let newPosition = textoDevocional.position(from: textoDevocional.beginningOfDocument, offset: arbitraryValue) {

                           textoDevocional.selectedTextRange = textoDevocional.textRange(from: newPosition, to: newPosition)
                      
                       }
                       
                       textoDevocional.setContentOffset(contentFirstPosition, animated: true)
                      
                         
                   
               }
               
               @objc func biggerButtonAction () {
                
                let arbitraryValue: Int = textoDevocional.selectedRange.location
                      let contentFirstPosition = textoDevocional.contentOffset
                   
                   let creatMutable = NSMutableAttributedString(attributedString: textoDevocional.attributedText)
                         
                         creatMutable.enumerateAttribute(.font, in: textoDevocional.selectedRange) { value, range, stop in
                           
                           if let font = value as? UIFont {
                               
                               let name = font.fontName
                               creatMutable.addAttribute(.font, value: UIFont(name: name, size: font.pointSize + 2), range: textoDevocional.selectedRange)
                                     
                           }
                           
                           }
                                 
                       textoDevocional.attributedText = creatMutable
                
                
                if let newPosition = textoDevocional.position(from: textoDevocional.beginningOfDocument, offset: arbitraryValue) {

                           textoDevocional.selectedTextRange = textoDevocional.textRange(from: newPosition, to: newPosition)
                      
                       }
                       
                       textoDevocional.setContentOffset(contentFirstPosition, animated: true)
                                 
                             
                   
               }
               
               @objc func smallButtonAction () {
                
                
                let arbitraryValue: Int = textoDevocional.selectedRange.location
                      let contentFirstPosition = textoDevocional.contentOffset
                   
                   let creatMutable = NSMutableAttributedString(attributedString: textoDevocional.attributedText)
                            
                            creatMutable.enumerateAttribute(.font, in: textoDevocional.selectedRange) { value, range, stop in
                              
                              if let font = value as? UIFont {
                                 let name = font.fontName
                                  creatMutable.addAttribute(.font, value: UIFont(name: name, size: font.pointSize - 2), range: textoDevocional.selectedRange)
                                        
                              }
                              
                              }
                                    
                          textoDevocional.attributedText = creatMutable
                
                
                if let newPosition = textoDevocional.position(from: textoDevocional.beginningOfDocument, offset: arbitraryValue) {

                           textoDevocional.selectedTextRange = textoDevocional.textRange(from: newPosition, to: newPosition)
                      
                       }
                       
                       textoDevocional.setContentOffset(contentFirstPosition, animated: true)
                                    
                   
               }
               
               @objc func doneButtonAction () {
                   
                    let creatMutable = NSMutableAttributedString(attributedString: textoDevocional.attributedText)
                           
                       //    creatMutable.addAttribute(.foregroundColor, value: UIColor.red, range: devText.selectedRange)
                    textoDevocional.attributedText = creatMutable
                    textoDevocional.endEditing(true)
                   
               }
            
            
            
        }




        extension EventoSeleccionado: UITextViewDelegate {
            
            func textViewDidBeginEditing(_ textView: UITextView) {
              //  scroll.setContentOffset(CGPoint(x: 0, y: (textView.superview?.frame.origin.y)!), animated: true)
            
                if textView.text == "Add your devotional here..." {
                    let attributes = [
                               
                             //  NSAttributedString.Key.underlineStyle : 1,
                               NSAttributedString.Key.foregroundColor : UIColor.black
                             //  NSAttributedString.Key.font: UIFont.systemFontSize
                             //  NSAttributedString.Key.strokeWidth : 3.0
                                  
                               ] as [NSAttributedString.Key : Any]
                           
                           if devocionalRichText.isEmpty {
                            
                            
                           // attributedString.addAttribute(.link, value: "https://www.hackingwithswift.com", range: NSRange(location: 19, length: 55))
                            let secondString = NSAttributedString(string: "", attributes: attributes)
                            attributedString.append(secondString)

                           textoDevocional.attributedText = attributedString
                           
                        //   devText.attributedText = NSAttributedString(string: "", attributes: attributes)
                            
                           
                          
                           }
                    
                }

                       
               // devText.t
                

                
                
            }
            
            func textViewDidEndEditing(_ textView: UITextView) {
                
                /*
                if textView.selectedRange.length == 0 {
                    
                    let creatMutable = NSMutableAttributedString(attributedString: devText.attributedText)
                   
                    creatMutable.setAttributes(attributes, range: textView.selectedRange)
                    
                    devText.attributedText = creatMutable
                } else {
                    
                    let creatMutable = NSMutableAttributedString(attributedString: devText.attributedText)
                    devText.attributedText = creatMutable
                }
         */
                
                 
                
               let creatMutable = NSMutableAttributedString(attributedString: textoDevocional.attributedText)
              //  secondString.att
          
               textoDevocional.attributedText = creatMutable
              // scroll.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            }
            
            func textViewDidChange(_ textView: UITextView) { //Handle the text changes here
               
                
                print(textoDevocional.selectedRange)
                
                textoDevocional.scrollRangeToVisible(textoDevocional.selectedRange)
                
                
                 textoDevocional.typingAttributes = self.attributes
         
                
            let creatMutable = NSMutableAttributedString(attributedString: textoDevocional.attributedText)

            textoDevocional.attributedText = creatMutable
              
                
            }
            
            
            func textViewDidChangeSelection(_ textView: UITextView) {
                
               
                
                
                let creatMutable2 = NSMutableAttributedString(attributedString: textView.attributedText)
                
                creatMutable2.enumerateAttribute(.font, in: textView.selectedRange) { value, range, stop in
                    if let font = value as? UIFont {
                      
                  
                        
                        if font.fontDescriptor.symbolicTraits.contains(.traitBold) {
                          
                          
                             
                             
                            print("NO Es Bold")
                                         let imagen = UIImage(named: "boldbutton")
                                       
                                         DispatchQueue.main.async {
                                             self.boldsButton.setImage(imagen?.withRenderingMode(.alwaysOriginal), for: .normal)
                                         }
                                         
                            
                            // creatMutable.addAttribute(.foregroundColor, value: UIColor.red, range: range)
                        } else {
                            
                      print("Es Bold")
                                        let imagen = UIImage(named: "notbold")

                                        DispatchQueue.main.async {
                                            self.boldsButton.setImage(imagen?.withRenderingMode(.alwaysOriginal), for: .normal)
                                        }
                        }
                        
                        
                        if font.fontDescriptor.symbolicTraits.contains(.traitItalic) {
                                  
                                   
                                     
                                     
                                                                 print("NO Es Bold")
                                                                let imagen = UIImage(named: "italicButton")
                                                              
                                                                DispatchQueue.main.async {
                                                                    self.italicButton.setImage(imagen?.withRenderingMode(.alwaysOriginal), for: .normal)
                                                                }
                                    // creatMutable.addAttribute(.foregroundColor, value: UIColor.red, range: range)
                                } else {
                                   
                                    print("Es Bold")
                                                               let imagen = UIImage(named: "notitalick")

                                                               DispatchQueue.main.async {
                                                                   self.italicButton.setImage(imagen?.withRenderingMode(.alwaysOriginal), for: .normal)
                                                               }
                                }
                
                
                    }
                }
                
            }

            
            
        }


        extension EventoSeleccionado: UITextFieldDelegate {
            
            func textFieldDidBeginEditing(_ textField: UITextField) {
                
                if textField.text == "Change title here ..." {
                textField.text = ""
                }
            }
            
        }
