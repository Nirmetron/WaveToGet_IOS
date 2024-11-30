//
//  CreateAccountPrompt.swift
//  wavetoget
//
//  Created by Jesse Lugassy on 2021-10-07.
//
import SwiftUI
import Accelerate

struct CreateAccountPrompt: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var custAccount:CustomerAccount
    @EnvironmentObject var storeAccount:StoreAccount
    @EnvironmentObject var account:Account
    @EnvironmentObject var sizing:Sizing
    @Binding public var page:Int
    @State private var showingInfoPage = false
    
    var body: some View {
        VStack
        {
            HStack {
                
                Button(action: {self.presentationMode.wrappedValue.dismiss()}, label: {
                    ZStack
                    {
                        Image("back6")
                            .resizable()
                            .frame(width: 35.0, height: 35.0)
                            .scaledToFit()
                            .frame(alignment: .top)
                            .colorMultiply(.MyBlue)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.top, .leading,.bottom], 10.0)
                })
                
                Spacer()
                
                // Help Button
//                Button {
//                    showingInfoPage = true
//                } label: {
//                    Image("infoButtonImage-blue")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 30, height: 30)
//                    .padding()
//                }
            }
           
            Spacer()
            
            Text("Create Account")
                .font(.system(size: 25))
            Text("Create account for store owner or client")
                .font(.system(size: 15))
                .padding(.vertical, 10)
                .foregroundColor(.MyBlue)
            HStack
            {
                Button(action: { page = 1
                })
                {
                    ZStack
                    {
                        RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                            .stroke(Color.MyBlue, lineWidth: 2)
//                            .foregroundColor(.MyBlue)
                        HStack
                        {
                            Text("STORE OWNER")
                                .font(.system(size: 15))
                                .fontWeight(.semibold)
                                .foregroundColor(.MyBlue)
                            Image("store-owner-icon")
                                .resizable()
                                .scaledToFit()
                                .padding(.trailing, -20.0)
                        }
                    }
                }
                Button(action: { page = 2
                })
                {
                    ZStack
                    {
                        RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                            .stroke(Color.MyBlue, lineWidth: 2)
//                            .foregroundColor(.MyBlue)
                        HStack
                        {
                            Image("store-client-icon")
                                .resizable()
                                .scaledToFit()
                                .padding(.leading, -40.0)
                            Text("STORE CLIENT")
                                .font(.system(size: 15))
                                .fontWeight(.semibold)
                                .foregroundColor(.MyBlue)
                        }
                    }
                }
            }
            .padding(.horizontal, 10.0)
            .frame(height: 120.0)
            Spacer()
        }
        .onAppear {
            account.infoPage = 2
        }
//        .popover(isPresented: $showingInfoPage, arrowEdge: .bottom) {
//            CreateAccountPopoverContent(presentMe: $showingInfoPage)
//        }
    }
    
}

// Help Button Popover view
struct CreateAccountPopoverContent: View {
   
    @Binding var presentMe : Bool
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 20) {
            
            HStack {
                
                Text("Create Account")
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .padding([.top, .leading])
                
                Spacer ()
                
                // This should be the button to return to the main screen that NOW IT'S FINALLY working
                Button  (action: {
                    
                    // Change the value of the Binding
                    presentMe = false
                    
                }, label: {
                    Image(systemName: "xmark.circle")
                        .foregroundColor(Color.gray)
                })
                .padding([.top, .trailing])
            }
            
            Divider()
                .padding(.horizontal)
                .frame(height: 3.0)
                .foregroundColor(Color.gray)
            
            Spacer()
            
            HStack {
                Spacer()
                
                Image("infoButtonImage-blue")
                    .resizable()
//                    .renderingMode(.template)
                    .scaledToFit()
//                    .foregroundColor(.blue)
                    .frame(width: 50, height: 50, alignment: .center)
                
                Spacer()
            }
            
//            Text("Account registration (main reg. Page)")
//                .font(.title3)
//                .fontWeight(.semibold)
//                .padding(.vertical, 20)
            
            Text("If you are a store owner pick a 'store owner' option while registering, and pay the associated fees through the App store. The app is totally automated, but we will be happy to provide you with maintenance, support, and tutorials on how to use the app.")
                .font(.body)
                .padding(.vertical, 20)
            
            Text("If you are a store client, pick a 'store client' option. For customers of registered businesses, the app is free to use! If the store owner activated the referral function, new customers can enter a referral code while registering to get the bonus. Please note, that you will not be able to enter the referral code after you created the account.")
                .font(.body)
                .padding(.vertical, 20)
            
            Spacer()
        }
        .padding()
//        .frame(width: 350, height: 200)
    }
}
