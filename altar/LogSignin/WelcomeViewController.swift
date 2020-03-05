//
//  WelcomeViewController.swift
//  altar
//
//  Created by Juan Moreno on 1/23/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//

import UIKit
import Firebase

class WelcomeViewController: UIViewController {
    @IBOutlet weak var bgCopyView: UIView? = {
        let a = UIView()
        
        return a
    } ()
      @IBOutlet weak var altarLaber: UILabel!
      @IBOutlet weak var togetherInTheSameLabel: UILabel!
      @IBOutlet weak var withMilionsOfUserLabel: UILabel!

      private var allGradientLayers: [CAGradientLayer] = []
    
    var isConnected = false
    
    @IBOutlet weak var backButton: UIButton!
   
    let accounthelper = AccountHelpers ()


    func checkloopInternet () {
        
         let alertController = UIAlertController(title: "No internet conextion", message: "Try again?", preferredStyle: .alert)
         
         if accounthelper.isConnectedToInternet() {
             isConnected = true
             print("Yes! internet is available.")
             
         } else  {
             
             
             
          //   alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                     
             
                                         
                                 
                                         alertController.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: { (_) in
                     
                                             do {
                                                
                                                
                                                self.checkloopInternet ()
                                                // try Auth.auth().signOut()
                     
                                                 //what happens? we need to present some kind of login controller
                     
                                             } catch let signOutErr {
                                                 print("Failed to sign out:", signOutErr)
                                             }
                     
                     
                                         }))
                    
             
                    
                    present(alertController, animated: true, completion: nil)
             
             
         }
         
         
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
       
 
               
               // do some tasks..
     
     //   try! Auth.auth().signOut()
        
        navigationController?.navigationBar.isHidden = true
//        Auth.auth().addStateDidChangeListener() { auth, user in
//                   // 2
//                   if user != nil {
//                       // 3
//                       self.performSegue(withIdentifier: "accesoOK", sender: nil)
//
//                   }
//               }
        checkloopInternet ()
        setupComponents()

        // Do any additional setup after loading the view.
    }
   // dismiss(animated: true, completion: nil)
    
    static func UIColorFromRGB(_ rgbValue: Int) -> UIColor {
        return UIColor(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16))/255.0, green: ((CGFloat)((rgbValue & 0x00FF00) >> 8))/255.0, blue: ((CGFloat)((rgbValue & 0x0000FF)))/255.0, alpha: 1.0)
    }
    
    private func setupComponents()  {
        
        
        let background: UIImageView = {
            
            let a = UIImageView ()
            a.image = #imageLiteral(resourceName: "univers")
            a.contentMode = .scaleAspectFill
            
            return a
            
        } ()
        
        
        let background_Gray: UIImageView = {
            
            let a = UIImageView ()
            a.image = #imageLiteral(resourceName: "bg copy")
            a.contentMode = .scaleAspectFit
            a.alpha = 0.6
            
            return a
            
        } ()
        
        let logo: UIImageView = {
            
            let a = UIImageView ()
            
            a.image = UIImage(named: "logo")
            
            return a
            
        }  ()
        
        let LogInButton: UIButton = {
            let a = UIButton ()
           
            a.backgroundColor = .white
           // a.tintColor = UIColor(hex: "#ff2d55")
            a.layer.cornerRadius = 22
            a.layer.masksToBounds = true
            a.setTitleColor(UIColor.rgb(red: 255, green: 45, blue: 85), for: .normal)
            let color = UIColor.rgb(red: 255, green: 45, blue: 85)
            a.setTitleColor(color.withAlphaComponent(0.3), for: .highlighted )
            a.setTitle("Log in", for: .normal)
            a.addTarget(self, action: #selector(logInActtion), for: .touchUpInside)
            return a
        }()
        
       
        let SignUpButton: UIButton = {
                  let a = UIButton ()
         
                  a.backgroundColor = UIColor.rgb(red: 247, green: 131, blue: 97)
                  a.layer.cornerRadius = 22
                  a.layer.masksToBounds = true
                  a.setTitleColor(.white , for: .normal)
                  a.setTitle("Sign Up", for: .normal)
            a.setTitleColor(UIColor.white.withAlphaComponent(0.3), for: .highlighted )
            
            a.addTarget(self, action: #selector(sigInActtion), for: .touchUpInside)
            
                  return a
              }()
        
  
        
        // Setup bgCopyView
        self.bgCopyView?.layer.borderColor = UIColor(red: 0.592, green: 0.592, blue: 0.592, alpha: 1).cgColor /* #979797 */
        self.bgCopyView?.layer.borderWidth = 1
        
        let bgCopyViewGradient = CAGradientLayer()
        bgCopyViewGradient.colors = [UIColor.clear.cgColor, UIColor(red: 0.141, green: 0.165, blue: 0.216, alpha: 1).cgColor /* #242A37 */]
        bgCopyViewGradient.locations = [0, 1]
        bgCopyViewGradient.startPoint = CGPoint(x: 0.5, y: 0)
        bgCopyViewGradient.endPoint = CGPoint(x: 0.5, y: 0.95)
        guard let framebg = bgCopyView?.frame else {return}
        bgCopyViewGradient.frame = framebg
        self.bgCopyView?.layer.insertSublayer(bgCopyViewGradient, at: 0)
        self.allGradientLayers.append(bgCopyViewGradient)
        
        
        // Setup findNewFriendsNeaLabel
//        let altarTitle = NSMutableAttributedString(string: "Altar", attributes: [
//            .font : UIFont(name: "Avenir-Heavy", size: 50)!,
//            .foregroundColor : UIColor(red: 1, green: 1, blue: 1, alpha: 1),
//            .kern : -0.8
//            //.paragraphStyle : //NSMutableParagraphStyle(alignment: .left, lineHeight: nil, paragraphSpacing: 0)
//        ])
//
//        self.findNewFriendsNeaLabel.attributedText = altarTitle
//
        // Setup togetherInTheSameLabel
        let togetherInTheSameLabelAttrString: NSAttributedString = {
            
    //    let subtitulo: NSAttributedString = {
            
            let together = NSMutableAttributedString (string: "together", attributes: [
                .font : UIFont(name: "Prompt-BoldItalic", size: 22)!,
                .foregroundColor : UIColor(red: 1, green: 1, blue: 1, alpha: 1),
                .kern : -0.35,
                .paragraphStyle : NSMutableParagraphStyle(alignment: .left, lineHeight: nil, paragraphSpacing: 0)
            ])
            
           let inThe = NSMutableAttributedString(string: " in the same", attributes: [
            .font : UIFont(name: "Prompt-Regular", size: 22)!,
            .foregroundColor : UIColor(red: 1, green: 1, blue: 1, alpha: 1),
            .kern : -0.35,
            .paragraphStyle : NSMutableParagraphStyle(alignment: .left, lineHeight: nil, paragraphSpacing: 0)
        ])
            
               let spirit = NSMutableAttributedString(string: " Spirit", attributes: [
                .font : UIFont(name: "Prompt-Black", size: 22)!,
                .foregroundColor : UIColor(red: 1, green: 1, blue: 1, alpha: 1),
                .kern : -0.35,
                .paragraphStyle : NSMutableParagraphStyle(alignment: .left, lineHeight: nil, paragraphSpacing: 0)
            ])
            
            together.append(inThe)
            
            together.append(spirit)
            
            return together
        
        }()
     //   return subtitulo
            
     //   }()
        
    self.togetherInTheSameLabel.attributedText = togetherInTheSameLabelAttrString
        
//        DispatchQueue.main.async {
//            self.togetherInTheSameLabel.text = "Altar"
//            self.togetherInTheSameLabel.font = UIFont(name: "Avenir-Heavy", size: 50)
//            self.togetherInTheSameLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
//            self.togetherInTheSameLabel.textAlignment = .center
//            // Setup withMilionsOfUserLabel
//        }
        
        
        let withMilionsOfUserLabelAttrString: NSMutableAttributedString  =
            
        {
            
            let weGive = NSMutableAttributedString(string: "We gives you the ability to connect with", attributes: [
            .font : UIFont(name: "Prompt-Regular", size: 17)!,
            .foregroundColor : UIColor(red: 1, green: 1, blue: 1, alpha: 1),
            .kern : -0.41,
            .paragraphStyle : NSMutableParagraphStyle(alignment: .center, lineHeight: nil, paragraphSpacing: 0)
        ])
        
           let yourChurch = NSMutableAttributedString (string: " your church", attributes: [
               .font : UIFont(name: "Prompt-BoldItalic", size: 17)!,
               .foregroundColor : UIColor(red: 1, green: 1, blue: 1, alpha: 1),
               .kern : -0.41,
               .paragraphStyle : NSMutableParagraphStyle(alignment: .center, lineHeight: nil, paragraphSpacing: 0)
           ])
            
            weGive.append(yourChurch)
            
            let toBecome = NSMutableAttributedString (string: " to become stronger in the power of", attributes: [
                .font : UIFont(name: "Prompt-Regular", size: 17)!,
                .foregroundColor : UIColor(red: 1, green: 1, blue: 1, alpha: 1),
                .kern : -0.41,
                .paragraphStyle : NSMutableParagraphStyle(alignment: .center, lineHeight: nil, paragraphSpacing: 0)
            ])
            
            weGive.append(toBecome)
            
            let toUnity = NSMutableAttributedString (string: " unity.", attributes: [
                .font : UIFont(name: "Prompt-BoldItalic", size: 17)!,
                .foregroundColor : UIColor(red: 1, green: 1, blue: 1, alpha: 1),
                .kern : -0.41,
                .paragraphStyle : NSMutableParagraphStyle(alignment: .center, lineHeight: nil, paragraphSpacing: 0)
            ])
            
            weGive.append(toUnity)
            
            return weGive
            
        } ()
        
        self.withMilionsOfUserLabel.attributedText = withMilionsOfUserLabelAttrString
        
        self.withMilionsOfUserLabel.numberOfLines = 0
        

        
        
        // constrains
        
        view.addSubview(background)
        
        background.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width + 10, height: view.frame.height + 10)
        background.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
         background.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        background.contentMode = .scaleAspectFill
        
        view.addSubview(background_Gray)
               
        background_Gray.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width + 10, height: view.frame.height + 10)
        background_Gray.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        background_Gray.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
  
        background_Gray.contentMode = .scaleToFill
        
        
        view.addSubview(logo)
        
        logo.contentMode = .scaleAspectFit
        
        
        
         view.addSubview(altarLaber)
      
        altarLaber.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 258, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 300, height: 0)
        altarLaber.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        logo.anchor(top: nil, left: nil, bottom: altarLaber.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 5, paddingRight: 0, width: 33, height: 44)
         logo.centerXAnchor.constraint(equalTo: altarLaber.centerXAnchor).isActive = true
        
        view.addSubview(togetherInTheSameLabel)
        
        togetherInTheSameLabel.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 330, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: togetherInTheSameLabel.intrinsicContentSize.width, height: togetherInTheSameLabel.intrinsicContentSize.height)
       togetherInTheSameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        view.addSubview(withMilionsOfUserLabel)
               
        withMilionsOfUserLabel.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 373, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 315, height:
            80)
        withMilionsOfUserLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        view.addSubview(LogInButton)
        LogInButton.anchor(top: withMilionsOfUserLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 00, paddingRight: 0, width: 315, height: 44)
        LogInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
       // buttonLoginButton.titleLabel?.text = "Sign up"
        
         
        view.addSubview(SignUpButton)
         SignUpButton.anchor(top: LogInButton.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 315, height: 44)
         SignUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        SignUpButton.applyGradient(colors: [WelcomeViewController.UIColorFromRGB(0xF78361).cgColor,WelcomeViewController.UIColorFromRGB(0xF54B64).cgColor])
    }
    
    
    @objc func logInActtion () {
    
        if isConnected {
            
            
            performSegue(withIdentifier: "logInActtion", sender: self)
        }
    
    
    
    
    }
    
    
    @objc func sigInActtion () {
    
        
        if isConnected {
                  
                  performSegue(withIdentifier: "sigInActtion", sender: self)
                  
              }
    
    
    
    
    }
    
           


}
