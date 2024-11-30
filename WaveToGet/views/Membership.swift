//
//  Benefits.swift
//  wavetoget
//
//  Created by Jesse Lugassy on 2021-02-25.
//

import SwiftUI

struct Membership: View {
    @EnvironmentObject var custAccount:CustomerAccount
    @EnvironmentObject var account:Account
    @EnvironmentObject var sizing:Sizing
    @State private var currentPage = 0
    
    let defaultLocalizer = AMPLocalizeUtils.defaultLocalizer
    
    var body: some View {
        ZStack
        {
//            RoundedRectangle(cornerRadius: 2).stroke(Color.MyGrey, lineWidth: 2)
            if(currentPage == 0)
            {
                VStack()
                {
                    Text(defaultLocalizer.stringForKey(key: "Membership"))
                        .font(.system(size: 17))
                        .padding(.top, 5.0)
                    Spacer()
                    if(custAccount.planName == "")
                    {
                        Text("No membership")
                            .font(.system(size: 17))
                            .fontWeight(.semibold)
                    }
                    else
                    {
                        Text(custAccount.planName)
                            .font(.system(size: 17))
                            .fontWeight(.semibold)
                        Text(custAccount.planExpiry)
                            .font(.system(size: 16))
                        Text(custAccount.planDetails)
                            .font(.system(size: 16))
                    }
                    Spacer()
                    HStack
                    {
                        Button(action: {currentPage = 1}, label: {
                            ZStack
                            {
                                RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                    .foregroundColor(.MyBlue)
                                
                                Text("PLANS")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .font(.system(size: 15))
                            }
                        })
                        Button(action: {currentPage = 2}, label: {
                            ZStack
                            {
                                RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                    .foregroundColor(.MyBlue)
                                
                                Text("BENIFITS")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .font(.system(size: 15))
                            }
                        })
                    }
                    .padding(.horizontal, 10.0)
                    .frame(height: 60.0)
                }
                .padding(.bottom, 20)
            }
            else if(currentPage == 1)
            {
                Plans(currentPage:$currentPage)
            }
            else if(currentPage == 2)
            {
                Benefits(currentPage:$currentPage)
            }
        }
    }
    
}
struct Membership_Preview: PreviewProvider {
    static var previews: some View {
        var custAcc = CustomerAccount()//for preview testing
        Membership().environmentObject(custAcc)
    }
}
