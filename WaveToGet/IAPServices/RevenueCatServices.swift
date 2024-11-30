//
//  RevenueCatServices.swift
//  ReferralAndRewards
//
//  Created by Ismail Gok on 2022-05-25.
//

import Foundation
import RevenueCat

class RevenueCatServices {
    static func purchase(productID: String?, successfulPurchase: @escaping () -> Void) {
        guard let productID = productID else {
            return
        }

        // get the Store Products
        Purchases.shared.getProducts([productID]) { products in
            if !products.isEmpty {
                let skProduct = products[0]
                
                // Purchase products
                Purchases.shared.purchase(product: skProduct) { transaction, purchaserInfo, error, userCancelled in
                    if error == nil && !userCancelled {
                        // Successful purchase
                        successfulPurchase()
                    }
                }
            }
        }
    }
}
