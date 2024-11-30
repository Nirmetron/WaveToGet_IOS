//
//  custAccountInfo.swift
//  wavetoget
//
//  Created by Jesse Lugassy on 2021-01-26.
//

import SwiftUI

struct CustAccountInfo: View {
    @EnvironmentObject var custAccount:CustomerAccount
    var body: some View {
            ZStack
            {
                RoundedRectangle(cornerRadius: 2).stroke(Color.MyGrey, lineWidth: 2)
                VStack(alignment: .leading)
                {
//                    Text("Account")
//                        .font(.largeTitle)
//                        .frame(maxWidth: .infinity, alignment: .center)
                    Text("Name")
                        .font(.system(size: 20))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 20.0)
                        .padding(.leading, 20.0)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    Text(custAccount.firstname + " " + custAccount.lastname)
                        .font(.system(size: 30))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 20.0)
                        .padding(.leading, 20.0)
                    Text("Email")
                        .font(.system(size: 20))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20.0)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    Text(custAccount.email)
                        .font(.system(size: 30))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 20.0)
                        .padding(.leading, 20.0)
                    Text("Phone")
                        .font(.system(size: 20))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 10.0)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    Text(custAccount.phone)
                        .font(.system(size: 30))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 20.0)
                        .padding(.leading, 20.0)
                }
            }
            .padding(.horizontal,25)
    }
}
struct custAccountInfo_Preview: PreviewProvider {
    static var previews: some View {
        var custAccount = CustomerAccount()//for preview testing
        CustAccountInfo().environmentObject(custAccount)
    }
}
