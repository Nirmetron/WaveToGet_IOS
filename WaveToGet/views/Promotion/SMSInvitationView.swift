//
//  SMSInvitationView.swift
//  ReferralAndRewards
//
//  Created by Ismail Gok on 2022-08-04.
//

import SwiftUI

struct SMSInvitationView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var custAccount:CustomerAccount
    @EnvironmentObject var storeAccount:StoreAccount
    @EnvironmentObject var account:Account
    @EnvironmentObject var sizing:Sizing
    @Binding var currentPage:Int
    
    @State var message = "Enter a promotion text"
    @State var placeholderString = "Enter a promotion text"
    
    @State var isUpdated = false
    
    let defaultLocalizer = AMPLocalizeUtils.defaultLocalizer
    
    var body: some View {
        VStack {
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
                
                Text(defaultLocalizer.stringForKey(key: "SMS INVITATION TEXT"))
                    .font(.system(size: 17))
                    .padding(.top, 5.0)
                    .padding(.leading, -35)
                
                Spacer()
                
            } //: HStack
            
            Spacer()
            
            TextEditor(text: $message)
                .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(height: 200.0)
                .padding(.vertical, 5)
                .padding(.horizontal, 10.0)
                .disableAutocorrection(true)
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                .foregroundColor(self.message == placeholderString ? .gray : .primary)
                .font(.system(size: 17))
                .onTapGesture {
                  if self.message == placeholderString {
                    self.message = ""
                  }
                }
            
            HStack
            {
                Button(action: {Back()}, label: {
                    ZStack
                    {
                        RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                            .stroke(Color.MyBlue, lineWidth: 2)
//                            .foregroundColor(.MyBlue)
                        
                        Text(defaultLocalizer.stringForKey(key: "CANCEL"))
                            .fontWeight(.semibold)
                            .foregroundColor(.MyBlue)
                            .font(.system(size: 15))
                    }
                })
                Button(action: {
                    setSMSInvitationMessage()
                }, label: {
                    ZStack
                    {
                        RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                            .stroke(Color.MyBlue, lineWidth: 2)
//                            .foregroundColor(.MyBlue)
                        Text(defaultLocalizer.stringForKey(key: "SET"))
                            .fontWeight(.semibold)
                            .foregroundColor(.MyBlue)
                            .font(.system(size: 15))
                    }
                })
            } //: HStack
            .frame(height: 60.0)
            .padding(.horizontal, 10.0)
            .padding(.bottom, 20.0)
        } //: VSTack
        .alert(isPresented: $isUpdated) {
                   Alert(
                    title: Text("\(defaultLocalizer.stringForKey(key: "Successfully updated"))!")
                   )
               }.padding()
            .onAppear {
                getSMSInvitationText()
                message = defaultLocalizer.stringForKey(key: "Enter a promotion text")
                placeholderString = defaultLocalizer.stringForKey(key: "Enter a promotion text")
            }
    } //: body
    
    func Back() -> Void{
        currentPage = 0
    }
    
    private func setSMSInvitationMessage() {
        print("DEBUG: setSMSInvitationMessage is tapped..")
        
        var msgText = ""
        if message != placeholderString {
            msgText = message
        }
        
        APIRequest().Post(withParameters: ["action":"set","id":String(account.store), "message": msgText], _url: SmsAPI.GET_SMS_TEXT)
        {data in
            DispatchQueue.main.async {
                print("\n-----------test----------\n" + data + "\n-----------test----------")
                if(data != "failed" && data != "nosession" && data != "[]")
                {
                   isUpdated = true
                }
                else {
                    isUpdated = false
                }
            }
        }
    }
    
    func getSMSInvitationText() {
                
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
                    
                    message = "\(test.msg ?? "")"
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

//struct SMSInvitationView_Previews: PreviewProvider {
//    static var previews: some View {
//        SMSInvitationView()
//    }
//}
