//
//  Redeemable.swift
//  wavetoget
//
//  Created by Jesse Lugassy on 2021-02-03.
//

import SwiftUI

struct Redeemables: View {
    @EnvironmentObject var storeAcc:StoreAccount
    @EnvironmentObject var custAccount:CustomerAccount
    @EnvironmentObject var account:Account
    @EnvironmentObject var sizing:Sizing
    @State private var currentPage = 0
    @State private var error = ""
    @State private var errorBool = false
    var body: some View {
        ZStack
        {
//            RoundedRectangle(cornerRadius: 2).stroke(Color.MyGrey, lineWidth: 2)
            VStack
            {
                Text("REDEEMABLE")
                    .font(.system(size: 17))
                    .padding(.top, 5.0)
                
                Text("Points")
                    .font(.system(size: 17))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20.0)
                    .padding(.top, 0)
                    .foregroundColor(Color.LoginLinks)
                Text(String(custAccount.points))
                    .font(.system(size: 30))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20.0)
                    .alert(isPresented: $errorBool) {

                        Alert(
                            title: Text(error)
                        )
                    }
                ScrollView
                {
                    ForEach(0..<storeAcc.redeemables.count, id: \.self) { i in
                        Rectangle()
                            .foregroundColor(.MyGrey)
                            .frame(height:1)
                            .padding(.horizontal,20)
                        HStack
                        {
                            VStack
                            {
                                Text(storeAcc.redeemables[i].name)
                                    .font(.system(size: 17))
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text(String(storeAcc.redeemables[i].points))
                                    .font(.system(size: 16))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.bottom, 10.0)
                            }
                            .padding(.leading, 20.0)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            if(!account.isCust)
                            {
                                Button(action: {PayPoints(points: storeAcc.redeemables[i].points, name: storeAcc.redeemables[i].name)}, label: {
                                    ZStack
                                    {
                                        RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                            .stroke((storeAcc.redeemables[i].points <= custAccount.points ? Color.MyBlue : Color.MyGrey), lineWidth: 2)
//                                            .foregroundColor(storeAcc.redeemables[i].points <= custAccount.points ? .MyBlue : .MyGrey)
                                        
                                        Text("Redeem")
                                            .fontWeight(.semibold)
                                            .foregroundColor(storeAcc.redeemables[i].points <= custAccount.points ? Color.MyBlue : Color.MyGrey)
                                            .font(.system(size: 17))
                                    }
                                })
                                .padding(.horizontal, 20.0)
                                .frame(width:sizing.buttonWidth, height: 44.0)
                            }
                        }
                    }
                }
                Spacer()
            }
            .onAppear {
                account.infoPage = 21
            }
        }
    }
    func PayPoints(points:Int, name:String){
        if(points <= custAccount.points)
        {
            APIRequest().Post(withParameters: ["action":"transact","carduid":account.CardUId,"session":account.SessionToken, "use":String(points),"pin":custAccount.pin,"cardholder":String(custAccount.id)])
            {data in
                DispatchQueue.main.async {
                    if(data != "")
                    {

                        error = name + " redeemed for " + String(points) + "!"
                        custAccount.points -= points
                        errorBool = true
                        print(data)
                    }
                    else
                    {
                        error = "Failed to redeem " + name
                        errorBool = true
                    }
                }
            }
        }
        else
        {
            error = "You need " + String(points - custAccount.points) + " more points to buy " + name
        }
    }
}
struct Redeemable_Preview: PreviewProvider {
    static var previews: some View {
        var store = StoreAccount()
        var acc = Account()
        var custAcc = CustomerAccount()//for preview testing
        Redeemables().environmentObject(custAcc).environmentObject(acc).environmentObject(store)
    }
}
