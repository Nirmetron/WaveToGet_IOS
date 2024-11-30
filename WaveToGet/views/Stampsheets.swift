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
    @EnvironmentObject var sizing:Sizing
    @State private var currentPage = 0
    @State private var isLoading = false
    
    @State var error:String = ""
    @State var errorBool:Bool = false
    var body: some View {
        ZStack
        {
//            RoundedRectangle(cornerRadius: 2).stroke(Color.MyGrey, lineWidth: 2)
            VStack
            {
                Text("REWARDS CHART")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(.system(size: 17))
                    .padding(.top, 5.0)
                if(storeAccount.stampsheets.count > 0)
                {
                    ZStack
                    {
                        VStack
                        {
                            //Spacer()
                            var temp:[Stamp] = getArray(i: 0)
                            var collectedAllStamps = false
//                            Text("Wow!")
//                                .font(.system(size: 13))
                            
                            if(storeAccount.stampsheets[0].size > temp.count)
                            {
                                Text("Collect " + String(storeAccount.stampsheets[0].size - temp.count) + " more to get your")
                                    .font(.system(size: 13))
                            }
                            else
                            {
                                Text("You can now claim your")
                                    .font(.system(size: 13))
                            }
                            Text(storeAccount.stampsheets[0].prize)
                                .font(.system(size: 13))
                                .foregroundColor(.MyBlue)
                            
                            Spacer()
                            var iterate = -1
                            
                            ScrollView {
                                HStack {
                                    Spacer()
                                    
                                    VStack(spacing:0)
                                    {
                                        ForEach(0..<storeAccount.stampsheets[0].size / 2, id: \.self){ j in
                                            HStack(spacing:0)
                                            {
                                                ForEach(0..<2, id: \.self){ k in
                                                    let _ = iterate += 1
                                                    VStack{
                                                        Image("star")
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(width: account.Ipad ? sizing.ipadStarSize : sizing.starSize, height: account.Ipad ? sizing.ipadStarSize : sizing.starSize)
                                                            .colorMultiply(temp.count > iterate ? .MyBlue : .MyGrey)
                                                        
                                                        Text(temp.count > iterate ? IntToDateString(custAccount.stamps[iterate].created) : " ")
                                                            .font(.system(size: 10))
                                                    }
                                                    .frame(width: 150.0)
                                                    //.padding(.horizontal, 30.0)
                                                    
                                                }
                                            }
                                        }
                                    } //: VStack
                                    
                                    Spacer()
                                } //: HStack
                                
                            } //: ScrollView
                            
                            
                            Spacer()
//                            if(!account.isCust)
//                            {
                                if(storeAccount.stampsheets[0].size > temp.count)
                                {
                                    Button(action: {AddStamp(i: 0)}, label: {
                                        ZStack
                                        {
                                            RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                                .stroke(Color.MyBlue, lineWidth: 2)
//                                                .foregroundColor(.MyBlue)
                                            
                                            Text("ADD STAMP")
                                                .fontWeight(.semibold)
                                                .foregroundColor(.MyBlue)
                                                .font(.system(size: 20))
                                        }
                                    })
                                    .padding(.horizontal, 10.0)
                                    .frame(height: 60.0)
                                }
                            else {
                                Button(action: {ClaimReward(i: 0)}, label: {
                                    ZStack
                                    {
                                        RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                            .foregroundColor(.MyBlue)
                                        
                                        Text("CLAIM REWARD")
                                            .fontWeight(.semibold)
                                            .foregroundColor(.white)
                                            .font(.system(size: 20))
                                    }
                                })
                                .padding(.horizontal, 10.0)
                                .frame(height: 60.0)
                            }
                            
//                                else
//                                {
//                                    Button(action: {ClaimReward(i: i)}, label: {
//                                        ZStack
//                                        {
//                                            RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
//                                                .foregroundColor(.MyBlue)
//
//                                            Text("CLAIM REWARD")
//                                                .fontWeight(.semibold)
//                                                .foregroundColor(.white)
//                                                .font(.system(size: 20))
//                                        }
//                                    })
//                                    .padding(.horizontal, 10.0)
//                                    .frame(height: 60.0)
//                                }
                            //}
                        }
                        .padding(.bottom, 20.0)
                        .alert(isPresented: $errorBool) {

                            Alert(
                                title: Text(error)
                            )
                        }.padding()
//                        if(i != storeAccount.stampsheets.count - 1)
//                        {
//                            Rectangle()
//                                .frame(height: 2.0)
//                                .foregroundColor(.MyGrey)
//                        }
                    }
                }
                //}
                
            }
            .onAppear {
                account.infoPage = 20
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .padding(.top, 1.0)
        .ignoresSafeArea(.keyboard, edges: .bottom)
        
    }
    func IntToDateString(_ dateTime:Int) -> String{
        let timeInterval = Double(dateTime)
        let date = Date(timeIntervalSince1970: timeInterval)
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .short

        let dateString = formatter.string(from: date)
        
        return dateString
    }
    func AddStamp(i:Int) -> Void{
        if(storeAccount.stampsheets[i].size != getArray(i: i).count && !isLoading)
        {
            isLoading = true
            APIRequest().Post(withParameters: ["action":"add-stamp","session":account.SessionToken, "stampsheet":String(storeAccount.stampsheets[i].id),"cardholder": String(custAccount.id)])
            {data in
                DispatchQueue.main.async {
                    print("\n-----------test----------\n" + data + "\n-----------test----------")
                    if(data == "success")
                    {
//                        let currentTime = Date()
//                        let formatter = DateFormatter()
//                        formatter.timeStyle = .medium
//                        formatter.dateStyle = .long
//                        
//                        let timeString = formatter.string(from: currentTime)
//                        
                        let date1 = Date()
                        let timeInt = Int(date1.timeIntervalSince1970)
                        
                        var stamp:Stamp = Stamp()
                        stamp.id = 0
                        stamp.stampsheet = storeAccount.stampsheets[i].id
                        stamp.rewardstatus = 0
                        stamp.created = timeInt
                        stamp.updated = 0
                        
                        custAccount.stamps.append(stamp)
                        isLoading = false
                        error = "Stamp Added!"
                        errorBool = true
                    }
                    else
                    {
                        error = "Failed to add stamp..."
                        errorBool = true
                    }
                }
            }
        }
    }
    func ClaimReward(i:Int) -> Void{
                if(!isLoading)
                {
                    isLoading = true
        APIRequest().Post(withParameters: ["action":"claim-reward","session":account.SessionToken, "stampsheet":String(storeAccount.stampsheets[i].id),"cardholder": String(custAccount.id)])
        {data in
            DispatchQueue.main.async {
                print("\n-----------test----------\n" + data + "\n-----------test----------")
                if(data == "success")
                {
                    custAccount.stamps.removeAll()
                    isLoading = false
                }
                else
                {
                }
            }
        }
        }
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


//struct Stampsheets_Preview: PreviewProvider {
//    static var previews: some View {
//        let store = StoreAccount()
//        let custAcc = CustomerAccount()//for preview testing
//        Stampsheets().environmentObject(custAcc).environmentObject(store)
//    }
//}

