//
//  StoreManager.swift
//  ReferralAndRewards
//
//  Created by Ismail Gok on 2022-04-24.
//

import Foundation
import StoreKit

class StoreManager: NSObject, ObservableObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    @Published var myProducts = [SKProduct]()
    @Published var transactionState: SKPaymentTransactionState?
    @Published var completedPurchases = ""
    var request: SKProductsRequest!
    private let transactionUserDetaultsKey = "storeManagerTransaction"
    
    func getProducts(productIDs: [String]) {
        print("DEBUG: Start requesting products ...")
        let request = SKProductsRequest(productIdentifiers: Set(productIDs))
        request.delegate = self
        request.start()
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print("DEBUG: Did receive response")
        
        if !response.products.isEmpty {
            for fetchedProduct in response.products {
                DispatchQueue.main.async {
                    self.myProducts.append(fetchedProduct)
                }
            }
        }
        
        for invalidIdentifier in response.invalidProductIdentifiers {
            print("DEBUG: Invalid identifiers found: \(invalidIdentifier)")
        }
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        print("DEBUG: Request did fail: \(error)")
    }
    
    func purchaseProduct(product: SKProduct) {
        if SKPaymentQueue.canMakePayments() {
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(payment)
        } else { // If the parental control is on
            print("DEBUG: User can't make payment.")
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchasing:
                transactionState = .purchasing
            case .purchased:
                setSubscriptionStatus(transaction: transaction)
                queue.finishTransaction(transaction)
                transactionState = .purchased
            case .restored:
                setSubscriptionStatus(transaction: transaction)
                queue.finishTransaction(transaction)
                transactionState = .restored
            case .failed, .deferred:
                print("Payment Queue Error: \(String(describing: transaction.error))")
                queue.finishTransaction(transaction)
                transactionState = .failed
                removeSubscriptionStatus()
            default:
                queue.finishTransaction(transaction)
            }
        }
    }
    
    func restoreProducts() {
        print("Restoring products ...")
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    func getSubscriptionReceipt() {
        // Get the receipt if it's available
        if let appStoreReceiptURL = Bundle.main.appStoreReceiptURL,
            FileManager.default.fileExists(atPath: appStoreReceiptURL.path) {

            do {
                let receiptData = try Data(contentsOf: appStoreReceiptURL, options: .alwaysMapped)
                print(receiptData)

                let receiptString = receiptData.base64EncodedString(options: [])

                // Read receiptData
            }
            catch { print("Couldn't read receipt data with error: " + error.localizedDescription) }
        }
    }
    
    func fetchSubscriptionStatus() {
        let identifier = UserDefaults.standard.string(forKey: transactionUserDetaultsKey)
//        completedPurchases = identifier ?? ""
        completedPurchases = "test"
    }
    
    func setSubscriptionStatus(transaction: SKPaymentTransaction) {
        UserDefaults.standard.set(transaction.payment.productIdentifier, forKey: transactionUserDetaultsKey)
        completedPurchases = transaction.payment.productIdentifier
    }
    
    func removeSubscriptionStatus() {
        UserDefaults.standard.removeObject(forKey: transactionUserDetaultsKey)
        completedPurchases = ""
    }
}
