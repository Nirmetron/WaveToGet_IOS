//
//  More.swift
//  wavetoget
//
//  Created by Jesse Lugassy on 2021-03-29.
//

import SwiftUI

struct More: View {
    @EnvironmentObject var custAccount:CustomerAccount
    @EnvironmentObject var account:Account
    @EnvironmentObject var sizing:Sizing
    @State private var alertMessage = ""
    @State private var isShowingAlert = false
    
    let defaultLocalizer = AMPLocalizeUtils.defaultLocalizer
    
    var body: some View {
        ZStack
        {
            if(account.currentPage == 5 || account.currentPage == 7)
            {
//                RoundedRectangle(cornerRadius: 2).stroke(Color.MyGrey, lineWidth: 2)
                VStack()
                {
//                    if(account.currentPage != 7)
//                    {
//                    Text("MORE")
//                        .font(.system(size: 17))
//                        .padding(.top, 5.0)
//                    Spacer()
//                    }
//                    if(account.currentPage == 7)
//                    {
                    Text(defaultLocalizer.stringForKey(key: "Membership"))
                            .font(.system(size: 17))
                            .padding(.top, 5.0)
                        Spacer()
                        Text(custAccount.planName)
                            .font(.system(size: 17))
                            .fontWeight(.semibold)
                        Text(custAccount.planExpiry)
                            .font(.system(size: 16))
                        Text(custAccount.planDetails)
                            .font(.system(size: 16))
                        Spacer()
                    ScrollView
                    {
                        ForEach(0..<custAccount.benefits.count, id: \.self) { i in
                            Rectangle()
                                .foregroundColor(.MyGrey)
                                .frame(height:1)
                                .padding(.horizontal,20)
                            HStack
                            {
                                VStack
                                {
                                    Text(custAccount.benefits[i].description)
                                        .font(.system(size: 17))
                                        .fontWeight(.semibold)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Text(String(custAccount.benefits[i].quantity))
                                        .font(.system(size: 16))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.bottom, 10.0)
                                }
                                .padding(.leading, 20.0)
                                .frame(maxWidth:.infinity, alignment:.leading)
                                if(!account.isCust)
                                {
                                    Button(action: {UseBenefit(i: i)}, label: {
                                        ZStack
                                        {
                                            RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                                .stroke(Color.MyBlue, lineWidth: 2)
//                                                .foregroundColor(.MyBlue)
                                            
                                            Text("Use")
                                                .fontWeight(.semibold)
                                                .foregroundColor(.MyBlue)
                                                .font(.system(size: 17))
                                        }
                                    })
                                    .padding(.horizontal, 20.0)
                                    .frame(width:sizing.buttonWidth ,height: 44.0)
                                    .alert(isPresented: $isShowingAlert) {
                                        Alert(
                                            title: Text(alertMessage)
                                        )
                                    }
                                    .padding()
                                }
                            }
                        }
                    }
                    //}
                    HStack
                    {
                        Button(action: {account.currentPage  = 6}, label: {
                            ZStack
                            {
                                RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                    .stroke(Color.MyBlue, lineWidth: 2)
//                                    .foregroundColor(.MyBlue)
                                
                                Text("NOTES")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.MyBlue)
                                    .font(.system(size: 15))
                            }
                        })
                        .frame(height: 60.0)
                        Button(action: {account.currentPage = 8}, label: {
                            ZStack
                            {
                                RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                    .stroke(Color.MyBlue, lineWidth: 2)
//                                    .foregroundColor(.MyBlue)
                                
                                Text("PLANS")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.MyBlue)
                                    .font(.system(size: 15))
                            }
                        })
                        .frame(height: 60.0)
                    }
                    .padding(.horizontal, 10.0)
                }
                .padding(.bottom, 20)
                .onAppear{
                    account.infoPage = 22
                }
            }
            else if(account.currentPage == 8)
            {
                Plans(currentPage:$account.currentPage)
            }
            else if(account.currentPage == 9)
            {
                Benefits(currentPage:$account.currentPage)
            }
        }
    }
    func UseBenefit(i:Int) -> Void{
        if(custAccount.benefits[i].quantity != 0)
        {
            APIRequest().Post(withParameters: ["action":"use-benefit","session":account.SessionToken, "benefit":String(custAccount.benefits[i].id),"cardholder":String(custAccount.id),"name":custAccount.benefits[i].description])
            {data in
                DispatchQueue.main.async {
                    print("\n-----------test----------\n" + data + "\n-----------test----------")
                    if(data == "success")
                    {
                        custAccount.benefits[i].quantity -= 1
                        alertMessage = "Successfully used the benefit. \nRemaining benefit is \(custAccount.benefits[i].quantity)."
                        isShowingAlert = true
                    }
                    else
                    {
                        //failed to add dollars
                        alertMessage = "Failed to use the benefit."
                        isShowingAlert = true
                    }
                }
            }
        }
    }
}
struct More_Preview: PreviewProvider {
    static var previews: some View {
        var custAcc = CustomerAccount()//for preview testing
        Membership().environmentObject(custAcc)
    }
}
