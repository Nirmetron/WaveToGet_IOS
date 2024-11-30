//
//  Balance.swift
//  ReferralAndRewardsWatchApp WatchKit Extension
//
//  Created by Ismail Gok on 2022-08-27.
//

import SwiftUI

struct Balance: View {
    var dollars:String
    var points:String
    var body: some View {
        ZStack
        {
            Color.white
                .ignoresSafeArea()
            VStack
            {
                Text("BALANCE")
                    .font(.system(size: 17))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 5)
                    .foregroundColor(.black)
                Text("Points")
                    .font(.system(size: 17))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20.0)
                    .padding(.top, 0)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                Text(points)
                    .font(.system(size: 40))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20.0)
                    .foregroundColor(.black)
                Text("Dollars")
                    .font(.system(size: 17))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20.0)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                Text("$" + dollars)
                    .font(.system(size: 40))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20.0)
                    .foregroundColor(.black)
            }
        }
    }
}
