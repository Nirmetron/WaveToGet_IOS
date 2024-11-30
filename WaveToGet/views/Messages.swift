//
//  Messages.swift
//  wavetoget
//
//  Created by Jesse Lugassy on 2021-06-01.
//

import SwiftUI

struct Messages: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var custAccount:CustomerAccount
    @EnvironmentObject var storeAccount:StoreAccount
    @EnvironmentObject var account:Account
    @EnvironmentObject var sizing:Sizing
    //@Binding var currentPage:Int
    //@State private var messageList: [MessageObj] = []
    
    let defaultLocalizer = AMPLocalizeUtils.defaultLocalizer
    
    var body: some View {
        VStack()
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
                
                Text(defaultLocalizer.stringForKey(key: "Store Message"))
                    .font(.system(size: 17))
                    .padding(.top, 5.0)
                
                Spacer()
                
            } //: HStack
            ScrollView
            {
                ForEach(0..<account.messages.count, id: \.self)
                { i in
                    VStack(alignment: .leading, spacing:0)
                    {
                        Text(account.messages[account.messages.count - 1 - i].message )
                            .fontWeight(.regular)
                            .font(.system(size: 18))
//                            .lineLimit(Int.max)
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal, 10.0)
                    
                    Rectangle()
                        .foregroundColor(.MyGrey)
                        .frame(height:1)
                        .padding(.horizontal,20)
                }
            }
        }
        .onAppear(perform: {
//            account.infoPage = 12
            SaveLastSeenMessage()
        })
        .padding(.bottom, 1)
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
    }
    func Back() -> Void{
        self.presentationMode.wrappedValue.dismiss()
    }
    func SaveLastSeenMessage()-> Void
    {
        if(account.messages.count > 0 && account.newMessage)
        {
            var lastMess = LastMessagesRead()
            lastMess.id = account.messages[account.messages.count - 1].id
            lastMess.store = account.store
            account.lastMessages.append(lastMess)
            account.newMessage = false
        }
    }
//        func GetStoreMessage() -> Void{
//    
//
//
//        APIRequest().Post(withParameters: ["action":"get-storemessages","id":String(storeAccount.id),"session":account.SessionToken])
//        {data in
//            DispatchQueue.main.async {
//                print("\n-----------test----------\n" + data + "\n-----------test----------")
//                if(data != "failed" && data != "nosession" && data != "[]")
//                {
//                    let jsonData = data.data(using: .utf8)!
//                    let test: [MessageObj] = try! JSONDecoder().decode([MessageObj].self, from: jsonData)
//                    //print(test)
//                    messageList = test
//                }
//            }
//        }
//    }
    struct MessageObj: Decodable {
        var id: Int?
        var store: Int?
        var message: String?
        var created: String?
    }
}
