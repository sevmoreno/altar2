//
//  AreUaMinisterViewController.swift
//  altar
//
//  Created by Juan Moreno on 1/27/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//

import UIKit

class AreUaMinisterViewController: UIViewController {
    
    


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func imnot(_ sender: Any) {
        print("Click")
        performSegue(withIdentifier: "accesoSignIN", sender: self)
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
