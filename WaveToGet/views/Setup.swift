//
//  Setup.swift
//  wavetoget
//
//  Created by Jesse Lugassy on 2021-04-01.
//

import SwiftUI

struct Setup: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var custAccount:CustomerAccount
    @EnvironmentObject var account:Account
    @EnvironmentObject var sizing:Sizing
    @State private var currentPage = 0
    @State var selectedPlan = 0
    @State var editProfile = false
    @State var offerCode: OfferCode?
    @State var notification: NewNotification?
    
    let defaultLocalizer = AMPLocalizeUtils.defaultLocalizer

    var body: some View {
        ZStack
        {
//            RoundedRectangle(cornerRadius: 2).stroke(Color.MyGrey, lineWidth: 2)
            if(currentPage == 0)
            {
                VStack()
                {
                    HStack
                    {
                        Button(action: {self.Back()}, label: {
                            ZStack
                            {
                                RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                    .stroke(Color.MyBlue, lineWidth: 2)
//                                    .foregroundColor(.MyBlue)
                                    .frame(width: 35, height: 35)
                                Image("back2")
                                    .resizable()
                                    .renderingMode(.template)
                                    .foregroundColor(.MyBlue)
                                    .scaledToFit()
                                    .frame(width: 22.0, height: 22.0)
                            }
                            .frame(alignment: .leading)
                            .padding([.top, .leading, .trailing], 10.0)
                        })
                        
                        Spacer()
                        
                        Text(defaultLocalizer.stringForKey(key: "SETUP"))
                            .font(.system(size: 17))
                            .padding(.top, 5.0)
                            .padding(.leading, -35)
                        
                        Spacer()
                            
                        
                    } //: HStack
                    
//                    Spacer()
//                    Group
//                    {
//                        Text("EDIT OFFER CODES - Offer codes are the unique alphanumeric strings that you create for customers to redeem. These codes can be sent to customers to take advantage of special offers.")
//                            .font(.system(size: sizing.smallTextSize))
//                        Text("EDIT REDEEMABLES - Once your customer earns enough points, they can finally redeem them. It’s up to the business owner to decide what redeemables they offer. For instance, this could be a gift card, product, or service.")
//                            .font(.system(size: sizing.smallTextSize))
//                        Text("EDIT ACCOUNT INFO - This section includes your business’s account information which are some general details. If your business ever moves locations or changes emails make sure to update your information.")
//                            .font(.system(size: sizing.smallTextSize))
//                        Text("EDIT PLANS - Plans are customizable by business owners. Businesses that allow special membership options, warranty, or any other special plan can add them to this portal. Include the name of the plan and the duration it will be valid for.")
//                            .font(.system(size: sizing.smallTextSize))
//                    }
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding(.all, 10.0)
                    Spacer()
                    
                    HStack
                    {
                        Button(action: {currentPage = 18}, label: {
                            ZStack
                            {
                                RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                    .stroke(Color.MyBlue, lineWidth: 2)

                                Text(defaultLocalizer.stringForKey(key: "SMS INVITATION"))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.MyBlue)
                                    .font(.system(size: 15))
                            }
                        })
                        .frame(height: 60.0)
                        
                        Button(action: {currentPage = 19}, label: {
                            ZStack
                            {
                                RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                    .stroke(Color.MyBlue, lineWidth: 2)

                                Text(defaultLocalizer.stringForKey(key: "EDIT GOOGLE REVIEWS"))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.MyBlue)
                                    .font(.system(size: 15))
                            }
                        })
                        .frame(height: 60.0)

                    } //: HStack
                    .padding(.horizontal, 10.0)
                    
                    HStack
                    {
                        Button(action: {currentPage = 17}, label: {
                            ZStack
                            {
                                RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                    .stroke(Color.MyBlue, lineWidth: 2)

                                Text(defaultLocalizer.stringForKey(key: "VIEW REPORTS"))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.MyBlue)
                                    .font(.system(size: 15))
                            }
                        })
                        .frame(height: 60.0)
                        
                        Button(action: {currentPage = 14}, label: {
                            ZStack
                            {
                                RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                    .stroke(Color.MyBlue, lineWidth: 2)

                                Text(defaultLocalizer.stringForKey(key: "EDIT NOTIFICATIONS"))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.MyBlue)
                                    .font(.system(size: 15))
                            }
                        })
                        .frame(height: 60.0)

                    }
                    .padding(.horizontal, 10.0)
                    
                    HStack
                    {
                        Button(action: {currentPage = 10}, label: {
                            ZStack
                            {
                                RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                    .stroke(Color.MyBlue, lineWidth: 2)
//                                    .foregroundColor(.MyBlue)

                                Text(defaultLocalizer.stringForKey(key: "TRANSACTION RECORDS"))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.MyBlue)
                                    .font(.system(size: 15))
                            }
                        })
                        .frame(height: 60.0)
                        
                        Button(action: {currentPage = 12}, label: {
                            ZStack
                            {
                                RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                    .stroke(Color.MyBlue, lineWidth: 2)
//                                    .foregroundColor(.MyBlue)

                                Text(defaultLocalizer.stringForKey(key: "EDIT STAMPSHEET"))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.MyBlue)
                                    .font(.system(size: 15))
                            }
                        })
                        .frame(height: 60.0)
                    }
                    .padding(.horizontal, 10.0)
                    
                    HStack
                    {
                        Button(action: {currentPage = 7}, label: {
                            ZStack
                            {
                                RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                    .stroke(Color.MyBlue, lineWidth: 2)
//                                    .foregroundColor(.MyBlue)

                                Text(defaultLocalizer.stringForKey(key: "REFERRAL"))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.MyBlue)
                                    .font(.system(size: 15))
                            }
                        })
                        .frame(height: 60.0)
                        
//                        Button(action: {currentPage = 9}, label: {
//                            ZStack
//                            {
//                                RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
//                                    .stroke(Color.MyBlue, lineWidth: 2)
////                                    .foregroundColor(.MyBlue)
//
//                                Text("VISIT RECORDS")
//                                    .fontWeight(.semibold)
//                                    .foregroundColor(.MyBlue)
//                                    .font(.system(size: 15))
//                            }
//                        })
//                        .frame(height: 60.0)
                    }
                    .padding(.horizontal, 10.0)
                    
                    HStack
                    {
                        Button(action: {currentPage = 6}, label: {
                            ZStack
                            {
                                RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                    .stroke(Color.MyBlue, lineWidth: 2)
//                                    .foregroundColor(.MyBlue)

                                Text(defaultLocalizer.stringForKey(key: "STORE MESSAGE"))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.MyBlue)
                                    .font(.system(size: 15))
                            }
                        })
                        .frame(height: 60.0)
                        Button(action: {currentPage = 5}, label: {
                            ZStack
                            {
                                RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                    .stroke(Color.MyBlue, lineWidth: 2)
//                                    .foregroundColor(.MyBlue)

                                Text(defaultLocalizer.stringForKey(key: "EDIT STORE PRODUCTS"))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.MyBlue)
                                    .font(.system(size: 15))
                            }
                        })
                        .frame(height: 60.0)
                    }
                    .padding(.horizontal, 10.0)
                    HStack
                    {
                        Button(action: {currentPage = 4}, label: {
                            ZStack
                            {
                                RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                    .stroke(Color.MyBlue, lineWidth: 2)
//                                    .foregroundColor(.MyBlue)
                                
                                Text(defaultLocalizer.stringForKey(key: "EDIT OFFER CODES"))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.MyBlue)
                                    .font(.system(size: 15))
                            }
                        })
                        .frame(height: 60.0)
                        Button(action: {currentPage = 1}, label: {
                            ZStack
                            {
                                RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                    .stroke(Color.MyBlue, lineWidth: 2)
//                                    .foregroundColor(.MyBlue)
                                
                                Text(defaultLocalizer.stringForKey(key: "EDIT REDEEMABLES"))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.MyBlue)
                                    .font(.system(size: 15))
                            }
                        })
                        .frame(height: 60.0)
                    }
                    .padding(.horizontal, 10.0)
                    HStack
                    {
                        NavigationLink(destination: EditProfile(), isActive: $editProfile) {
                            Button(action: { editProfile = true
                                self.account.EditCust = self.account.isCust
                            })
                            {
                                ZStack
                                {
                                    RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                        .stroke(Color.MyBlue, lineWidth: 2)
//                                        .foregroundColor(.MyBlue)
                                    
                                    Text(defaultLocalizer.stringForKey(key: "EDIT ACCOUNT INFO"))
                                        .fontWeight(.semibold)
                                        .foregroundColor(.MyBlue)
                                        .font(.system(size: 15))
                                }
                            }
                            .frame(height: 60.0)
                        }
                        Button(action: {currentPage = 2}, label: {
                            ZStack
                            {
                                RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                    .stroke(Color.MyBlue, lineWidth: 2)
//                                    .foregroundColor(.MyBlue)
                                
                                Text(defaultLocalizer.stringForKey(key: "EDIT MEMBERSHIP"))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.MyBlue)
                                    .font(.system(size: 15))
                            }
                        })
                        .frame(height: 60.0)
                    }
                    .padding(.horizontal, 10.0)
                    //Spacer()
                }
                .padding(.bottom, 20)
                .onAppear {
                    account.infoPage = 10
                }
            }
            else if(currentPage == 1)
            {
                EditRedeemable(currentPage:$currentPage, selectedPlan: $selectedPlan)
            }
            else if(currentPage == 2)
            {
                EditPlans(currentPage:$currentPage, selectedPlan:$selectedPlan)
            }
            else if(currentPage == 3)
            {
                EditBenefits(currentPage:$currentPage, selectedPlan:$selectedPlan)
            }
            else if(currentPage == 4)
            {
                EditOffercodes(currentPage:$currentPage, selectedPlan: $selectedPlan, offerCode: $offerCode)
            }
            else if(currentPage == 5)
            {
                EditStoreItems(currentPage:$currentPage)
            }
            else if(currentPage == 6)
            {
                CreateStoreMessage(currentPage:$currentPage)
            }
            else if(currentPage == 7)
            {
                AddReferral(currentPage:$currentPage)
            }
            else if currentPage == 8 {
                EditAnOfferView(currentPage: $currentPage, offerCode: $offerCode)
            }
            else if currentPage == 9 {
                VisitsView(currentPage: $currentPage)
            }
            else if currentPage == 10 {
                TransactionsView(currentPage: $currentPage)
            }
            else if currentPage == 11 {
                EditARedeemableView(currentPage: $currentPage, selectedPlan: $selectedPlan)
            }
            else if currentPage == 12 {
                EditStampsheetView(currentPage: $currentPage, selectedPlan: $selectedPlan)
            }
            else if currentPage == 13 {
                EditATimestampView(currentPage: $currentPage, selectedPlan: $selectedPlan)
            }
            else if currentPage == 14 {
                AllNotificationsView(currentPage: $currentPage, notification: $notification)
            }
            else if currentPage == 15 {
                AddNotificationView(currentPage: $currentPage, notification: $notification)
            }
            else if currentPage == 16 {
                EditANotification(currentPage: $currentPage, notification: $notification)
            }
            else if currentPage == 17 {
                ReportsView(currentPage: $currentPage)
            }
            else if currentPage == 18 {
                SMSInvitationView(currentPage: $currentPage)
            }
            else if currentPage == 19 {
                SetReviewRewardView(currentPage: $currentPage)
            }
        }
        
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
        .padding(.all, 10.0)
    }
    func Back() -> Void{
            self.presentationMode.wrappedValue.dismiss()
    }
}
struct Setup_Preview: PreviewProvider {
    static var previews: some View {
        var custAcc = CustomerAccount()//for preview testing
        Setup().environmentObject(custAcc)
    }
}
