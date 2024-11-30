//
//  CustBalance.swift
//  wavetoget
//
//  Created by Jesse Lugassy on 2021-01-25.
//
import SwiftUI

struct CustBalance: View {
    @EnvironmentObject var custAccount:CustomerAccount
    @EnvironmentObject var account:Account
    @EnvironmentObject var storeAccount:StoreAccount
    @EnvironmentObject var sizing:Sizing
    @State var dollars:String = ""
    @State var points:String = ""
    @State var curPage:String = "BALANCE"
    @State var page:Int = 0
    
    let defaultLocalizer = AMPLocalizeUtils.defaultLocalizer
    
    var body: some View {
//        ScrollView {
            ZStack
            {
                VStack(alignment: .leading)
                {
                    Text(page == 0 ? "BALANCE" : curPage)
                        .font(.system(size: 17))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, 5)
                    
                    HStack(alignment: .center)
                    {
                        VStack(alignment: .center) {
                            
                            Text(defaultLocalizer.stringForKey(key: "Points"))
                                .font(.system(size: 17))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 20.0)
                                .padding(.top, 0)
                                .foregroundColor(Color.LoginLinks)
                                .allowsTightening(true)
                            
                            Text(String(custAccount.points))
                                .font(.system(size: 30))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 20.0)
                                .allowsTightening(true)
                            
                            Spacer()
                            
                        } //: VStack
                        
                        VStack(alignment: .center)
                        {
                            Text(defaultLocalizer.stringForKey(key: "Membership"))
                                .font(.system(size: 17))
                                .frame(maxWidth: .infinity, alignment: .center)
                                .foregroundColor(Color.LoginLinks)
                            
                            if(custAccount.planName == "")
                            {
                                Text(defaultLocalizer.stringForKey(key: "No membership"))
                                    .font(.system(size: 17))
                                    .fontWeight(.semibold)
                            }
                            else
                            {
                                Text(custAccount.planName)
                                    .font(.system(size: 30))
                                    .frame(maxWidth: .infinity, alignment: .center)
                            }
                            Spacer()
                            
                        } //: VStack
                        .padding(.trailing, 20.0)
                        
                    } //: HStack
                    
                    HStack
                    {
                        VStack(alignment: .center) {
                            
                            Text(defaultLocalizer.stringForKey(key: "Dollars"))
                                .font(.system(size: 17))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 20.0)
                                .foregroundColor(Color.LoginLinks)
                                .allowsTightening(true)
                            
                            Text("$" + String(format: "%.2f",custAccount.dollars) )
                                .font(.system(size: 30))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 20.0)
                                .allowsTightening(true)
                            
                            Spacer()
                            
                        } //: VStack
                        
                        Spacer()
                            
                            VStack(alignment: .center)
                            {
                                
                                Text(defaultLocalizer.stringForKey(key: "Referral"))
                                    .font(.system(size: 17))
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .foregroundColor(Color.LoginLinks)
                                
                                if(custAccount.referraltotal <= 0)
                                {
                                    Text(defaultLocalizer.stringForKey(key: "No referrals"))
                                        .font(.system(size: 17))
                                        .fontWeight(.semibold)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                        .padding(.leading, 20.0)
                                        .allowsTightening(true)
                                }
                                else
                                {
                                    HStack(alignment: .center, spacing: 10) {
                                        
                                        Spacer()
                                        
                                        Button(action: {transferReferals()}, label: {
                                            ZStack
                                            {
                                                RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                                    .foregroundColor(.MyBlue)
                                                    .frame(width: 35, height: 35)
                                                Image("back4")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 22.0, height: 22.0)
                                            } //: ZStack
                                        })
                                        
                                        Text("$" + String(format: "%.2f",custAccount.referraltotal) )
                                            .font(.system(size: 30))
                                            .frame(alignment: .center)
                                            .allowsTightening(true)
                                        
                                        Spacer()
                                        
                                    } //: HStack
                                    
                                    
                                }
                                
                                Spacer()
                                
                            } //: VStack
                            .padding(.trailing, 20.0)
                        
                    } //: HStack
                    
                    VStack
                    {
                        if(page == 0)
                        {
                            Spacer()
                            HStack
                            {
                                Button(action: {page = 1
                                    curPage = "ADD DOLLARS"
                                }, label: {
                                    ZStack
                                    {
                                        RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                            .stroke(Color.MyBlue, lineWidth: 2)
    //                                        .foregroundColor(.MyBlue)
                                        
                                        Text(defaultLocalizer.stringForKey(key: "ADD DOLLARS"))
                                            .fontWeight(.semibold)
                                            .foregroundColor(.MyBlue)
                                            .font(.system(size: 15))
                                    }
                                })
                                Button(action: {page = 2
                                    curPage = "ADD POINTS"
                                }, label: {
                                    ZStack
                                    {
                                        RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                            .stroke(Color.MyBlue, lineWidth: 2)
    //                                        .foregroundColor(.MyBlue)
                                        
                                        Text(defaultLocalizer.stringForKey(key: "ADD POINTS"))
                                            .fontWeight(.semibold)
                                            .foregroundColor(.MyBlue)
                                            .font(.system(size: 15))
                                    }
                                })
                            }
                            .padding(.horizontal, 10.0)
                            .frame(height: 60.0)
                            HStack
                            {
                                Button(action: { page = 3
                                    curPage = "USE DOLLARS"
                                }, label: {
                                    ZStack
                                    {
                                        RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                            .stroke(Color.MyBlue, lineWidth: 2)
    //                                        .foregroundColor(.MyBlue)
                                        
                                        Text(defaultLocalizer.stringForKey(key: "USE DOLLARS"))
                                            .fontWeight(.semibold)
                                            .foregroundColor(.MyBlue)
                                            .font(.system(size: 15))
                                    }
                                })
                                Button(action: {page = 4
                                    curPage = "CONVERT"
                                }, label: {
                                    ZStack
                                    {
                                        RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                            .stroke(Color.MyBlue, lineWidth: 2)
    //                                        .foregroundColor(.MyBlue)
                                        
                                        Text(defaultLocalizer.stringForKey(key: "CONVERT"))
                                            .fontWeight(.semibold)
                                            .foregroundColor(.MyBlue)
                                            .font(.system(size: 15))
                                    }
                                })
                            }
                            .padding(.horizontal, 10.0)
                            .frame(height: 60.0)
                        }
                        else if(page == 1)
                        {
                            AddDollars(page:$page)
                        }
                        else if(page == 2)
                        {
                            AddPoints(page:$page)
                        }
                        else if(page == 3)
                        {
                            UseDollars(page:$page)
                        }
                        else if(page == 4)
                        {
                            ConvertPoints(page:$page)
                        }
                    } //: VStack
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                    .padding(.top, 1.0)
                    .padding(.bottom, 20.0)
                    //.ignoresSafeArea(.keyboard, edges: .bottom)
                } //: VStack
                .onAppear {
                    account.infoPage = 18
                }
            } //: ZStack
//        } //: Scrollview
    }
    func transferReferals(){
        
        for index in stride(from: custAccount.referrals.count - 1, through: 0, by: -1) {
            var ref = custAccount.referrals[index]
            if(ref.reciever == Int(custAccount.phone) && ref.claimed == 1)
            {
                usereferral(ref.id, storeAccount.ref.recieveramount, ref.claimed + 1)
                custAccount.referrals.remove(at: index)
                continue
            }
            else if(ref.sender == Int(custAccount.phone) && ref.claimed == 0)
            {
                usereferral(ref.id, storeAccount.ref.senderamount, ref.claimed + 1)
                custAccount.referrals.remove(at: index)
            }
        }
    }
    func usereferral(_ id:Int, _ amount:Float, _ claimed:Int){
        
        APIRequest().Post(withParameters: ["action":"use-referral","session":account.SessionToken, "cardholder":String(custAccount.id), "id":String(id), "amount":String(amount), "claimed":String(claimed)])
        {data in
            DispatchQueue.main.async {
                if(data != "nosession" && data != "")
                {
                    custAccount.dollars += amount
                    custAccount.referraltotal -= amount
                }
                else
                {
                }
            }
        }
    }
}
struct CustBalance_Preview: PreviewProvider {
    static var previews: some View {
        var account = Account()
        var custAccount = CustomerAccount()//for preview testing
        CustBalance().environmentObject(custAccount).environmentObject(account)
    }
}
