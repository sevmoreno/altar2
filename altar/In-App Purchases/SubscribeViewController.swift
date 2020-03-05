//
//  SubscribeViewController.swift
//  altar
//
//  Created by Juan Moreno on 2/26/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//

import UIKit
import StoreKit

class SubscribeViewController: UIViewController {
    
    
    // https://www.appcoda.com/in-app-purchases-guide/
     let model = Model()
  //  let product = SKProduct ()
    
    func showAlert(for product: SKProduct) {
           guard let price = IAPManager.shared.getPriceFormatted(for: product) else { return }
           
           let alertController = UIAlertController(title: product.localizedTitle,
                                                   message: product.localizedDescription,
                                                   preferredStyle: .alert)
           
           alertController.addAction(UIAlertAction(title: "Buy now for \(price)", style: .default, handler: { (_) in
               
            
            if !self.model.purchase(product: product) {
                   self.showSingleAlert(withMessage: "In-App Purchases are not allowed in this device.")
               }
//               if !self.viewModel.purchase(product: product) {
//                   self.showSingleAlert(withMessage: "In-App Purchases are not allowed in this device.")
//               }
               
           }))
           
           alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
           self.present(alertController, animated: true, completion: nil)
       }
    
    func showSingleAlert(withMessage message: String) {
           let alertController = UIAlertController(title: "Altar", message: message, preferredStyle: .alert)
           alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
           self.present(alertController, animated: true, completion: nil)
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        model.delegate = self
        
                // ------------- CHECK APP STORE
        
                IAPManager.shared.getProducts { (result) in
                    
                    
                 
                    switch result {
                        
                    case .success (let products):
                        
                        
                        print("Exito bajando productos")
                        self.model.products = products
                         
                        print(self.model.products.debugDescription)
                        
                        
        //                case .success(let products): self.model.products = products
                //       case .failure(let error): self.delegate?.showIAPRelatedError(error)
                       case .failure(_):
                        print("error")
                    }
                    
                }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func subscribe(_ sender: Any) {
        
        showAlert(for: model.products[0])
        
    }
    
    @IBAction func restore(_ sender: Any) {
        
        model.restorePurchases()
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


extension SubscribeViewController: ViewModelDelegate {
//    func toggleOverlay(shouldShow: Bool) {
//        overlayView.isHidden = !shouldShow
//    }
//
//    func willStartLongProcess() {
//        overlayView.isHidden = false
//    }
//
//    func didFinishLongProcess() {
//        overlayView.isHidden = true
//    }
    
    
//    func showIAPRelatedError(_ error: Error) {
//        let message = error.localizedDescription
//
//        // In a real app you might want to check what exactly the
//        // error is and display a more user-friendly message.
//        // For example:
//        /*
//        switch error {
//        case .noProductIDsFound: message = NSLocalizedString("Unable to initiate in-app purchases.", comment: "")
//        case .noProductsFound: message = NSLocalizedString("Nothing was found to buy.", comment: "")
//        // Add more cases...
//        default: message = ""
//        }
//        */
//
//        showSingleAlert(withMessage: message)
//    }
//
    
    func shouldUpdateUI() {
        print("LLEGO POR FIN AL DELAGATE  !!! O YEAAAAA")
        performSegue(withIdentifier: "compraOK", sender: self)
    }
    
//
//    func didFinishRestoringPurchasesWithZeroProducts() {
//        showSingleAlert(withMessage: "There are no purchased items to restore.")
//    }
//
//
//    func didFinishRestoringPurchasedProducts() {
//        showSingleAlert(withMessage: "All previous In-App Purchases have been restored!")
//    }
}
