//
//  Membership.swift
//  wavetoget
//
//  Created by Jesse Lugassy on 2021-01-26.
//

import SwiftUI

struct Membership: View {
    @EnvironmentObject var custAccount:CustomerAccount
    @EnvironmentObject var account:Account
    @State private var currentPage = 0
    var body: some View {
        ZStack
        {
            RoundedRectangle(cornerRadius: 2).stroke(Color.MyGrey, lineWidth: 2)
            VStack(alignment: .leading)
            {
//                                    Text("Membership")
//                                        .font(.largeTitle)
//                                        .frame(maxWidth: .infinity, alignment: .center)
                Text("Plan")
                    .font(.system(size: 20))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20.0)
                    .padding(.top, 20)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                Text(custAccount.planName)
                    .font(.system(size: 30))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 10.0)
                    .padding(.leading, 20.0)
                Text("Expiry")
                    .font(.system(size: 20))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20.0)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                Text(custAccount.planExpiry)
                    .font(.system(size: 30))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 10.0)
                    .padding(.leading, 20.0)
                Text("Details")
                    .font(.system(size: 20))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20.0)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                Text(custAccount.planDetails)
                    .font(.system(size: 30))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 20.0)
                    .padding(.leading, 20.0)
                //PagerView(pageCount: custAccount.benefits.count, currentIndex: $currentPage) {
                    ForEach(0..<custAccount.benefits.count, id: \.self) { i in
//                        ZStack
//                        {
//                            Color.white
//                                .edgesIgnoringSafeArea(.all)
                            //RoundedRectangle(cornerRadius: 2).stroke(Color.MyGrey, lineWidth: 2)
                            VStack{
                                Text(custAccount.benefits[i].description)
                                    .font(.system(size: 20))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 20.0)
                                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                                Text(String(custAccount.benefits[i].quantity))
                                    .font(.system(size: 30))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.bottom, 10.0)
                                    .padding(.leading, 20.0)
                                if(!account.isCust)
                                {
                                    Button(action: {UseBenefit(i: i)}, label: {
                                            Text("Use benefit")
                                                .foregroundColor(.white)
                                                .font(.largeTitle)
                                                .frame(minWidth: 50, maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                                                .background(RoundedRectangle(cornerRadius: 30).foregroundColor(custAccount.benefits[i].quantity != 0 ? .MyBlue : .gray))})
                                        .padding(.horizontal, 20.0)
                                        .padding(.vertical, 10.0)
                                }
                                if(i != custAccount.benefits.count - 1)
                                {
                                    Rectangle()
                                        .frame(height: 2.0)
                                        .foregroundColor(.MyGrey)
                                }
                            }
                        //}
                    }.padding(.bottom, 20)
                //}
            }
        }
        .padding(.horizontal,25)
        
        //.frame(height: 300.0)
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
struct Membership_Preview: PreviewProvider {
    static var previews: some View {
        var custAcc = CustomerAccount()//for preview testing
        Membership().environmentObject(custAcc)
    }
}
