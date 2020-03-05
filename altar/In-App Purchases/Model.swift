//
//  Model.swift
//  altar
//
//  Created by Juan Moreno on 2/25/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//

import Foundation
import UIKit
import StoreKit

protocol ViewModelDelegate {
//    func toggleOverlay(shouldShow: Bool)
//    func willStartLongProcess()
  //  func didFinishLongProcess()
   // func showIAPRelatedError(_ error: Error)
    func shouldUpdateUI()
   // func didFinishRestoringPurchasesWithZeroProducts()
  //  func didFinishRestoringPurchasedProducts()
}



class Model {
    
    var delegate: ViewModelDelegate?
    var products = [SKProduct]()
    
    
    init() {
//        _ = gameData.load()
    }
    
    func restorePurchases() {
     //   delegate?.willStartLongProcess()
        IAPManager.shared.restorePurchases { (result) in
     
            
            DispatchQueue.main.async {
               // self.delegate?.didFinishLongProcess()
             
                switch result {
                case .success(let success):
                    if success {
                       // self.restoreUnlockedMaps()
                      //  self.delegate?.didFinishRestoringPurchasedProducts()
                        self.delegate?.shouldUpdateUI()
                    } else {
                        //self.delegate?.didFinishRestoringPurchasesWithZeroProducts()
                        print("Error Restoring ")
                    }
             
                case .failure(let error):// self.delegate?.showIAPRelatedError(error)
                    print("Error Restoring " + error.localizedDescription)
                    
                }
            }
        }
    }
    
    func getProduct(containing keyword: String) -> SKProduct? {
        return products.filter { $0.productIdentifier.contains(keyword) }.first
    }
    
    func purchase(product: SKProduct) -> Bool {
        if !IAPManager.shared.canMakePayments() {
            return false
        } else {
            
            DispatchQueue.main.async {
            IAPManager.shared.buy(product: product) { (result) in
             switch result {
             case .success(_): self.comproSubs(product: product)
             case .failure(let error): self.errorAlComprar(error: error)
             }
            }
            }
        }
     
        return true
    }
    
    func comproSubs(product: SKProduct) {
        
        print("Ohhh yea show me the MONEEEYY THE MONNNEYYYY ")
        advengers.shared.isPastor = true
        delegate?.shouldUpdateUI()
       
       
    }
    
    func errorAlComprar(error: Error) {
        
        
    }
}
