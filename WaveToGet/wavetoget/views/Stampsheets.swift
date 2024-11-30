//
//  Stampsheets.swift
//  wavetoget
//
//  Created by Jesse Lugassy on 2021-02-02.
//

import SwiftUI

struct Stampsheets: View {
    @EnvironmentObject var custAccount:CustomerAccount
    @EnvironmentObject var account:Account
    @EnvironmentObject var storeAccount:StoreAccount
    @State private var currentPage = 0
    
    
    var body: some View {
        ZStack
        {
            RoundedRectangle(cornerRadius: 2).stroke(Color.MyGrey, lineWidth: 2)
            VStack(alignment: .leading)
            {
                //                Text("Stampsheets")
                //                    .font(.largeTitle)
                //                    .frame(maxWidth: .infinity, alignment: .center)
                //PagerView(pageCount: storeAccount.stampsheets.count, currentIndex: $currentPage) {
                ForEach(0..<storeAccount.stampsheets.count, id: \.self)
                { i in
                    ZStack
                    {
                        //                        Color.white
                        //                            .edgesIgnoringSafeArea(.all)
                        //                        RoundedRectangle(cornerRadius: 2).stroke(Color.MyGrey, lineWidth: 2)
                        VStack{
                            Text("Prize")
                                .font(.system(size: 20))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 20.0)
                                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                            Text(storeAccount.stampsheets[i].prize)
                                .font(.system(size: 30))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.bottom, 10.0)
                                .padding(.leading, 20.0)
                            HStack{
                                ForEach(0..<storeAccount.stampsheets[i].size, id: \.self){ j in
                                    var temp:[Stamp] = getArray(i: i)
                                    if(temp.count > j)
                                    {
                                        Rectangle()
                                            .frame(width: 20.0, height: 20.0)
                                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                                    }
                                    else
                                    {
                                        Rectangle()
                                            .frame(width: 20.0, height: 20.0)
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                            .padding(.horizontal, 20.0)
                            if(!account.isCust)
                            {
                                Button(action: {AddStamp(i: i)}, label: {
                                        Text("Add stamp")
                                            .foregroundColor(.white)
                                            .font(.largeTitle)
                                            .frame(minWidth: 50, maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                                            .background(RoundedRectangle(cornerRadius: 30).foregroundColor(.MyBlue))})
                                    .padding(.horizontal, 20.0)
                                    .padding(.top, 5.0)
                                Button(action: {ClaimReward(i: i)}, label: {
                                        Text("Claim reward")
                                            .foregroundColor(.white)
                                            .font(.largeTitle)
                                            .frame(minWidth: 50, maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                                            .background(RoundedRectangle(cornerRadius: 30).foregroundColor(storeAccount.stampsheets[i].size == getArray(i: i).count ? .MyBlue : .gray))})
                                    .padding(.horizontal, 20.0)
                                    .padding(.top, 5.0)
                            }
                        }
                        if(i != storeAccount.stampsheets.count - 1)
                        {
                            Rectangle()
                                .frame(height: 2.0)
                                .foregroundColor(.MyGrey)
                        }
                    }
                }
                //}
                
            }
        }
        .padding(.horizontal,25)
        .frame(height: 300.0)
        
    }
    func AddStamp(i:Int) -> Void{
        if(storeAccount.stampsheets[i].size != getArray(i: i).count)
        {
            APIRequest().Post(withParameters: ["action":"add-stamp","session":account.SessionToken, "stampsheet":String(storeAccount.stampsheets[i].id),"cardholder": String(custAccount.id)])
            {data in
                DispatchQueue.main.async {
                    print("\n-----------test----------\n" + data + "\n-----------test----------")
                    if(data == "success")
                    {
                        var stamp:Stamp = Stamp()
                        stamp.id = 0
                        stamp.stampsheet = storeAccount.stampsheets[i].id
                        stamp.rewardstatus = 0
                        stamp.created = 0
                        stamp.updated = 0
                        
                        custAccount.stamps.append(stamp)
                    }
                    else
                    {
                    }
                }
            }
        }
    }
    func ClaimReward(i:Int) -> Void{
        //        if(custAccount.planName != storeAccount.plans[i].name)
        //        {
        APIRequest().Post(withParameters: ["action":"claim-reward","session":account.SessionToken, "stampsheet":String(storeAccount.stampsheets[i].id),"cardholder": String(custAccount.id)])
        {data in
            DispatchQueue.main.async {
                print("\n-----------test----------\n" + data + "\n-----------test----------")
                if(data == "success")
                {
                    custAccount.stamps.removeAll()
                }
                else
                {
                }
            }
        }
        //}
    }
    func getArray(i:Int)->[Stamp]
    {
        var array:[Stamp] = []
        for stamp in custAccount.stamps {
            if(stamp.stampsheet == storeAccount.stampsheets[i].id)
            {
                array.append(stamp)
            }
        }
        return array
    }
}
struct Stampsheets_Preview: PreviewProvider {
    static var previews: some View {
        let store = StoreAccount()
        let custAcc = CustomerAccount()//for preview testing
        Stampsheets().environmentObject(custAcc).environmentObject(store)
    }
}

