//
//  CreateEventViewController.swift
//  altar
//
//  Created by Juan Moreno on 2/17/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//

import UIKit
import Firebase

class CreateEventViewController: UIViewController {
    
    @objc internal func didChangePic() {
        
        print("Llego protocolo")
        if advengers.shared.fondoSeleccionado != "" {
            
            
            DispatchQueue.main.async {
                self.fondovisual.loadImage(urlString: advengers.shared.fondoSeleccionado)
            }
            
            
        }
        
        
    }
    
    
    //@IBOutlet weak var devText: UITextView!
    var devText = UITextView ()
    
    var attributedString = NSMutableAttributedString(string: "")
    
    struct devocionalFormato {
        
        var texto: String!
        var atributos: [NSAttributedString.Key:Any]
        
    }
    
    var devocionalFondo = ["type": "",
                           "index" : 0,
                           "url": ""
        ] as [String : Any]
    
    @IBOutlet var fondovisual: CustomImageView!
    
    //    struct devocionalFondo {
    //        var type = "altar"
    //        var index = ""
    //        var url = "https://firebasestorage.googleapis.com/v0/b/altar-92d12.appspot.com/o/backgroundsDevSR%2F7A54A739-2252-404D-9960-B6DD8B6FB88D?alt=media&token=2dad600e-54a1-483b-9c57-b3f203c29b8f"
    //    }
    
    
    var devocionalRichText = [NSAttributedString] ()
    var decocionalToSave = [devocionalFormato] ()
    
    @IBOutlet weak var scroll: UIScrollView!
    
    @IBOutlet var titulo: UITextView!
    var tamanodefault = CGFloat()

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
        devText.inputAccessoryView = accessory
        
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
        
        print("Index Button")
        print(devText.selectedRange)
        
        //devText.attributedText!
        
        // attributedString.append(secondString)
        // let rango = devText.selectedRange
        // let prueba = devText.attributedText as! NSMutableAttributedString
        
        // prueba.addAttribute(.foregroundColor, value: UIColor.red, range: rango)
        // devText.attributedText = prueba
        let creatMutable = NSMutableAttributedString(attributedString: devText.attributedText)
        
        creatMutable.addAttribute(.foregroundColor, value: UIColor.red, range: devText.selectedRange)
        devText.attributedText = creatMutable
        
    }
    
    @objc func capitalButtonAction () {
        
        
    }
    
    @objc func boldlButtonAction () {
        
        if devText.selectedRange.length == 0 {
            
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
        
        let creatMutable = NSMutableAttributedString(attributedString: devText.attributedText)
        
        creatMutable.enumerateAttribute(.font, in: devText.selectedRange) { value, range, stop in
            if let font = value as? UIFont {
                
                
                
                if font.fontDescriptor.symbolicTraits.contains(.traitBold) {
                    
                    print("Es Bold")
                    let imagen = UIImage(named: "notbold")
                    
                    // cancelButton.setTitleColor(UIColor.red, for: .normal)
                    
                    creatMutable.addAttribute(.font, value: UIFont(name: "Avenir-Book", size: font.pointSize), range: devText.selectedRange)
                    
                    DispatchQueue.main.async {
                        self.boldsButton.setImage(imagen?.withRenderingMode(.alwaysOriginal), for: .normal)
                    }
                    
                    
                    // creatMutable.addAttribute(.foregroundColor, value: UIColor.red, range: range)
                } else {
                    
                    print("NO Es Bold")
                    let imagen = UIImage(named: "boldbutton")
                    
                    creatMutable.addAttribute(.font, value: UIFont(name: "Avenir-Heavy", size: font.pointSize), range: devText.selectedRange)
                    
                    DispatchQueue.main.async {
                        self.boldsButton.setImage(imagen?.withRenderingMode(.alwaysOriginal), for: .normal)
                    }
                    
                }
                
                devText.attributedText = creatMutable
                
            }
        }
        
        
        
    }
    
    
    @objc func italicButtonAction () {
        
        
        
        if devText.selectedRange.length == 0 {
            
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
        
        
        let creatMutable = NSMutableAttributedString(attributedString: devText.attributedText)
        
        creatMutable.enumerateAttribute(.font, in: devText.selectedRange) { value, range, stop in
            if let font = value as? UIFont {
                
                
                
                if font.fontDescriptor.symbolicTraits.contains(.traitItalic) {
                    
                    print("Es Italic")
                    let imagen = UIImage(named: "notitalick")
                    
                    // cancelButton.setTitleColor(UIColor.red, for: .normal)
                    
                    creatMutable.addAttribute(.font, value: UIFont(name: "Avenir-Book", size: font.pointSize), range: devText.selectedRange)
                    
                    DispatchQueue.main.async {
                        self.italicButton.setImage(imagen?.withRenderingMode(.alwaysOriginal), for: .normal)
                    }
                    
                    
                    // creatMutable.addAttribute(.foregroundColor, value: UIColor.red, range: range)
                } else {
                    
                    print("NO Es Italic")
                    let imagen = UIImage(named: "italicButton")
                    
                    creatMutable.addAttribute(.font, value: UIFont(name: "Avenir-BookOblique", size: font.pointSize), range: devText.selectedRange)
                    
                    DispatchQueue.main.async {
                        self.italicButton.setImage(imagen?.withRenderingMode(.alwaysOriginal), for: .normal)
                    }
                    
                }
                
                devText.attributedText = creatMutable
                
            }
        }
        
        
        
        
    }
    
    @objc func biggerButtonAction () {
        
        let creatMutable = NSMutableAttributedString(attributedString: devText.attributedText)
        
        creatMutable.enumerateAttribute(.font, in: devText.selectedRange) { value, range, stop in
            
            if let font = value as? UIFont {
                
                let name = font.fontName
                creatMutable.addAttribute(.font, value: UIFont(name: name, size: font.pointSize + 2), range: devText.selectedRange)
                
            }
            
        }
        
        devText.attributedText = creatMutable
        
        
        
    }
    
    @objc func smallButtonAction () {
        
        let creatMutable = NSMutableAttributedString(attributedString: devText.attributedText)
        
        creatMutable.enumerateAttribute(.font, in: devText.selectedRange) { value, range, stop in
            
            if let font = value as? UIFont {
                let name = font.fontName
                creatMutable.addAttribute(.font, value: UIFont(name: name, size: font.pointSize - 2), range: devText.selectedRange)
                
            }
            
        }
        
        devText.attributedText = creatMutable
        
        
    }
    
    @objc func doneButtonAction () {
        
        let creatMutable = NSMutableAttributedString(attributedString: devText.attributedText)
        
        //    creatMutable.addAttribute(.foregroundColor, value: UIColor.red, range: devText.selectedRange)
        devText.attributedText = creatMutable
        devText.endEditing(true)
        
    }
    
    //  var loqueviene: SeleccionFotoCollectionViewController?
    
    let model = SeleccionFotoCollectionViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        devText.tag = 200
        
        // NAVIGATION SETTINGS
        
        NotificationCenter.default.addObserver(self, selector: #selector(didChangePic), name: NSNotification.Name("changePic"), object: nil)
        
        
        //  model.delegate = self
        
        //  model.didChange(<#NSKeyValueChange#>)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Post", style: .plain, target: self, action: #selector(postEvent))
        navigationItem.leftBarButtonItem?.title = "Back"
        
        
        let attributostitulo = [
            
            //  NSAttributedString.Key.underlineStyle : 1,
            NSAttributedString.Key.foregroundColor : advengers.shared.colorOrange,
            NSAttributedString.Key.font: UIFont(name: "Avenir", size: 15)
            //  NSAttributedString.Key.strokeWidth : 3.0
            
            ] as [NSAttributedString.Key : Any]
        // let font = UIFont(name: "Avenir", size: 15)
        navigationItem.rightBarButtonItem?.setTitleTextAttributes(attributostitulo, for: .normal)
        
        navigationItem.rightBarButtonItem?.tintColor = advengers.shared.colorOrange
        
        //
        //        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.bordered, target: self, action: "back:")
        //        self.navigationItem.leftBarButtonItem = newBackButton
        // VIEW SETTINGS
        /*
         for counter in 1...10
         {
         postBackgrounds (contador: counter)
         }
         */
        
        
        
        devText.delegate = self
        
        titulo.delegate = self
        
        addAccessory()
        
        if devocionalRichText.isEmpty {
            
            devText.attributedText = NSAttributedString(string: "Add your event here..", attributes: attributes)
            
        }
        //  devText.selectedRange

           tamanodefault = view.frame.height - fondovisual.frame.height - 200
           devText.frame = CGRect(x: 0, y: 0, width: view.frame.width - 16 , height: view.frame.height - fondovisual.frame.height - 200)
      //   devText.backgroundColor = .red
           
           view.addSubview(devText)
            devText.translatesAutoresizingMaskIntoConstraints = false
           
        
                  [
                      devText.topAnchor.constraint(equalTo: fondovisual.bottomAnchor, constant: 20),
                      devText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
                      devText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
                      devText.heightAnchor.constraint(equalToConstant: tamanodefault)
                      ].forEach{ $0.isActive = true }
                  

        
        
                    let notificationCenter = NotificationCenter.default
                      notificationCenter.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
                      notificationCenter.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
                  // And that's it!
               }

          @objc func keyboardWillShow(notification: NSNotification) {
                   devText.constraints.forEach { (constraint) in
                            if constraint.firstAttribute == .height {
                                constraint.constant = tamanodefault - getKeyboardHeight(notification: notification) + 140
                            }
                        }

             }
             
             @objc func keyboardWillHide(notification: NSNotification) {
                
              devText.constraints.forEach { (constraint) in
                  
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
    
    
    @IBAction func seleccionFoto(_ sender: Any) {
        
        //     let sellectFoto = SeleccionFotoCollectionViewController(collectionViewLayout: UICollectionViewLayout())
        
        //  present(sellectFoto, animated: true, completion: nil)
        
        let newViewController = SeleccionFotoCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        self.navigationController?.pushViewController(newViewController, animated: true)
        // performSegue(withIdentifier: "seleccionFoto", sender: self)
    }
    
    
    @objc func nextButton()
    {
        print("Index")
        print(devText.selectedRange)
        
        //devText.attributedText!
        
        // attributedString.append(secondString)
        // let rango = devText.selectedRange
        // let prueba = devText.attributedText as! NSMutableAttributedString
        
        // prueba.addAttribute(.foregroundColor, value: UIColor.red, range: rango)
        // devText.attributedText = prueba
        let creatMutable = NSMutableAttributedString(attributedString: devText.attributedText)
        
        creatMutable.addAttribute(.foregroundColor, value: UIColor.red, range: devText.selectedRange)
        devText.attributedText = creatMutable
        
    }
    @IBAction func bold(_ sender: Any) {
        print(devText.selectedRange)
        
        
        attributedString.addAttribute(.foregroundColor, value: UIColor.red, range: devText.selectedRange)
        devText.attributedText = attributedString
        
    }
    
    @objc func postEvent () {
        
        // let iglesia = advengers.shared.currentChurch
        guard let currentChurchID = advengers.shared.currenUSer["churchID"] as? String else { return }
        let userPostRef = Database.database().reference().child("Events").child(currentChurchID)
        
        let filenameA = NSUUID().uuidString
        let ref = userPostRef.child(filenameA)
        
        var fondo = ""
        if advengers.shared.fondoSeleccionado == "" {
            fondo = "https://firebasestorage.googleapis.com/v0/b/altar-92d12.appspot.com/o/backgroundsDevSR%2F-M-qdkcToEv4HU051_Iq?alt=media&token=c81ad0f4-ee3b-459c-89f2-7b5be3f7c7b6"
        } else {
            fondo = advengers.shared.fondoSeleccionado
        }
        
        
        let attrString = devText.attributedText
        guard let x = attrString else {return}
        var resultHtmlText = ""
        do {
            
            let r = NSRange(location: 0, length: x.length)
            let att = [NSAttributedString.DocumentAttributeKey.documentType: NSAttributedString.DocumentType.html]
            let d = try x.data(from: r, documentAttributes: att)
            
            if let h = String(data: d, encoding: .utf8) {
                resultHtmlText = h
                
                // ------------------------------------ ACA SALVAMOS AL STORAGE LA DATA  ---------------------------------
               
                let storageRefDB = Storage.storage().reference().child("Events").child(currentChurchID).child(filenameA)
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
                        
                        let devo = ["urltexto": htmlfileURL,
                                    "church" : currentChurchID,
                                    "author": Auth.auth().currentUser?.uid,
                                    "message": self.devText.text ,
                                    "photoURL": fondo ,
                                    "postID": filenameA,
                                    
                                    "title": self.titulo.text!,
                                    "creationDate": Date().millisecondsSince1970] as [String : Any]
                        
                        ref.updateChildValues(devo) { (err, ref) in
                            if let err = err {
                                //self.navigationItem.rightBarButtonItem?.isEnabled = true
                                print("Failed to save post to DB", err)
                                return
                            }
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadEvent"), object: nil)
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
        
        NotificationCenter.default.post(name: NSNotification.Name("reloaddata"), object: nil)
        
        _ = navigationController?.popViewController(animated: true)
        
        
        print("editing")
    }
    
    
    func postBackgrounds (contador: Int) {
        
        
        let key = advengers.shared.postPrayFeed.childByAutoId().key
        
        //let imageRef = advengers.shared.PostPrayStorage.child(uid!).child("\(key!).jpg")
        
        let iglesia = advengers.shared.currentChurch
        let userPostRef = Database.database().reference().child("backgroundsDev")
        let ref = userPostRef
        //  let filename = NSUUID().uuidString
        let storageRefDB = Storage.storage().reference().child("backgroundsDevSR").child(key!)
        
        
        
        
        
        
        guard let imagensincompresion = UIImage(named: "devoback" + String(contador)) else {return}
        
        guard let imagen = imagensincompresion.jpegData(compressionQuality: 0.5) else { return }
        
        
        storageRefDB.putData(imagen, metadata: nil, completion: { (metadata, err) in
            
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
                
                
                
                self.devocionalFondo["index"] = "devoback" + String(contador)
                self.devocionalFondo["type"] = "altar"
                self.devocionalFondo["url"] = backgroundURL
                
                ref.childByAutoId().updateChildValues(self.devocionalFondo) { (err, ref) in
                    if let err = err {
                        //self.navigationItem.rightBarButtonItem?.isEnabled = true
                        print("Failed to save post to DB", err)
                        return
                    }
                    
                    print("Successfully saved post to DB")
                    
                }
                
                
            })
        })
        
        
        
        
    }
    
    
    
    
    
}




extension CreateEventViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        //  scroll.setContentOffset(CGPoint(x: 0, y: (textView.superview?.frame.origin.y)!), animated: true)
        print(textView.tag)
        if textView.tag == 200 {
            print(textView.attributedText.string)
            if textView.attributedText.string == "Add your event here.." {
                print ("Llego a add your event")
                devText.text = ""
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
                    
                    devText.attributedText = attributedString
                    
                    //   devText.attributedText = NSAttributedString(string: "", attributes: attributes)
                    
                    
                    
                }
            }
            
            
        }
        
        
        if textView.tag == 100 {
            print(textView.attributedText.string)
            print(textView.text)
        
            if textView.text == "Change title here ..." {
                
                let secondString = NSAttributedString(string: "")
                titulo.attributedText = secondString
                titulo.text = ""
                
            }
            
        
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
        
        if textView.tag == 200 {
            
            let creatMutable = NSMutableAttributedString(attributedString: devText.attributedText)
            //  secondString.att
            
            devText.attributedText = creatMutable
            
        }
        
        if textView.tag == 100 {
            
            let creatMutable = NSMutableAttributedString(attributedString: titulo.attributedText)
            //  secondString.att
            
            titulo.attributedText = creatMutable
            
        }
        // scroll.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    func textViewDidChange(_ textView: UITextView) { //Handle the text changes here
        
        if textView.tag == 200 {
            
            devText.typingAttributes = self.attributes
            
            
            let creatMutable = NSMutableAttributedString(attributedString: devText.attributedText)
            
            devText.attributedText = creatMutable
            
        } else {
            
                textView.centerVertically()
        }
        
    }
    
  // Use this if you have a UITextView
 
        
    func textViewDidChangeSelection(_ textView: UITextView) {
        
        
        if textView.tag == 200 {
            
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
    
}

}
//extension CreateEventViewController: UITextFieldDelegate {
//
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//
//        if textField.text == "Change title here ..." {
//            textField.text = ""
//        }
//    }
    
//}
/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */

