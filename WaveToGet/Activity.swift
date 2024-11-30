//
//  Activity.swift
//  wavetoget
//
//  Created by Jesse Lugassy on 2021-03-17.
//
import Foundation
import SwiftUI

struct Activity: View {
    @State var note:String = ""
    @EnvironmentObject var custAccount:CustomerAccount
    @EnvironmentObject var account:Account
    @EnvironmentObject var storeAcc:StoreAccount
    @EnvironmentObject var sizing:Sizing
    @State private var transList: [TransObj] = []
    @State private var isLoading = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let defaultLocalizer = AMPLocalizeUtils.defaultLocalizer
    
    var body: some View {
        ZStack
        {
//            RoundedRectangle(cornerRadius: 2).stroke(Color.MyGrey, lineWidth: 2)
            VStack
            {
                HStack
                {
                    if(account.isCust)
                    {
                        Button(action: {self.Back()}, label: {
                            ZStack
                            {
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.MyBlue, lineWidth: 2)
//                                    .foregroundColor(.MyBlue)
                                    .frame(width: 35, height: 35)
                                Image("back2")
                                    .resizable()
                                    .renderingMode(.template)
                                    .foregroundColor(.MyBlue)
                                    .scaledToFit()
                                    .frame(width: 22.0, height: 22.0)
                            }
                            .frame(alignment: .leading)
                            .padding([.top, .leading, .trailing], 10.0)
                        })
                    }
                    
                    Spacer()
                    
                    Text(defaultLocalizer.stringForKey(key: "Activity"))
                        .font(.system(size: 17))
                        .padding(.top, 5.0)
                        .padding(.bottom, 10.0)
                    
                    Spacer()
                    
                } //: HStack
                ScrollView
                {
                    ZStack {
                        ProgressView()
                        // and if you want to be explicit / future-proof...
                        // .progressViewStyle(CircularProgressViewStyle())
                    }
                    .opacity(isLoading ? 1 : 0)
                              
                    
                    ForEach(0..<transList.count, id: \.self)
                    { i in
                        Rectangle()
                            .foregroundColor(.MyGrey)
                            .frame(height:1)
                            .padding(.horizontal,20)
                        VStack(spacing:0)
                        {
                            HStack
                            {
                                Text(transList[i].description ?? "")
                                    .font(.system(size: 17))
                                    .fixedSize(horizontal: false, vertical: true)
                            }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, alignment: .leading)
                            HStack
                            {
                                Text("\(defaultLocalizer.stringForKey(key: "Published by")): " + (transList[i].transactor_displayname ?? "N/A"))
                                    .font(.system(size: sizing.smallTextSize))
                                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, alignment: .leading)
                                Text(GetDate(transList[i].created ?? ""))
                                    .font(.system(size: sizing.smallTextSize))
                            }
                        }
                        .padding(.horizontal, 10.0)
                    }
                    Rectangle()
                        .foregroundColor(.MyGrey)
                        .frame(height:1)
                        .padding(.horizontal,20)
                }
                Spacer()
            }
            .padding(.bottom, 10.0)
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear(perform: GetTransactions)
        .onAppear {
            account.infoPage = -1
        }
    }
    
    func Back() -> Void{
        self.presentationMode.wrappedValue.dismiss()
        account.loadedAcc = true
    }
    
    func GetDate(_ dateTime:String) -> String{
        var dateString = ""
        if(dateTime != "")
        {
            if(dateTime == "Now")
            {
                return "Now"
            }
            var datesplit = dateTime.components(separatedBy: " ")
            var timesplit = datesplit[1].components(separatedBy: ":")
            
            var hour = Int(timesplit[0]) ?? 0
            var ampm = "am"
            
            if(hour == 0)
            {
                hour = 12
            }
            else if(hour > 11)
            {
                if(hour != 12)
                {
                    hour -= 12
                }
                ampm = "pm"
            }
            
            dateString = datesplit[0] + " at " + String(hour) + ":" + timesplit[1] + " " + ampm
        }
        return dateString
    }
    func GetTransactions() -> Void{
        isLoading = true
        
        let params: [String: String] = [
            "action": "get-transactions-cardholder",
            "session": account.SessionToken,
            "cardholder": String(custAccount.id)
        ]
        
        print("DEBUG: get-transactions-cardholder params = \(params)")
        
        APIRequest().Post(withParameters: params)
        {data in
            print(data)
            DispatchQueue.main.async {
                if(data != "failed" && data != "nosession" && data != "")
                {
                    let jsonData = data.data(using: .utf8)!
                    let test: [TransObj] = try! JSONDecoder().decode([TransObj].self, from: jsonData)
                    //print(test)
                    transList = test
                    isLoading = false
                }
                else
                {
                }
            }
        }
    }
    struct TransObj: Decodable {
        var id: Int?
        var store: Int?
        var cardholder: Int?
        var transactor: Int?
        var description: String?
        var points: Int?
        var dollars: String?
        var old_points: Int?
        var old_dollars: String?
        var new_points: Int?
        var new_dollars: String?
        var old_location_points: Int?
        var old_location_dollars: String?
        var new_location_points: Int?
        var new_location_dollars: String?
        var is_pinverified: Int?
        var created: String?
        var transactor_displayname: String?
    }
}

//struct Activity_Preview: PreviewProvider {
//    static var previews: some View {
//        var acc = Account()
//        var cust = CustomerAccount()
//        Activity().environmentObject(cust).environmentObject(acc)
//    }
//}
