//
//  CustomerConvert.swift
//  wavetoget
//
//  Created by Jesse Lugassy on 2021-05-17.
//

import SwiftUI
struct CustomerConvert: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var custAccount:CustomerAccount
    @EnvironmentObject var account:Account
    @EnvironmentObject var storeAccount:StoreAccount
    @EnvironmentObject var sizing:Sizing
    @State var points:String = ""
    @State private var errorText = ""
    @State private var isError = false
    
    let defaultLocalizer = AMPLocalizeUtils.defaultLocalizer
    
    var body: some View {
        ZStack
        {
            ZStack
            {
                VStack(alignment: .leading)
                {
                    Text(defaultLocalizer.stringForKey(key: "Convert"))
                        .font(.system(size: 17))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, 5)
                    Spacer()
                    
                    
                    Text(defaultLocalizer.stringForKey(key: "Points"))
                        .font(.system(size: 17))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20.0)
                        .padding(.top, 0)
                        .foregroundColor(Color.LoginLinks)
                    Text(String(custAccount.points))
                        .font(.system(size: 40))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20.0)
                    Text(defaultLocalizer.stringForKey(key: "Dollars"))
                        .font(.system(size: 17))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20.0)
                        .foregroundColor(Color.LoginLinks)
                    Text("$" + String(format: "%.2f",custAccount.dollars) )
                        .font(.system(size: 40))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20.0)
                    Spacer()
                    TextField(defaultLocalizer.stringForKey(key: "Convert"), text: $points)
                        .font(.system(size: 15))
                        .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                        .padding(.horizontal, 20)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.bottom, 5)
                        .disableAutocorrection(true)
                        .keyboardType(.numberPad)
                    HStack
                    {
                        Button(action: {ConvertDollarsFunc()}, label: {
                            ZStack
                            {
                                RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                    .stroke(Color.MyBlue, lineWidth: 2)
//                                    .foregroundColor(.MyBlue)
                                
                                Text(defaultLocalizer.stringForKey(key: "Convert Dollars"))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.MyBlue)
                                    .font(.system(size: 15))
                            }
                        })
                        Button(action: {ConvertPointsFunc()}, label: {
                            ZStack
                            {
                                RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                    .stroke(Color.MyBlue, lineWidth: 2)
//                                    .foregroundColor(.MyBlue)
                                
                                Text(defaultLocalizer.stringForKey(key: "Convert Points"))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.MyBlue)
                                    .font(.system(size: 15))
                            }
                        })
                    }
                    .padding(.horizontal, 10.0)
                    .frame(height: 60.0)
                    Button(action: {Back()}, label: {
                        ZStack
                        {
                            RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                .stroke(Color.MyBlue, lineWidth: 2)
//                                .foregroundColor(.MyBlue)
                            
                            Text(defaultLocalizer.stringForKey(key: "Cancel"))
                                .fontWeight(.semibold)
                                .foregroundColor(.MyBlue)
                                .font(.system(size: 15))
                        }
                    })
                    .padding(.horizontal, 10.0)
                    .frame(height: 60.0)
                }
                .padding(.top, 1.0)
                .padding(.bottom, 20.0)
                .onAppear {
                    account.infoPage = 5
                }
            }
            .alert(isPresented: $isError) {
                       Alert(
                           title: Text(errorText)
                       )
                   }
//            .overlay(
//                RoundedRectangle(cornerRadius: 2)
//                    .stroke(Color.MyGrey, lineWidth: 2)
//            )
            .padding([.top, .leading, .trailing], 10.0)
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
    func Back() -> Void{
        self.presentationMode.wrappedValue.dismiss()
    }
    func ConvertPointsFunc() -> Void{
        if(custAccount.points != 0 && (Int(points) ?? 0) > 0 && custAccount.points >= Int(points) ?? 0)
        {
            APIRequest().Post(withParameters: ["action":"transact","carduid":account.CardUId,"session":account.SessionToken, "convert":points,"pin":custAccount.pin,"cardholder":String(custAccount.id)])
            {data in
                DispatchQueue.main.async {
                    print("\n-----------test----------\n" + data + "\n-----------test----------")
                    if(data == "success")
                    {
                        custAccount.dollars += (Float(points) ?? 0) * Float(storeAccount.point_value/storeAccount.point_expand)
                        custAccount.points -= Int(points) ?? 0
                        points = ""
                        Back()
                    }
                    else
                    {
                        //failed to add dollars
                    }
                }
            }
            errorText = ""
            isError = false
        }
        else {
            if points == "" {
                errorText = "Please enter a number!"
            }
            else {
                errorText = "Not enough points!"
            }
            isError = true
        }
    }
    func ConvertDollarsFunc() -> Void{
        if(custAccount.dollars != 0 && (Float(points) ?? 0) > 0 && custAccount.dollars >= Float(points) ?? 0)
        {
            APIRequest().Post(withParameters: ["action":"transact","carduid":account.CardUId,"session":account.SessionToken, "d2p":points,"pin":custAccount.pin,"cardholder":String(custAccount.id)])
            {data in
                DispatchQueue.main.async {
                    if(data == "success")
                    {
                        custAccount.dollars -= (Float(points) ?? 0)
                        custAccount.points += Int((Float(points) ?? 0) / Float(storeAccount.point_value/storeAccount.point_expand))
                        points = ""
                        Back()
                    }
                    else
                    {
                        //failed to add dollars
                    }
                }
            }
            errorText = ""
            isError = false
        }
        else {
            if points == "" {
                errorText = "Please enter a number!"
            }
            else {
                errorText = "Not enough dollars!"
            }
            isError = true
        }
    }
}
