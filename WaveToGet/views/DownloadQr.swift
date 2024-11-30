//
//  DownloadQr.swift
//  Wineries Estate
//
//  Created by Jesse Lugassy on 2022-01-28.
//
//CustomerQR(QrString: $custAccount.phone)
import Foundation
import SwiftUI

struct DownloadQr: View {
    @EnvironmentObject var account:Account
    @EnvironmentObject var custAccount:CustomerAccount
    @EnvironmentObject var storeAccount:StoreAccount
    @EnvironmentObject var sizing:Sizing
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var activity = false
    @State var messages = false
    @State var qrstring = QRAPI.QR_ENDPOINT
    
    let defaultLocalizer = AMPLocalizeUtils.defaultLocalizer
    
    var body: some View {
        
        VStack(spacing:0)
        {
            HStack
            {
                Button(action: {self.Back()}, label: {
                    ZStack
                    {
                        RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                            .stroke(Color.MyBlue, lineWidth: 2)
//                            .foregroundColor(.MyBlue)
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
                
                Spacer()
                
                Text("APP QR")
                    .font(.system(size: 17))
                    .padding(.top, 5.0)
                
                Spacer()
                
            } //: HStack
            .padding(.bottom, 10)
            Text("\(defaultLocalizer.stringForKey(key: "Scan QR code to quickly be linked to the app download page"))!")
                .font(.system(size: 15))
                .padding(.vertical, 5)
                .foregroundColor(.MyBlue)
            CustomerQR(QrString: $qrstring)
            
            if !custAccount.phone.isEmpty {
                Text("\(defaultLocalizer.stringForKey(key: "Referral ID")) #")
                    .font(.system(size: 20))
                    .padding(.vertical, 5)
                    .foregroundColor(.MyBlue)
                    .padding()
                
                Text("\(custAccount.phone)")
//                    .font(.title)
                    .font(.system(size: 40, weight: .bold))
                    .scaledToFill()
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
            }
            
            Divider()
                .padding(.vertical, 5)
            
            Text(defaultLocalizer.stringForKey(key: "SMS Invitation"))
                .font(.system(size: 17))
                .padding(.top, 5.0)
            
            Text("\(defaultLocalizer.stringForKey(key: "Send SMS invitation to your friends to earn a reward"))!")
                .font(.system(size: 15))
                .padding(.vertical, 5)
                .foregroundColor(.MyBlue)
            
            Button(
                action: {
                   sendMessage()
                },label:{
                        ZStack
                        {
                            RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                .stroke(Color.MyBlue, lineWidth: 2)
                            //                                                                .foregroundColor(.MyBlue)
                                .frame(width: 150, height: 40)
                            
                            Text(defaultLocalizer.stringForKey(key: "Send SMS"))
                                .fontWeight(.bold)
                                .foregroundColor(.MyBlue)
                                .font(.system(size: 15))
                        }
                    })
            .padding()
            
            Spacer()
            //add activity button on right side
        }
        .frame(maxWidth:.infinity)
        .overlay(
            RoundedRectangle(cornerRadius: 2)
                .stroke(Color.MyGrey, lineWidth: 2))
        .padding(10)
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
    }
    func Back() -> Void{
        self.presentationMode.wrappedValue.dismiss()
        account.loadedAcc = true
    }
    
    func sendMessage() {
        
        var sms = "sms:&body=Join me to get a $10 reward. Download ReferralAndRewards app and register to \(custAccount.store) with my reference number \(custAccount.phone)"
        
//        APIRequest().Post(withParameters: ["action":"get","id":String(account.store),"session":account.SessionToken], _url: SmsAPI.GET_SMS_TEXT)
        APIRequest().Post(withParameters: ["action":"get","id":String(account.store)], _url: SmsAPI.GET_SMS_TEXT)
        {data in
            DispatchQueue.main.async {
                print("\n-----------test----------\n" + data + "\n-----------test----------")
                if(data != "failed" && data != "nosession" && data != "[]")
                {
                    let jsonData = data.data(using: .utf8)!
                    let test: SmsObject = try! JSONDecoder().decode(SmsObject.self, from: jsonData)
                    print("DEBUG: SmsObject = \(test)")
                    //messageList = test
                    
                    sms = "sms:&body=\(test.msg ?? "") (Use the reference number: \(custAccount.phone) for store named: \(test.store_name ?? String(custAccount.store)))"
                    let strURL = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                    UIApplication.shared.open(URL(string: strURL)!, options: [:], completionHandler: nil)
                }
            }
        }
                
    }
    
    struct SmsObject: Decodable {
//        var id: Int?
        var msg: String?
        var store_name: String?
    }
}
