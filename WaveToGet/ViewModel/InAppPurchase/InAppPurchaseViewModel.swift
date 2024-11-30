//
//  InAppPurchaseViewModel.swift
//  ReferralAndRewards
//
//  Created by Ismail Gok on 2022-05-25.
//

import SwiftUI
import RevenueCat

class InAppPurhaseViewModel: ObservableObject {
    
    let account: Account
    @Published var userPurchases = [String: Bool]()
    @Published var hasAccess = false
    @Published var price = ""
    @Published var dbError = ""
    
    init(account: Account) {
        
        self.account = account
        
        // Check if the user has active subscription
        Purchases.shared.getCustomerInfo { info, error in
            
            if info?.entitlements[ENTITLEMENT]?.isActive == true {
               
                // unlock access to the user
                self.hasAccess = true
            }
            else {
                self.getOffering()
            }
            
        }
        
    }
    
    func checkActiveSubscription(completion: @escaping(Bool) -> Void) {
        // Check if the user has active subscription
        Purchases.shared.getCustomerInfo { info, error in
            
            if info?.entitlements[ENTITLEMENT]?.isActive == true {
               completion(true)
            }
            else {
                completion(false)
            }
            
        }
    }
    
    func makePurchase(storeID: Int, completion: @escaping (Bool) -> Void) {
        
        Purchases.shared.getProducts([PRODUCT_ID]) { products in
            if !products.isEmpty {
                let skProduct = products[0]
                
                // Purchase products
                Purchases.shared.purchase(product: skProduct) { transaction, purchaserInfo, error, userCancelled in
                    if error == nil && !userCancelled {
                        // Successful purchase
                        self.userPurchases[PRODUCT_ID] = true
                        self.hasAccess = true
                        
                        // call our backend function
                        self.addSubscriptionToDB(storeID: storeID) { result in
                            print("DEBUG: Subscription is added to backend = \(result)")
                        }
                        
                        completion(true)
                    }
                    else {
                        completion(false)
                    }
                }
            }
        }
        
//        RevenueCatServices.purchase(productID: PRODUCT_ID) {
//            self.userPurchases[PRODUCT_ID] = true
//            self.hasAccess = true
//        }
    }
    
    func restorePurchase(completion: @escaping (Bool) -> Void) {
        Purchases.shared.restorePurchases { info, error in
            //... check customerInfo to see if entitlement is now active
            if info?.entitlements[ENTITLEMENT]?.isActive == true {
               
                // unlock access to the user
                self.hasAccess = true
                completion(true)
            }
            else {
                self.getOffering()
                completion(false)
            }
        }
    }
    
    func getOffering() {
        Purchases.shared.getOfferings { (offerings, error) in
            if let package = offerings?.current?.monthly?.storeProduct {
                // Get the price and introductory period from the SKProduct
                self.price = "\(package.price) \(package.currencyCode ?? "") / month"
            }
        }
    }
    
    func addSubscriptionToDB(storeID: Int, completion: @escaping (Bool) -> Void) {
        
        let params = ["action": "subscribe",
                      "id": String(storeID)]
        
        APIRequest().Post(withParameters: params)
        {data in
            DispatchQueue.main.async {
                if(data == "success" || data == "true")
                {
                    self.dbError = ""
                    completion(true)
                }
                else
                {
                    self.dbError = data
                    completion(false)
                }
            }
        }
    }
    
    func fetchSubscriptionStatusFromDB(storeID: Int, completion: @escaping (Bool) -> Void) {
        
        let params = ["action": "is-subscribed",
                      "id": String(storeID)]
        APIRequest().Post(withParameters: params)
        {data in
            DispatchQueue.main.async {
                if(data != "false" && !data.isEmpty)
                {
                    if data == "expired" { // check if the old subscription expired
                        self.checkActiveSubscription { isActive in
                            if isActive {
                                self.addSubscriptionToDB(storeID: storeID) { result in
                                    completion(result)
                                }
                            }
                            else {
                                completion(false)
                            }
                        }
                    }
                    else {
                        self.dbError = ""
                        completion(true)
                    }
                    
                }
                else
                {
                    self.dbError = data
                    completion(false)
                }
            }
        }
        
        
    }
    
}
