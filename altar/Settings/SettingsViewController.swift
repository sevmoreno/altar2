//
//  SettingsViewController.swift
//  altar
//
//  Created by Juan Moreno on 2/6/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController, UIActivityItemSource {
    
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return "I'm using Altar app"
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        
        
        var mutableMultiLineString = """
               I'm using Altar app.
               Download the app in this link to be together in the same Spirit:
               
               \(URL(string: "https://www.altarapp.org")!.absoluteString)
               """
        
     if advengers.shared.isPastor {

        mutableMultiLineString = """
        We are using Altar app.

        Download the app in this link to be together in the same Spirit:
        
         \(URL(string: "https://www.altarapp.org")!.absoluteString)
        
        Find our church \(advengers.shared.currentChurch) and join us!
        """
       
    
        
        }
        
        return mutableMultiLineString
        
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, subjectForActivityType activityType: UIActivity.ActivityType?) -> String {
         if advengers.shared.isPastor {
        return "\(advengers.shared.currentChurch) is using Altar app."
         } else {
            return "I'm using Altar app."
        }
    }
    
    
    lazy var goBack: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "Close")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(goBackAction), for: .touchUpInside)
        return button
    }()
    
    let titleSettings: UILabel = {
        
        let a = UILabel ()
        
        a.text = "Settings"
        a.font = UIFont(name: "Avenir-Heavy", size: 34)
        a.tintColor = .white
        a.textColor = .white
        return a
        
    } ()
    
    let separador: UIView = {
          
          let a = UIView ()
          
          a.backgroundColor = .lightGray
          
          return a
          
      } ()
    
    let logOut: UIButton = {
        
        /*
        let button = UIButton(type: .system)
        button.setTitle("Log Out", for: .normal)
       // button.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
       // button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont(name: "Avenir-Book", size: 20)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector (logout), for: .touchUpInside)
 */
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont(name: "Avenir-Book", size: 20)
        button.setTitle("Log Out", for: .normal) 
        button.setTitleColor(.white, for: .normal)
      
        button.addTarget(self, action: #selector(logout), for: .touchUpInside)
               
        return button
    }()
    
      let editProfile: UIButton = {
             
             /*
             let button = UIButton(type: .system)
             button.setTitle("Log Out", for: .normal)
            // button.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
            // button.layer.cornerRadius = 5
             button.titleLabel?.font = UIFont(name: "Avenir-Book", size: 20)
             button.setTitleColor(.white, for: .normal)
             button.addTarget(self, action: #selector (logout), for: .touchUpInside)
      */
             let button = UIButton(type: .system)
             button.titleLabel?.font = UIFont(name: "Avenir-Book", size: 20)
             button.setTitle("Edit User Profile", for: .normal)
             button.setTitleColor(.white, for: .normal)
           
             button.addTarget(self, action: #selector(editUserProfile), for: .touchUpInside)
                    
             return button
         }()
    
    
    let editChurchProfile: UIButton = {
                
                /*
                let button = UIButton(type: .system)
                button.setTitle("Log Out", for: .normal)
               // button.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
               // button.layer.cornerRadius = 5
                button.titleLabel?.font = UIFont(name: "Avenir-Book", size: 20)
                button.setTitleColor(.white, for: .normal)
                button.addTarget(self, action: #selector (logout), for: .touchUpInside)
         */
                let button = UIButton(type: .system)
                button.titleLabel?.font = UIFont(name: "Avenir-Book", size: 20)
                button.setTitle("Edit Church Profile", for: .normal)
                button.setTitleColor(.white, for: .normal)
              
                button.addTarget(self, action: #selector(editChurchProfileAction), for: .touchUpInside)
                       
                return button
            }()
    
    let developerButton: UIButton = {
                
                /*
                let button = UIButton(type: .system)
                button.setTitle("Log Out", for: .normal)
               // button.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
               // button.layer.cornerRadius = 5
                button.titleLabel?.font = UIFont(name: "Avenir-Book", size: 20)
                button.setTitleColor(.white, for: .normal)
                button.addTarget(self, action: #selector (logout), for: .touchUpInside)
         */
                let button = UIButton(type: .system)
                button.titleLabel?.font = UIFont(name: "Avenir-Book", size: 20)
                button.setTitle("Developer Info", for: .normal)
                button.setTitleColor(.white, for: .normal)
              
                button.addTarget(self, action: #selector(developerPage), for: .touchUpInside)
                       
                return button
            }()
    
    
    let shareApp: UIButton = {
                   
                   /*
                   let button = UIButton(type: .system)
                   button.setTitle("Log Out", for: .normal)
                  // button.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
                  // button.layer.cornerRadius = 5
                   button.titleLabel?.font = UIFont(name: "Avenir-Book", size: 20)
                   button.setTitleColor(.white, for: .normal)
                   button.addTarget(self, action: #selector (logout), for: .touchUpInside)
            */
                   let button = UIButton(type: .system)
                   button.titleLabel?.font = UIFont(name: "Avenir-Book", size: 20)
                   button.setTitle("Share App", for: .normal)
                   button.setTitleColor(.white, for: .normal)
                 
                   button.addTarget(self, action: #selector(shareAppAction), for: .touchUpInside)
                          
                   return button
               }()
    
    
    let myChurch: UIButton = {
                      
                      /*
                      let button = UIButton(type: .system)
                      button.setTitle("Log Out", for: .normal)
                     // button.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
                     // button.layer.cornerRadius = 5
                      button.titleLabel?.font = UIFont(name: "Avenir-Book", size: 20)
                      button.setTitleColor(.white, for: .normal)
                      button.addTarget(self, action: #selector (logout), for: .touchUpInside)
               */
                      let button = UIButton(type: .system)
                      button.titleLabel?.font = UIFont(name: "Avenir-Book", size: 20)
                      button.setTitle("My Church", for: .normal)
                      button.setTitleColor(.white, for: .normal)
                    
                      button.addTarget(self, action: #selector(myChurchInfo), for: .touchUpInside)
                             
                      return button
                  }()
       
    let pastorMode: UIButton = {
           
           /*
           let button = UIButton(type: .system)
           button.setTitle("Log Out", for: .normal)
          // button.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
          // button.layer.cornerRadius = 5
           button.titleLabel?.font = UIFont(name: "Avenir-Book", size: 20)
           button.setTitleColor(.white, for: .normal)
           button.addTarget(self, action: #selector (logout), for: .touchUpInside)
    */
           let button = UIButton(type: .system)
           button.titleLabel?.font = UIFont(name: "Avenir-Book", size: 20)
           button.setTitle("Change Pastor mode", for: .normal)
           button.setTitleColor(.white, for: .normal)
         
           button.addTarget(self, action: #selector(pastormode), for: .touchUpInside)
                  
           return button
       }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = advengers.shared.colorBlue
        
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(goBack)
        goBack.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 50, paddingLeft: 30, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
       
        view.addSubview(titleSettings)
        titleSettings.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 100, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        titleSettings.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        view.addSubview(separador)
        separador.anchor(top: titleSettings.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 15, paddingLeft: 30, paddingBottom: 0, paddingRight: 30, width: 0, height: 1)
        separador.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        view.addSubview(logOut)
        logOut.anchor(top: separador.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 59, paddingLeft: 0, paddingBottom: 0, paddingRight: 30, width: 0, height: 0)
        logOut.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        view.addSubview(editProfile)
        editProfile.anchor(top: logOut.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 30, width: 0, height: 0)
        editProfile.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        
        view.addSubview(myChurch)
        
        myChurch.anchor(top: editProfile.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 30, width: 0, height: 0)
        myChurch.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
       
        
        view.addSubview(developerButton)
               developerButton.anchor(top: myChurch.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 30, width: 0, height: 0)
               developerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        view.addSubview(shareApp)
                      shareApp.anchor(top: developerButton.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 30, width: 0, height: 0)
                      shareApp.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        
        if advengers.shared.isPastor {
                   
                   view.addSubview(editChurchProfile)
                   editChurchProfile.anchor(top: shareApp.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 30, width: 0, height: 0)
                   editChurchProfile.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

                   
               }
               
        
        
        
//
//        view.addSubview(pastorMode)
//        pastorMode.anchor(top: nil, left: nil, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 50, paddingRight: 30, width: 0, height: 0)
//        pastorMode.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        // Do any additional setup after loading the view.
    }
    
    @objc func logout () {
        
        
        print("Log out ejecutado")
         try? Auth.auth().signOut()
        
     //   dismiss(animated: true, completion: nil)
           navigationController?.dismiss(animated: true, completion: nil)

//
//          let vc =  WelcomeViewController ()
//            present(vc, animated: true)
    // _ = navigationController?.popToRootViewController(animated: true)
        
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil) 
    }
    
    @objc func myChurchInfo () {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
         let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MyChurh") as! UIViewController
        // nextViewController.referalDetailsFromDB()
         self.navigationController?.pushViewController(nextViewController, animated: true)
        
        
        
        
    }
    @objc func editUserProfile () {
        
        
//        let userProfile = EditUserViewController ()
//        navigationController?.pushViewController(userProfile, animated: true)
//        
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "EditProfile") as! EditUserViewController
       // nextViewController.referalDetailsFromDB()
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }
    
    
     @objc func editChurchProfileAction () {
        
        
     //   let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
      //   let nextViewController = storyBoard.instantiateViewController(withIdentifier: "EditChurchProfile") as! EditChurchProfileAllCode
        // nextViewController.referalDetailsFromDB()
        
         let editChurchProfileAllCode = EditChurchProfileAllCode()
        
         self.navigationController?.pushViewController(editChurchProfileAllCode, animated: true)
        
    }
    
    
    @objc func developerPage () {
        
        if let url = URL(string: "https://www.altarapp.org/developer") {
            UIApplication.shared.open(url)
        }
        
        
        
    }
    
    
    @objc func shareAppAction () {
         
      
              let items = [self]
        //  let items: [Any] = ["I'm using Altar app. We can be together in the same Spirit", URL(string: "https://www.altarapp.com")!]
                  let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
                  present(ac, animated: true)
         
     
         
     }
    
    @objc func pastormode () {
        
        advengers.shared.isPastor = !advengers.shared.isPastor
        print("Pastor mode \(advengers.shared.isPastor)")
    }
    
    
    @objc func goBackAction () {
        
        
        print("llego a back")
        navigationController?.dismiss(animated: true, completion: {
            
        })
    }
    /*
     
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
