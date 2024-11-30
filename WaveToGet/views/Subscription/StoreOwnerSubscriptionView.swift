//
//  StoreOwnerSubscriptionView.swift
//  ReferralAndRewards
//
//  Created by Ismail Gok on 2022-04-24.
//

import SwiftUI
import StoreKit

struct StoreOwnerSubscriptionView: View {
    
    // For getting the ProductIds from the AppStore (for IAP)
//    @StateObject var storeManager = StoreManager()
    @EnvironmentObject var storeManager: StoreManager
    @State private var isSubscribed = false
    
    var body: some View {
        VStack {
            if !storeManager.completedPurchases.isEmpty {
                SearchCard()
            }
            else {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .clipped()
                    .frame(width: 300, height: 300, alignment: .center)
                    .padding()
                
                Spacer()
                
                Text("Subscribe to register your store.")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(Color.MyBlue)
                    .padding(.bottom, 30)
                
                if let product = storeManager.myProducts.first {
    //                if UserDefaults.standard.bool(forKey: product.productIdentifier) {
    //                    Button {
    //                        print("DEBUG: Subscribe button is tapped..")
    //                    } label: {
    //                        Text("Already Subscribed..")
    //                            .foregroundColor(.white)
    //                    }
    //                    .disabled(true)
    //                    .padding()
    //                    .background(Color.MyBlue)
    //                    .clipShape(Capsule())
    //                }
    //                else {
                        NavigationLink(destination: SearchCard(), isActive: $isSubscribed) {
                            Button {
                                print("DEBUG: Subscribe button is tapped..")
                                storeManager.purchaseProduct(product: product)
//                                if UserDefaults.standard.bool(forKey: product.productIdentifier) {
//                                    isSubscribed = true
//                                }
                            } label: {
                                Text("Subscribe for $\(product.price)")
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .background(Color.MyBlue)
                            .clipShape(Capsule())
                        }
                       
    //                }
                    
                    NavigationLink(destination: SearchCard(), isActive: $isSubscribed) {
                        Button {
                            
                            print("DEBUG: Restore button is tapped..")
                            storeManager.restoreProducts()
//                            if UserDefaults.standard.bool(forKey: product.productIdentifier) {
//                                isSubscribed = true
//                            }
                        } label: {
                            Text("Restore Purchase")
                                .foregroundColor(.blue)
                        }
                        .padding()
                        .padding(.bottom, 20)
                    }
                    
                }
            }
            
            
            

        }
//        .onAppear {
//            SKPaymentQueue.default().add(storeManager)
//            storeManager.getProducts(productIDs: productIDs)
//        }
    }
        
}

struct StoreOwnerSubscriptionView_Previews: PreviewProvider {
    static var previews: some View {
        StoreOwnerSubscriptionView()
            .environmentObject(StoreManager())
    }
}
