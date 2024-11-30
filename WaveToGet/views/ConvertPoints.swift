//
//  ConvertPoints.swift
//  wavetoget
//
//  Created by Jesse Lugassy on 2021-02-18.
//

import SwiftUI
struct ConvertPoints: View {
    @EnvironmentObject var custAccount:CustomerAccount
    @EnvironmentObject var account:Account
    @EnvironmentObject var storeAccount:StoreAccount
    @EnvironmentObject var sizing:Sizing
    @State var error:String = ""
    @State var errorBool:Bool = false
    @State var points:String = ""
    @Binding public var page:Int
    var body: some View {
        ZStack
        {
            VStack(alignment: .leading)
            {
                Spacer()
                TextField("Convert", text: $points)
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
//                                .foregroundColor(.MyBlue)
                            
                            Text("CONVERT DOLLARS")
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
//                                .foregroundColor(.MyBlue)
                            
                            Text("CONVERT POINTS")
                                .fontWeight(.semibold)
                                .foregroundColor(.MyBlue)
                                .font(.system(size: 15))
                        }
                    })
                } //: HStack
                .padding(.horizontal, 10.0)
                .frame(height: 60.0)
                .onAppear {
                    print("DEBUG: Entered to ConvertPoints onAppear..")
                    account.infoPage = 5
                }
                
                Button(action: {Back()}, label: {
                    ZStack
                    {
                        RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                            .stroke(Color.MyBlue, lineWidth: 2)
//                            .foregroundColor(.MyBlue)
                        
                        Text("CANCEL")
                            .fontWeight(.semibold)
                            .foregroundColor(.MyBlue)
                            .font(.system(size: 15))
                    }
                })
                .padding(.horizontal, 10.0)
                .frame(height: 60.0)
            }
            .alert(isPresented: $errorBool) {

                Alert(
                    title: Text(error),
                    dismissButton: .default(Text("OK"), action: {
                        Back()
                    })
                )
            }.padding()
            
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        
    }
    func Back() -> Void{
        page = 0
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
                        error = "Converted " + points + " points into " + String((Float(points) ?? 0) * Float(storeAccount.point_value/storeAccount.point_expand)) + "$"
                        errorBool = true
                        points = ""
                    }
                    else
                    {
                        error = "Failed to convert"
                        errorBool = true
                        //failed to add dollars
                    }
                }
            }
        }
    }
    func ConvertDollarsFunc() -> Void{
        if(custAccount.dollars != 0 && (Float(points) ?? 0) > 0 && custAccount.dollars >= Float(points) ?? 0)
        {
            APIRequest().Post(withParameters: ["action":"transact","carduid":account.CardUId,"session":account.SessionToken, "d2p":points,"pin":custAccount.pin,"cardholder":String(custAccount.id)])
            {data in
                DispatchQueue.main.async {
                    print("\n-----------test----------\n" + data + "\n-----------test----------")
                    if(data == "success")
                    {
                        custAccount.dollars -= (Float(points) ?? 0)
                        custAccount.points += Int((Float(points) ?? 0) / Float(storeAccount.point_value/storeAccount.point_expand))
                        error = "Converted " + points + "$ into " + String(Int((Float(points) ?? 0) / Float(storeAccount.point_value/storeAccount.point_expand))) + " points"
                        errorBool = true
                        points = ""
                    }
                    else
                    {
                        error = "Failed to convert"
                        errorBool = true
                        //failed to add dollars
                    }
                }
            }
        }
    }
}
