//
//  Membership.swift
//  wavetoget
//
//  Created by Jesse Lugassy on 2021-01-26.
//

import SwiftUI

struct Benefits: View {
    @EnvironmentObject var custAccount:CustomerAccount
    @EnvironmentObject var account:Account
    @EnvironmentObject var sizing:Sizing
    @Binding var currentPage:Int
    var body: some View {
        ZStack
        {
//            RoundedRectangle(cornerRadius: 2).stroke(Color.MyGrey, lineWidth: 2)
            VStack
            {
                ZStack
                {
                    Button(action: {currentPage = 5}, label: {
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
                    Text("BENEFITS")
                        .font(.system(size: 17))
                        .padding(.top, 5.0)
                }
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
                            .frame(width: 230.0)
                            if(!account.isCust)
                            {
                                Button(action: {UseBenefit(i: i)}, label: {
                                    ZStack
                                    {
                                        RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                            .foregroundColor(.MyBlue)
                                        
                                        Text("Use")
                                            .fontWeight(.semibold)
                                            .foregroundColor(.white)
                                            .font(.system(size: 17))
                                    }
                                })
                                .padding(.horizontal, 20.0)
                                .frame(height: 44.0)
                            }
                        }
                    }
                }
            }
        }
    }
    func UseBenefit(i:Int) -> Void{
        if(custAccount.benefits[i].quantity != 0)
        {
            APIRequest().Post(withParameters: ["action":"use-benefit","session":account.SessionToken, "benefit":String(custAccount.benefits[i].id)])
            {data in
                DispatchQueue.main.async {
                    print("\n-----------test----------\n" + data + "\n-----------test----------")
                    if(data == "success")
                    {
                        custAccount.benefits[i].quantity -= 1
                    }
                    else
                    {
                        //failed to add dollars
                    }
                }
            }
        }
    }
}
struct Benefits_Preview: PreviewProvider {
    static var previews: some View {
        var custAcc = CustomerAccount()//for preview testing
        Benefits(currentPage:.constant(0)).environmentObject(custAcc)
    }
}
