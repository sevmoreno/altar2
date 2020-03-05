//
//  ViewController.swift
//  altar
//
//  Created by Juan Moreno on 9/8/19.
//  Copyright © 2019 Juan Moreno. All rights reserved.
//
import UIKit
import Firebase




class logInViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet var errorMensajes: UILabel!
    
    @IBOutlet var viewGeneral: UIView!
    @IBOutlet weak var emailLogin: UITextField!
    @IBOutlet weak var passwordLogin: UITextField! 
    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet var forgott: UIButton!
    
    @IBOutlet var backButton: UIButton? {
        
        didSet {
            
            
            backButton?.setImage(UIImage(named: "Close"), for: .normal)
            backButton?.addTarget(self, action: #selector (backBT), for: .touchUpInside)
            
            //  a.backgroundColor = UIColor.rgb(red: 247, green: 131, blue: 97)
            //   a.layer.cornerRadius = 22
            //   a.layer.masksToBounds = true
            //  a.setTitleColor(.white , for: .normal)
            //   a.setTitle("Log in", for: .normal)
            //  a.setTitleColor(UIColor.white.withAlphaComponent(0.3), for: .highlighted )
        }
    }
    
    @IBOutlet var SignUpButton: UIButton? = {
        
        
        let a = UIButton ()
        
        a.backgroundColor = UIColor.rgb(red: 247, green: 131, blue: 97)
        a.layer.cornerRadius = 22
        a.layer.masksToBounds = true
        a.setTitleColor(.white , for: .normal)
        a.setTitle("Log in", for: .normal)
        a.setTitleColor(UIColor.white.withAlphaComponent(0.3), for: .highlighted )
        return a
    }()
    
    //  @IBOutlet weak var findNewFriendsNeaLabel: UILabel!
    @IBOutlet weak var welcomeBackLabel: UILabel!
    @IBOutlet weak var loginToYourAccounLabel: UILabel!
    private var gradient: CAGradientLayer!
    
    let background: UIImageView = {
        
        let imagen = UIImageView ()
        
        imagen.image = UIImage(named: "background_Login")
        imagen.contentMode = .scaleAspectFit
        
        return imagen
    }()
    
    @objc func backBT () {
        print("A ver")
        _ = navigationController?.popViewController(animated: true)
    }
    
    let accounthelper = AccountHelpers ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailLogin.delegate = self
        passwordLogin.delegate = self
        navigationController?.navigationBar.isHidden = true
        //  navigationItem.leftBarButtonItem = UIBarButtonItem(title: "<-", style: .plain, target: self, action: #selector(backbutton))
        // viewGeneral.addSubview(background)
        //   viewGeneral.sendSubviewToBack(background)
        
        //    background.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width + 10, height: view.frame.width + 10)
        
        //     background.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        //    background.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
        setupViews()
        
        //  emailLogin.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 100, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        
        Auth.auth().addStateDidChangeListener() { auth, user in
            // 2
            if user != nil {
                
                
                self.accounthelper.loadCurrentUserInfo(completionHandler: { (success) -> Void in
                    
                    if success {
                        
                        self.performSegue(withIdentifier: "accesoOK", sender: nil)
                        self.emailLogin.text = nil
                        self.passwordLogin.text = nil
                        
                    }
                    
                })
                
                
            }
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    @objc func backbutton () {
        print("Bittib")
        _ = navigationController?.popViewController(animated: true)
    }
    //  override func viewDidLayoutSubviews() {
    //    super.viewDidLayoutSubviews()
    
    //   gradient.frame = backgroundImage.bounds
    //  }
    
    func setupViews () {
        //
        //    let loginToYourAccounLabelAttrString = NSMutableAttributedString(string: "Login to your account", attributes: [
        //        .font : UIFont(name: "Prompt-Regular", size: 17)!,
        //        .foregroundColor : UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        ////        .kern : -0.41,
        ////        .paragraphStyle : NSMutableParagraphStyle(alignment: .center, lineHeight: nil, paragraphSpacing: 0)
        //    ])
        //    self.loginToYourAccounLabel.attributedText = loginToYourAccounLabelAttrString
        //
        //        let welcomeBackLabelAttrString = NSMutableAttributedString(string: "Welcome back", attributes: [
        //                   .font : UIFont(name: "Prompt-Bold", size: 34)!,
        //                   .foregroundColor : UIColor(red: 1, green: 1, blue: 1, alpha: 1),
        //                   .kern : 0.61,
        //                  // .paragraphStyle : NSMutableParagraphStyle(alignment: .left, lineHeight: nil, paragraphSpacing: 0)
        //               ])
        //    self.welcomeBackLabel.attributedText = welcomeBackLabelAttrString
        
        self.emailLogin.layer.cornerRadius = 22
        self.emailLogin.layer.masksToBounds = true
        
        
        self.passwordLogin.layer.cornerRadius = 22
        self.passwordLogin.layer.masksToBounds = true
        
        
        
        SignUpButton?.applyGradient(colors: [WelcomeViewController.UIColorFromRGB(0xF78361).cgColor,WelcomeViewController.UIColorFromRGB(0xF54B64).cgColor])
        
        
        
        //forgott.setTitle(<#T##title: String?##String?#>, for: <#T##UIControl.State#>)
        
    }
    
    @IBAction func SignUp(_ sender: Any) {
        
        self.performSegue(withIdentifier: "accesoSignIN", sender: nil)
        
    }
    
    
    func textFieldShouldReturn(_ scoreText: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    
    
    @IBAction func SingIn(_ sender: Any) {
        
        guard
            let email = emailLogin.text,
            let password = passwordLogin.text,
            email.count > 0,
            password.count > 0
            else {
                
                errorMensajes.text = "You need your email & password to access Altar."
                return
        }
        
        
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if let error = error, user == nil {
                let alert = UIAlertController(title: "Sign In Failed",
                                              message: error.localizedDescription,
                                              preferredStyle: .alert)
                self.errorMensajes.text = error.localizedDescription
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                
                self.present(alert, animated: true, completion: nil)
            }
                
            else {
                self.accounthelper.loadCurrentUserInfo(completionHandler: { (success) -> Void in
                    
                    
                    if success {
                        
                        self.checkToken ()
  
                        
                    }
//                    guard let churchUID = advengers.shared.currenUSer["churchID"] as? String else {return}
//                    self.accounthelper.loadCurrentChurch(codigo: churchUID, completionHandler: { (success) -> Void in
//
//                    })
//
                    
                    
                })
                self.performSegue(withIdentifier: "accesoOK", sender: nil)
            }
            
        }
    }
    
    func checkToken () {
        
        var listaDeTone = advengers.shared.currenUSer["fcmToken"] as? [String]
        guard let fcmToken = Messaging.messaging().fcmToken else { return }
        
      
        let tiene = listaDeTone?.contains(fcmToken)
        if  tiene ?? false
        {
            print("Yes it contains")
            
        } else {
            print("it do not")
            listaDeTone?.append(fcmToken)
            let currentUser = Database.database().reference().child("users").child(Auth.auth().currentUser!.uid)
            
            guard let diction = ["fcmToken" : listaDeTone] as? [String : Any] else {return}
            
            currentUser.updateChildValues(diction) { (err, ref) in
                if let err = err {
                    //self.navigationItem.rightBarButtonItem?.isEnabled = true
                    print("Failed to update TokenList", err)
                    //      completionHandler(false)
                    return
                }
                
                print("Update TokenList")
                
                
            }
            
        }
        
        
    }
    
}



