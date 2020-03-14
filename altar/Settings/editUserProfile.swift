//
//  editUserProfile.swift
//  altar
//
//  Created by Juan Moreno on 3/3/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//

//
//  SignUpViewController.swift
//  altar
//
//  Created by Juan Moreno on 9/8/19.
//  Copyright © 2019 Juan Moreno. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI
import FirebaseMessaging







class EditUserViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
   // @IBOutlet var seleecionFoto: UIButton!
    @IBOutlet weak var churchChose: UIPickerView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordvalidator: UITextField!
    @IBOutlet weak var signInBtt: UIButton!
    var picker = UIImagePickerController ()
    let storageReference = Storage.storage().reference(forURL: "gs://altar-92d12.appspot.com" ).child("users")
    var ref: DatabaseReference!
    
    @IBOutlet var backgroudnOldPass: UIView!
    @IBOutlet var profileImage: CustomImageView!
    @IBOutlet var errorLabel: UILabel!
    
    let databaseReference = Database.database().reference()
    
    var selectedChurch = "Favorday Church"
    var churchList = ["Favorday Church","River Church","Rey de Reyes","Not listed"]
    
    @IBOutlet var oldPassword: UITextField!
    @IBOutlet weak var mainScrollViewBottomConstraint: NSLayoutConstraint!
  
    @IBOutlet var textviewBackground: UIView!
    @IBOutlet var textbackbroundpassword: UIView!
    @IBOutlet var textEmail: UIView!
    @IBOutlet var textbackgroundPassValidator: UIView!
    @IBOutlet var selectUChurch: UIView!
    @IBOutlet var selectChurchButton: UIButton!
    // let userStorage =
    @IBOutlet var textviewemail: UIView!
    
    @IBOutlet var update: UIButton!
    var imageToSave: UIImage?
    
    var nuevaImagen = false
    
    let scrollview = UIScrollView()
    
    let accounthelper = AccountHelpers ()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
            profileImage.layer.cornerRadius = profileImage.frame.width/2
            profileImage.layer.masksToBounds = true
            profileImage.layer.borderColor = UIColor.white.cgColor
            profileImage.layer.borderWidth = 1
        
        
//        let altarChurch = ["uidChurch": "C18CF123-6F7A-406D-B62D-5F780CFEFFA8",
//] as? [String:Any]
//
//
//        let churchDefautl = Church(dictionary: altarChurch!)
//        advengers.shared.currentChurchInfo = churchDefautl
        
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(churchSelection), name: NSNotification.Name(rawValue: "ChurchSelection"), object: nil)
        
        navigationController?.navigationBar.isHidden = true

        update.backgroundColor = UIColor.rgb(red: 247, green: 131, blue: 97)
        update.layer.cornerRadius = 22
        update.layer.masksToBounds = true
        update.setTitleColor(.white , for: .normal)
        update.setTitle("Update", for: .normal)
        update.setTitleColor(UIColor.white.withAlphaComponent(0.3), for: .highlighted )
        update.applyGradient(colors: [WelcomeViewController.UIColorFromRGB(0xF78361).cgColor,WelcomeViewController.UIColorFromRGB(0xF54B64).cgColor])
    textviewBackground.layer.cornerRadius = 22
    textviewemail.layer.cornerRadius = 22
textbackbroundpassword.layer.cornerRadius = 22
        
        textEmail.layer.cornerRadius = 22
      textbackgroundPassValidator.layer.cornerRadius = 22
        
        selectUChurch.layer.cornerRadius = 22
        backgroudnOldPass.layer.cornerRadius  = 22
        
        
            //Border
        name.layer.cornerRadius = 22
    //    name.layer.borderWidth = 1.5
      //  name.layer.borderColor = .white

        //Background
        name.backgroundColor = UIColor.clear

        //Text
        name.textColor = .white
      //  name.textAlignment = NSTextAlignment.center
        
        
        
    //    let notificationCenter = NotificationCenter.default
  //      notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)

   //     notificationCenter.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

   //     image.image = UIImage.init(named: "default")
        
        picker.delegate = self
        name?.delegate = self
        email.delegate = self
        password.delegate = self
        passwordvalidator.delegate = self
        
        
        
        
        
        
        accounthelper.loadCurrentUserInfo( completionHandler: { (success) -> Void in
            
            var userProfileImageView = CustomImageView ()
            if success {
                
                let currentChurchID = advengers.shared.currenUSer["churchID"] as! String
                
                self.accounthelper.loadCurrentChurch(codigo: currentChurchID) { (true) in
                    
                    
                    self.name.text = advengers.shared.currenUSer["name"] as? String
                    self.email.text = advengers.shared.currenUSer["email"] as? String
                    // self.selectChurchButton.titleLabel?.textAlignment = .center
                    self.selectChurchButton.setTitle(advengers.shared.currenUSer["church"] as? String, for: .normal)
                    //   self.selectChurchButton.titleLabel?.text = advengers.shared.currenUSer["church"] as? String
                    // self.selectChurchButton.titleLabel?.textAlignment = .center
                    guard let profileuserURL = advengers.shared.currenUSer["photoURL"] else {return}
                    
                    
                    
                    DispatchQueue.main.async {
                        
                        self.profileImage.loadImage(urlString: profileuserURL as! String)
                        
                        
                        self.view.reloadInputViews()
                    }
                    
                    
                    
                    
                }
                
                
                
            }
            
        })
        
       
        
        
 //       churchChose.dataSource = self
  //      churchChose.delegate = self
        
//    \\ TRYNG TO WORK WITH THE Keboard
         
        
        
        scrollview.addSubview(view)
        
        
     let notificationCenter = NotificationCenter.default
               notificationCenter.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
               notificationCenter.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
           // And that's it!
        }

   @objc func keyboardWillShow(notification: NSNotification) {
          if view.frame.origin.y >= 0 {
              view.frame.origin.y -= (getKeyboardHeight(notification: notification) - 100)
              print("Se va a mostrar")
          }
      }
      
      @objc func keyboardWillHide(notification: NSNotification) {
          if (self.view.frame.origin.y < 0) {
            //  view.frame.origin.y += getKeyboardHeight(notification: notification)
            view.frame.origin.y = 0
              view.reloadInputViews()
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
    
    
    @objc func churchSelection() {
        DispatchQueue.main.async {
            self.selectChurchButton.setTitle(advengers.shared.currentChurch, for: .normal)
            print(advengers.shared.currentChurch)
        }
        
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {

        textField.text = ""
       
        if textField.tag == 200 {
            textField.text = ""
            textField.isSecureTextEntry = true
        }
        
        if textField.tag == 201 {
            textField.text = ""
            textField.isSecureTextEntry = true
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func goBack(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func selectChurch(_ sender: Any) {
        
//        let churchSel = ChurchSelectionViewController ()
//        navigationController?.pushViewController(churchSel, animated: true)
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
               let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ChurchSelection") as! ChurchSelectionViewController
              // nextViewController.referalDetailsFromDB()
               self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    /*
    @objc func adjustForKeyboard (_ notification: Notification) {
       let userInfo = (notification as NSNotification).userInfo!
    let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
       mainScrollViewBottomConstraint.constant = keyboardSize.height
   }

    @objc func keyboardWillHide(_ notification: Notification) {
       mainScrollViewBottomConstraint.constant = 0
   }
 */
    @IBAction func signIn(_ sender: Any) {
        
  
        guard let user = Auth.auth().currentUser else { return }
        

        if password.text != "Password" && passwordvalidator.text != "Password validation" && password.text == passwordvalidator.text{
                   
                   Auth.auth().currentUser?.updatePassword(to: password.text!, completion: nil)
                   errorLabel.text = "Password updated"
               }
       
        
        guard name?.text != "", email.text != "" else {
            errorLabel.text = "You need your email & password to access Altar."
            return}
        
        if name.text != Auth.auth().currentUser?.displayName
        {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                      changeRequest?.displayName = self.name?.text
              
                      changeRequest?.commitChanges(completion: { (no) in
                          
                      })
        }
    
     
        if nuevaImagen {
                     
        let imageref = self.storageReference.child("picture").child("\(user.uid)")
        let data = self.imageToSave?.jpegData(compressionQuality: 0.5) ?? UIImage(named: "Rectangle")!.jpegData(compressionQuality: 0.5)
        
        let uploadTask = imageref.putData(data!, metadata: nil, completion: { (metadata, error) in
                    
                imageref.downloadURL(completion: { (url, error) in

                        let modoString = String (url!.absoluteString)
                        self.ref = self.databaseReference
        
         
                    let userinfo: [String:Any] = ["userid" : (user.uid), "name" : self.name?.text!, "email" : self.email.text!, "church": advengers.shared.currentChurch, "photoURL" : modoString ?? "","churchID": advengers.shared.currentChurchInfo.uidChurch]
                    
                     
                        //   self.databaseReference.child("users").child("\(user!.user.uid)").setValue(user?.user.uid, forKeyPath: "userid")
                       Database.database().reference().child("users").child(user.uid).updateChildValues(userinfo)
                        
                       
                   
                    
                    })

                    })

                uploadTask.resume()
                // self.performSegue(withIdentifier: "accesoOK", sender: self)
                  self.navigationController?.popToRootViewController(animated: true)
   
        } else {
            
            
          let userinfo: [String:Any] = ["userid" : (user.uid), "name" : self.name?.text!, "email" : self.email.text!, "church": advengers.shared.currentChurch ?? "","churchID": advengers.shared.currentChurchInfo.uidChurch ?? ""]
   
            Database.database().reference().child("users").child(user.uid).updateChildValues(userinfo)
          //   self.ref.child("users").child(userID).updateChildValues(userinfo)
            
            self.navigationController?.popToRootViewController(animated: true)

        }
        
         let accounthelper = AccountHelpers ()
         accounthelper.fetchUserInfo()
               
            }
            
           
  

    
    @IBAction func changePicture(_ sender: Any) {
        
        picker.allowsEditing = true
 
        picker.sourceType = .photoLibrary
        
        present(picker, animated: true, completion: nil)
        
    }
    

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        
        print("seactivo")
        guard let selectedImage = info[.editedImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        
      //  seleecionFoto.setImage(selectedImage, for: .normal )
        profileImage.image = selectedImage
        profileImage.layer.cornerRadius = profileImage.frame.width/2
            profileImage.layer.masksToBounds = true
            profileImage.layer.borderColor = UIColor.white.cgColor
            profileImage.layer.borderWidth = 1
        
        
//     seleecionFoto.setImage(selectedImage, for: .normal )
//       seleecionFoto.layer.cornerRadius = seleecionFoto.frame.width/2
//           seleecionFoto.layer.masksToBounds = true
//           seleecionFoto.layer.borderColor = UIColor.white.cgColor
//           seleecionFoto.layer.borderWidth = 1
//
        imageToSave = profileImage.image
        nuevaImagen = true
     //   image.image = selectedImage
     self.dismiss(animated: true, completion: nil)
        
    }

    @IBAction func change(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                     let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Subscribe") as! SubscribeViewController
                    // nextViewController.referalDetailsFromDB()
                     self.navigationController?.pushViewController(nextViewController, animated: true)
        
        
        advengers.shared.updateToPastor = true
        
    }
    
    
}




//extension SignUpViewController: UIPickerViewDataSource,UIPickerViewDelegate {
//
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//
//            return churchList.count
//
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//
//        if row < churchList.count {
//        return churchList[row]
//        }
//        return ""
//
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//
//       selectedChurch = churchList[row]
//    }
//
//}
