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
    @State var dollars:String = ""
    @State var points:String = ""
    var body: some View {
        ZStack
        {
            RoundedRectangle(cornerRadius: 2).stroke(Color.MyGrey, lineWidth: 2)
            VStack(alignment: .leading)
            {
//                Text("Balance")
//                    .font(.largeTitle)
//                    .frame(maxWidth: .infinity, alignment: .center)
//
                VStack{
                    Text("Points")
                        .font(.system(size: 20))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20.0)
                        .padding(.top, 20)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    Text(String(custAccount.points))
                        .font(.system(size: 30))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 10.0)
                        .padding(.leading, 20.0)
                    if(!account.isCust)
                    {
                        HStack
                        {
                            TextField("Add Points", text: $points)
                                .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.black, lineWidth: 1))
                                .padding(.horizontal, 20)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.vertical, 5)
                                .disableAutocorrection(true)
                                .keyboardType(.numberPad)
                            Button(action: {AddPoints()}, label: {
                                    Text("+")
                                        .foregroundColor(.white)
                                        .font(.largeTitle)
                                        .frame(minWidth: 50, maxWidth: 50, minHeight: 50, maxHeight: 50)
                                        .background(RoundedCorners(color: .MyBlue, tl: 0, tr: 0, bl: 0, br: 0))})
                        }
                        .padding(.trailing, 20.0)
                        Button(action: {ConvertPoints()}, label: {
                                Text("Convert points")
                                    .foregroundColor(.white)
                                    .font(.largeTitle)
                                    .frame(minWidth: 50, maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                                    .background(RoundedRectangle(cornerRadius: 30).foregroundColor(custAccount.points != 0 ? .MyBlue : .gray))})
                            .padding(.horizontal, 20.0)
                            .padding(.top, 5.0)
                            .padding(.bottom, 20)
                    }
                }
                VStack{
                    Text("Dollars")
                        .font(.system(size: 20))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20.0)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    Text(String(format: "%.2f",custAccount.dollars) )
                        .font(.system(size: 30))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20.0)
                        .padding(.bottom, 20)
                    if(!account.isCust)
                    {
                        HStack
                        {
                            TextField("Add Dollars", text: $dollars)
                                .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.black, lineWidth: 1))
                                .padding(.horizontal, 20)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.bottom, 5)
                                .disableAutocorrection(true)
                                .keyboardType(.numberPad)
                            Button(action: {PayDollars()}, label: {
                                    Text("-")
                                        .foregroundColor(.white)
                                        .font(.largeTitle)
                                        .frame(minWidth: 50, maxWidth: 50, minHeight: 50, maxHeight: 50)
                                        .background(RoundedCorners(color: .MyBlue, tl: 0, tr: 0, bl: 0, br: 0))})
                            Button(action: {AddDollars()}, label: {
                                    Text("+")
                                        .foregroundColor(.white)
                                        .font(.largeTitle)
                                        .frame(minWidth: 50, maxWidth: 50, minHeight: 50, maxHeight: 50)
                                        .background(RoundedCorners(color: .MyBlue, tl: 0, tr: 0, bl: 0, br: 0))})
                        }
                        .padding(.trailing, 20.0)
                        .padding(.bottom, 20)
                    }
                }
            }
        }
        .padding(.horizontal,25)
        
    }
    func AddDollars() -> Void{
        if(dollars != "")
        {
            APIRequest().Post(withParameters: ["action":"transact","carduid":account.CardUId,"session":account.SessionToken, "add":dollars,"pin":custAccount.pin,"cardholder":String(custAccount.id)])
            {data in
                DispatchQueue.main.async {
                    if(data == "success")
                    {
                        custAccount.dollars += Float(dollars) ?? 0
                        dollars = ""
                    }
                    else
                    {
                        //failed to add dollars
                    }
                }
            }
        }
    }
    func PayDollars() -> Void{
        if(dollars != "")
        {
            APIRequest().Post(withParameters: ["action":"transact","carduid":account.CardUId,"session":account.SessionToken, "pay":dollars,"pin":custAccount.pin,"cardholder":String(custAccount.id)])
            {data in
                DispatchQueue.main.async {
                    if(data == "success")
                    {
                        custAccount.dollars -= Float(dollars) ?? 0
                        dollars = ""
                    }
                    else
                    {
                        //failed to add dollars
                    }
                }
            }
        }
    }
    func AddPoints() -> Void{
        if(points != "")
        {
            APIRequest().Post(withParameters: ["action":"transact","carduid":account.CardUId,"session":account.SessionToken, "purchase":points,"pin":custAccount.pin,"cardholder":String(custAccount.id)])
            {data in
                DispatchQueue.main.async {
                    print("\n-----------test----------\n" + data + "\n-----------test----------")
                    if(data == "success")
                    {
                        //custAccount.dollars += Float(dollars) ?? 0
                        custAccount.points += (Int(points) ?? 0) * Int(storeAccount.point_expand)
                        points = ""
                    }
                    else
                    {
                        //failed to add dollars
                    }
                }
            }
        }
    }
    func ConvertPoints() -> Void{
        if(custAccount.points != 0)
        {
            APIRequest().Post(withParameters: ["action":"transact","carduid":account.CardUId,"session":account.SessionToken, "convert":"p2d","pin":custAccount.pin,"cardholder":String(custAccount.id)])
            {data in
                DispatchQueue.main.async {
                    print("\n-----------test----------\n" + data + "\n-----------test----------")
                    if(data == "success")
                    {
                        custAccount.dollars += Float(custAccount.points) * (storeAccount.point_value/storeAccount.point_expand)
                        custAccount.points = 0
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

struct CustBalance_Preview: PreviewProvider {
    static var previews: some View {
        var account = Account()
        var custAccount = CustomerAccount()//for preview testing
        CustBalance().environmentObject(custAccount).environmentObject(account)
    }
}
