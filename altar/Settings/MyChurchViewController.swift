//
//  MyChurchViewController.swift
//  altar
//
//  Created by Juan Moreno on 3/12/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//

import UIKit

class MyChurchViewController: UIViewController {

    
    let accountHelper = AccountHelpers ()
    
    @IBOutlet var name: UILabel!
    @IBOutlet var address: UILabel!
    @IBOutlet var state: UILabel!
    @IBOutlet var zipcode: UILabel!
    @IBOutlet var country: UILabel!
    @IBOutlet var email: UILabel!
    @IBOutlet var phone: UILabel!
    @IBOutlet var website: UILabel!
    @IBOutlet var viewContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        accountHelper.loadCurrentUserInfo { (true) in
            
            
            self.name.text = advengers.shared.currentChurchInfo.name ?? ""
            self.address.text = advengers.shared.currentChurchInfo.address ?? ""
            self.state.text = advengers.shared.currentChurchInfo.state ?? ""
            self.zipcode.text = advengers.shared.currentChurchInfo.zipCode ?? ""
            self.country.text = advengers.shared.currentChurchInfo.country ?? ""
            self.email.text = advengers.shared.currentChurchInfo.email ?? ""
            self.phone.text = advengers.shared.currentChurchInfo.phoneNumber ?? ""
            self.website.text = advengers.shared.currentChurchInfo.webSite ?? ""
            
        }
        
        
        viewContainer.layer.cornerRadius = 10
        print(advengers.shared.currentChurchInfo.name)
        print(advengers.shared.currentChurchInfo.address)
        print(advengers.shared.currentChurchInfo.state)
        print(advengers.shared.currentChurchInfo.zipCode)
        print(advengers.shared.currentChurchInfo.country)
        print(advengers.shared.currentChurchInfo.email)
        print(advengers.shared.currentChurchInfo.phoneNumber)
        print(advengers.shared.currentChurchInfo.webSite)
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func goback(_ sender: Any) {
        
        _ = navigationController?.popViewController(animated: true)
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
