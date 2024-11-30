//
//  Buy.swift
//  wavetoget
//
//  Created by Jesse Lugassy on 2021-05-05.
//

import SwiftUI

struct Buy: View {
    @EnvironmentObject var account:Account
    @EnvironmentObject var custAccount:CustomerAccount
    @EnvironmentObject var storeAccount:StoreAccount
    @EnvironmentObject var sizing:Sizing
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var code:String
    @State var itemName = ""
    @State var amount = ""
    @State var type = ""
    @State var error = ""
    @State var itemId = ""
    @State var quantity = ""
    @State var sufficientFunds = true
    var body: some View {
        ZStack
        {
//            RoundedRectangle(cornerRadius: 2).stroke(Color.MyGrey, lineWidth: 2)
            VStack
            {
                ZStack
                {
                    Text("PURCHASE SCANNED ITEM")
                        .font(.system(size: 17))
                        .padding(.top, 5.0)
                }
                Spacer()
                if(type == "points")
                {
                    HStack
                    {
                        Text(String(custAccount.points))
                            .font(.system(size: 30))
                            .padding(.leading, 10.0)
                        Text("points")
                            .frame(maxHeight: 30, alignment: .bottom)
                    }
                }
                else
                {
                    Text("$" + String(format: "%.2f",custAccount.dollars) )
                        .font(.system(size: 30))
                        .padding(.leading, 10.0)
                }
                Text(error)
                    .font(.system(size: 17))
                    .foregroundColor(.red)
                Spacer()
                let temp = itemName + " costs " + amount + " " + type
                Text(temp)
                    .font(.system(size: 30))
                    .padding(.horizontal, 20.0)
                
                Spacer()
                HStack
                {
                    Button(action: {Back()}, label: {
                        ZStack
                        {
                            RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                .stroke(Color.MyBlue, lineWidth: 2)
//                                .foregroundColor(.MyBlue)
                            
                            Text("CANCEL")
                                .fontWeight(.semibold)
                                .foregroundColor(.MyBlue)
                                .font(.system(size: 15))
                        }
                    })
                    Button(action: {Pay()}, label: {
                        ZStack
                        {
                            
                            if(!sufficientFunds)
                            {
                                RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                    .stroke(Color.gray, lineWidth: 1)
                            }
                            else
                            {
                                RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                    .foregroundColor(.MyBlue)
                            }                        
                            
                            Text("PURCHASE")
                                .fontWeight(.semibold)
                                .foregroundColor(!sufficientFunds ? .gray : .white)
                                .font(.system(size: 15))
                        }
                    })
                }
                .frame(height: 60.0)
                .padding(.horizontal, 10.0)
                .padding(.bottom, 20.0)
            }
            .onAppear(perform: {
                HandleCode()
            })
        }
        .padding(.all, 10.0)
    }
    //    case 'buy-item':
    //        if($hi->validate_session() && !empty($hi->user))
    //        {
    //            $tx['points'] = 0;
    //            $tx['dollars'] = 0;
    //            $tx['pin'] = $req['pin'];
    //            $tx['name'] = $req['name'];
    //
    //            if(!empty($req['pts']))
    //            {
    //                $tx['points'] = $req['pts'];
    //                $output = $hi->transact($req['cardholder'], "Used {$tx['points']} points for {$tx['name']}", -$tx['points'], 0, $tx['pin']) ?: 'failed';
    //            }
    func Pay()
    {
        if(type == "dollars")
        {
            PayDollars()
        }
        else
        {
            PayPoints()
        }
    }
    func PayDollars() -> Void{
        if(custAccount.dollars != 0 && custAccount.dollars >= Float(amount) ?? 0)
        {
            APIRequest().Post(withParameters: ["action":"buy-item", "session":account.SessionToken, "dol":amount, "name":itemName,
                                               "id":itemId,"quantity":quantity,"pin":custAccount.pin,"cardholder":String(custAccount.id)])
            {data in
                DispatchQueue.main.async {
                    if(data == "success")
                    {
                        custAccount.dollars -= Float(amount) ?? 0
                        Back()
                    }
                    else
                    {
                        //failed to add dollars
                    }
                }
            }
        }
    }
    func PayPoints() -> Void{
        if(custAccount.points != 0 && custAccount.points >= Int(amount) ?? 0)
        {
            APIRequest().Post(withParameters: ["action":"buy-item", "session":account.SessionToken, "pts":amount, "name":itemName,
                                               "id":itemId,"quantity":quantity,"pin":custAccount.pin,"cardholder":String(custAccount.id)])
            {data in
                DispatchQueue.main.async {
                    if(data == "success")
                    {
                        custAccount.points -= Int(amount) ?? 0
                        Back()
                    }
                    else
                    {
                        //failed to add dollars
                    }
                }
            }
        }
    }
    func HandleCode()
    {
        error = ""
        let array = code.components(separatedBy: "`")
        if(array.count != 5)
        {
            Back()
            return
        }
        itemName = array[0]
        amount = array[1]
        type = array[2]
        itemId = array[3]
        quantity = String((Int(array[4]) ?? 1) - 1)
        if(type == "points")
        {
            if(custAccount.points < Int(amount) ?? 0)
            {
                error = "Insufficient funds..."
                sufficientFunds = false
            }
        }
        else
        {
            if(custAccount.dollars < Float(amount) ?? 0)
            {
                error = "Insufficient funds..."
                sufficientFunds = false
            }
        }
    }
    func Back() -> Void{
        self.presentationMode.wrappedValue.dismiss()
    }
}
