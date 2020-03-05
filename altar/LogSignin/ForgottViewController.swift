//
//  ForgottViewController.swift
//  altar
//
//  Created by Juan Moreno on 1/24/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//

import UIKit
import Firebase

class ForgottViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet var confirmation: UILabel!
    @IBOutlet var sendBTT: UIButton!
    
    @IBOutlet var yourEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        confirmation.isHidden = true
        
        yourEmail.delegate = self
        
        yourEmail.layer.backgroundColor = UIColor.clear.cgColor
        if yourEmail.text!.isEmpty || yourEmail.text! == "Your email" {
            sendBTT.isEnabled = false

            sendBTT.setTitleColor(.gray, for: .normal)
        } else
        {
             sendBTT.isEnabled = true
            sendBTT.setTitleColor(.white, for: .normal)
        }

        // Do any additional setup after loading the view.
    }
    

    @IBAction func goBack(_ sender: Any) {
        
        _ = navigationController?.popViewController(animated: true)
    }
    @IBAction func giMeMyEmail(_ sender: Any) {
        
        if let email = yourEmail.text {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            print(error.debugDescription)
        }
            
            
    }
      
    }
    
  


    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if(string == "\n") {
            textField.resignFirstResponder()
            return false
        }
        return true
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        yourEmail.text = ""
        
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        
        confirmation.isHidden = false
        
    }
}
