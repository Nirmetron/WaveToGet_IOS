//
//  Redeemable.swift
//  wavetoget
//
//  Created by Jesse Lugassy on 2021-02-03.
//

import SwiftUI

struct Redeemables: View {
    @EnvironmentObject var custAccount:CustomerAccount
    @EnvironmentObject var account:Account
    @State private var currentPage = 0
    var body: some View {
        ForEach(0..<custAccount.redeemables.count, id: \.self) { i in
            VStack{
                ZStack
                {
                    RoundedRectangle(cornerRadius: 2).stroke(Color.MyGrey, lineWidth: 2)
                    VStack(alignment: .leading)
                    {
//                        Text("Redeemable")
//                            .font(.largeTitle)
//                            .frame(maxWidth: .infinity, alignment: .center)
                        Text("Name")
                            .font(.system(size: 20))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 20.0)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        Text(custAccount.redeemables[i].name)
                            .font(.system(size: 30))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 10.0)
                            .padding(.leading, 20.0)
                        Text("Cost")
                            .font(.system(size: 20))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 20.0)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        Text(String(custAccount.redeemables[i].points))
                            .font(.system(size: 30))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 10.0)
                            .padding(.leading, 20.0)
                        if(!account.isCust)
                        {
                            Button(action: {PayPoints(points: custAccount.redeemables[i].points)}, label: {
                                    Text("Redeem")
                                        .foregroundColor(.white)
                                        .font(.largeTitle)
                                        .frame(minWidth: 50, maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                                        .background(RoundedRectangle(cornerRadius: 30).foregroundColor(custAccount.points >= custAccount.redeemables[i].points ? .MyBlue : .gray))})
                                .padding(.horizontal, 20.0)
                                .padding(.top, 5.0)
                        }
                    }
                }
            }
        }
        .padding(.horizontal,25)
        .frame(height: 300.0)
    }
    func PayPoints(points:Int){
        if(points <= custAccount.points)
        {
            APIRequest().Post(withParameters: ["id":String(custAccount.id),"token": account.SessionToken,"points":String(points * -1)],_url: "https://www.wavetoget.com/lib/form-transact.php")
            {data in
                DispatchQueue.main.async {
                    if(data != "")
                    {
                        custAccount.points -= points
                        print(data)
                    }
                    else
                    {
                        //add card to store
                    }
                }
            }
        }
    }
}
struct Redeemable_Preview: PreviewProvider {
    static var previews: some View {
        var custAcc = CustomerAccount()//for preview testing
        Redeemables().environmentObject(custAcc)
    }
}
