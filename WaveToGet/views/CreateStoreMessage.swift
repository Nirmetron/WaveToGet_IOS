//
//  CreateStoreMessage.swift
//  wavetoget
//
//  Created by Jesse Lugassy on 2021-05-26.
//

import SwiftUI

struct CreateStoreMessage: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var custAccount:CustomerAccount
    @EnvironmentObject var storeAccount:StoreAccount
    @EnvironmentObject var account:Account
    @EnvironmentObject var sizing:Sizing
    @Binding var currentPage:Int
    @State var message = "Enter a new message"
    @State var placeholderString = "Enter a new message"
    @State var isDeleted = false
    @State private var messageList: [MessageObj] = []
    
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
                
                Text(defaultLocalizer.stringForKey(key: "STORE MESSAGE"))
                    .font(.system(size: 17))
                    .padding(.top, 5.0)
                    .padding(.leading, -35)
                
                Spacer()
                
            } //: Hstack
            ScrollView
            {
                ForEach(0..<messageList.count, id: \.self)
                { i in
                    Rectangle()
                        .foregroundColor(.MyGrey)
                        .frame(height:1)
                        .padding(.horizontal,20)
                    VStack(spacing:0)
                    {
                        HStack
                        {
                            Text(messageList[i].message ?? "")
                                .fontWeight(.regular)
                                .font(.system(size: 18))
                                .fixedSize(horizontal: false, vertical: true)
                            Spacer()
                            Button(action: {RemoveMessage(messageList[i].id ?? 0)}, label: {
                                ZStack
                                {
                                    RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                        .stroke(Color.MyBlue, lineWidth: 2)
//                                        .foregroundColor(.MyBlue)
                                    
                                    Text(defaultLocalizer.stringForKey(key: "Remove"))
                                        .fontWeight(.semibold)
                                        .foregroundColor(.MyBlue)
                                        .font(.system(size: 17))
                                }
                                })
                            .frame(width:80,height: 44.0)
                        }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal, 10.0)
                }
                Rectangle()
                    .foregroundColor(.MyGrey)
                    .frame(height:1)
                    .padding(.horizontal,20)
            }
            Spacer()
            TextEditor(text: $message)
                .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(height: 200.0)
                .padding(.vertical, 5)
                .padding(.horizontal, 10.0)
                .disableAutocorrection(true)
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                .font(.system(size: 15))
                .foregroundColor(self.message == placeholderString ? .gray : .primary)
                .onTapGesture {
                  if self.message == placeholderString {
                    self.message = ""
                  }
                }
            Spacer()
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
                Button(action: {AddStoreMessage()}, label: {
                    ZStack
                    {
                        RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                            .stroke(Color.MyBlue, lineWidth: 2)
//                            .foregroundColor(.MyBlue)
                        Text(defaultLocalizer.stringForKey(key: "ADD"))
                            .fontWeight(.semibold)
                            .foregroundColor(.MyBlue)
                            .font(.system(size: 15))
                    }
                })
            }
            .frame(height: 60.0)
            .padding(.horizontal, 10.0)
            .padding(.bottom, 20.0)
        }
        .alert(isPresented: $isDeleted) {
                   Alert(
                    title: Text("\(defaultLocalizer.stringForKey(key: "Successfully deleted"))!")
                   )
               }.padding()
        .onAppear(perform: {
            account.infoPage = 12
            GetStoreMessage()
            placeholderString = defaultLocalizer.stringForKey(key: "Enter a new message")
            message = defaultLocalizer.stringForKey(key: "Enter a new message")
        })
        .padding(.bottom, 1)
    }
    func Back() -> Void{
        currentPage = 0
    }
    func GetStoreMessage() -> Void{
        APIRequest().Post(withParameters: ["action":"get-storemessages","id":String(storeAccount.id),"session":account.SessionToken])
        {data in
            DispatchQueue.main.async {
                print("\n-----------test----------\n" + data + "\n-----------test----------")
                if(data != "failed" && data != "nosession" && data != "[]")
                {
                    let jsonData = data.data(using: .utf8)!
                    let test: [MessageObj] = try! JSONDecoder().decode([MessageObj].self, from: jsonData)
                    //print(test)
                    messageList = test
                    messageList.reverse()
                }
            }
        }
    }
    func AddStoreMessage() -> Void{
        if(message != placeholderString && message != "")
        {
            APIRequest().Post(withParameters: ["action":"add-storemessage","store":String(storeAccount.id),"message":message,"session":account.SessionToken])
            {data in
                DispatchQueue.main.async {
                    print("\n-----------test----------\n" + data + "\n-----------test----------")
                    if(data != "failed" && data != "nosession" && data != "[]")
                    {
                        var newMessage = MessageObj()
                        newMessage.message = message
                        newMessage.id = Int(data)
                        messageList.insert(newMessage, at: 0)
                        message = ""
                    }
                }
            }
        }
    }
    func RemoveMessage(_ id:Int)
    {
        APIRequest().Post(withParameters: ["action":"remove-storemessage","session":account.SessionToken,"id":String(id)])
        {data in
            print(data + " ---- TestJsonParse() ----")
            DispatchQueue.main.async {
                if(data != "nosession" && data != "" && data == "1")
                {
                    var i = 0
                    for mess in messageList {
                        if(mess.id == id)
                        {
                            isDeleted = true
                            messageList.remove(at: i)
                        }
                        
                        i += 1
                        
                    }
                }
            }
        }
    }
    struct MessageObj: Decodable {
        var id: Int?
        var store: Int?
        var message: String?
        var created: String?
    }
}
