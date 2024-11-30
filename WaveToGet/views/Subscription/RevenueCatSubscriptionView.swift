//
//  RevenueCatSubscriptionView.swift
//  ReferralAndRewards
//
//  Created by Ismail Gok on 2022-05-25.
//

import SwiftUI

struct RevenueCatSubscriptionView: View {
    
//    @ObservedObject private var inAppPurchaseViewModel = InAppPurhaseViewModel()
    @EnvironmentObject var inAppPurchaseViewModel: InAppPurhaseViewModel
    @EnvironmentObject var account:Account
    @EnvironmentObject var storeAccount:StoreAccount
    @EnvironmentObject var sizing:Sizing
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var isPurchasing: Bool = false
    @State var isPresented: Bool = false
    @State var showingAlert = false
    @State private var showTermsOfUse = false
    @State private var showPrivacyPolicy = false
    
    var body: some View {
//        VStack {
//            if inAppPurchaseViewModel.hasAccess || inAppPurchaseViewModel.userPurchases[PRODUCT_ID] != nil {
        if isPresented {
            SearchCard()
        }
        else {
            ZStack {
                VStack {
                    HStack() {
                        Spacer()
                        
                        Button(action: {Back()}, label: {
                        ZStack
                        {
                            RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                .stroke(Color.MyBlue, lineWidth: 2)
                            //                                                .foregroundColor(.MyBlue)
                                .frame(width: sizing.smallButtonWidth, height: 35)
                            
                            Text("LOG OUT")
                                .fontWeight(.bold)
                                .foregroundColor(.MyBlue)
                                .font(.system(size: 15))
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding([.top, .trailing], 10.0)
                        })
                    }
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
                    
                    Button {
                        print("DEBUG: Subscribe button is tapped..")
                        isPurchasing = true
                        inAppPurchaseViewModel.makePurchase(storeID: storeAccount.id) { isSuccessful in
                            isPurchasing = false
                            
                            if isSuccessful {
                                isPresented = true
                            }
                        }
                    } label: {
                        Text("Subscribe for \(inAppPurchaseViewModel.price)")
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(Color.MyBlue)
                    .clipShape(Capsule())
                    
                    
                    Button {
                        isPurchasing = true
                        
                        print("DEBUG: Restore button is tapped..")
                        inAppPurchaseViewModel.restorePurchase { isSuccessful in
                            isPurchasing = false
                                
                            if isSuccessful {
                                isPresented = true
                            }
                            else {
                                showingAlert = true
                            }
                        }
                    } label: {
                        Text("Restore Purchase")
                            .foregroundColor(.blue)
                    }
                    .padding()                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Error"), message: Text("An active subscription could not be found."), dismissButton: .default(Text("OK")))
                    }
                    
                    // Terms of Use link
                    Button {
                        showTermsOfUse = true
                    } label: {
                        Text("Terms of Use (EULA)")
                            .foregroundColor(.black)
                            .font(.caption)
                    }
                    .padding(5)
                    .fullScreenCover(isPresented: $showTermsOfUse, content: {
                        SFSafariViewWrapper(url: URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/")!)
                    })
                    
                    // Privacy Policy
                    Button {
                        showPrivacyPolicy = true
                    } label: {
                        Text("Privacy Policy")
                            .foregroundColor(.black)
                            .font(.caption)
                    }
                    .padding(5)
                    .fullScreenCover(isPresented: $showPrivacyPolicy, content: {
                        SFSafariViewWrapper(url: URL(string: "https://www.referralandrewards.com/terms.php")!)
                    })
                    
                    
                } //:VStack
                .navigationBarTitle("")
                .navigationBarHidden(true)
                .navigationViewStyle(StackNavigationViewStyle())
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Logout") {
                            print("Help tapped!")
                        }
                    }
                }
                
                // Display an overlay during a purchase
                Rectangle()
                    .foregroundColor(Color.black)
                    .opacity(isPurchasing ? 0.5: 0.0)
                    .edgesIgnoringSafeArea(.all)
                
            } //:ZStack
            
            
        }
            
            
            

//        }
    }
    
    func Back() {
        // Go to login screen
        print("DEBUG: Back button is tapped..")
        self.presentationMode.wrappedValue.dismiss()
        account.loadedAcc = false
    }
}

struct RevenueCatSubscriptionView_Previews: PreviewProvider {
    static var previews: some View {
        let inAppPurchasesViewModel = InAppPurhaseViewModel(account: Account())
        let account = Account()
        var storeAccount = StoreAccount()
        let sizing = Sizing()
        RevenueCatSubscriptionView()
            .environmentObject(inAppPurchasesViewModel)
            .environmentObject(account)
            .environmentObject(storeAccount)
            .environmentObject(sizing)
    }
}
