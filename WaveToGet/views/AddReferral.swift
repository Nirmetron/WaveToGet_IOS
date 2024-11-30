//
//  AddReferral.swift
//  Wineries Estate
//
//  Created by Jesse Lugassy on 2021-12-29.
//


import SwiftUI

struct AddReferral: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var custAccount:CustomerAccount
    @EnvironmentObject var storeAccount:StoreAccount
    @EnvironmentObject var account:Account
    @EnvironmentObject var sizing:Sizing
    @Binding var currentPage:Int
    @State var message = "Comment about the referral"
    @State var placeholderString = "Comment about the referral"
    
    
    @State var name = ""
    @State var senderamount = ""
    @State var recieveamount = ""
    
    @State private var alerttext = ""
    @State private var error = false
    @State var isAdded = false
    
    let defaultLocalizer = AMPLocalizeUtils.defaultLocalizer
    
    @State private var messageList: [MessageObj] = []
    var body: some View {
        ScrollView {
            
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
                    
                    Text(defaultLocalizer.stringForKey(key: "ADD REFERRAL"))
                        .font(.system(size: 17))
                        .padding(.top, 5.0)
                        .padding(.leading, -35)
                    
                    Spacer()
                    
                } //: HStack
                VStack
                {
                    Text(alerttext)
                        .padding(.vertical, 5)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundColor(.red)
                        .font(.system(size: sizing.smallTextSize))
                    Spacer()
                    HStack
                    {
                        Text("\(defaultLocalizer.stringForKey(key: "Name")):")
                            .foregroundColor(.MyBlue)
                            .frame(width: account.Ipad ? sizing.ipadHorizontalInputForForm : sizing.horizontalInputForForm,alignment: .leading)
                            .font(.system(size: 17))
                        
                        TextField(storeAccount.ref.name == "" ? "Name" : storeAccount.ref.name, text: $name)
                            .font(.system(size: 15))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                            .disableAutocorrection(true)
                            .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                        
                    }
                    
                    HStack
                    {
                        Text("\(defaultLocalizer.stringForKey(key: "Receiver Amount")):")
                            .foregroundColor(.MyBlue)
                            .frame(width: account.Ipad ? sizing.ipadHorizontalInputForForm : sizing.horizontalInputForForm,alignment: .leading)
                            .font(.system(size: 17))
                        
                        TextField(storeAccount.ref.senderamount == 0 ? defaultLocalizer.stringForKey(key: "Receiver Amount") : String(storeAccount.ref.senderamount), text: $senderamount)
                            .font(.system(size: 15))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                            .disableAutocorrection(true)
                            .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                        
                    }
                    
                    HStack
                    {
                        Text("\(defaultLocalizer.stringForKey(key: "Referrer Amount")):")
                            .foregroundColor(.MyBlue)
                            .frame(width: account.Ipad ? sizing.ipadHorizontalInputForForm : sizing.horizontalInputForForm,alignment: .leading)
                            .font(.system(size: 17))
                        
                        TextField(storeAccount.ref.recieveramount == 0 ? defaultLocalizer.stringForKey(key: "Referrer Amount") : String(storeAccount.ref.recieveramount), text: $recieveamount)
                            .font(.system(size: 15))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                            .disableAutocorrection(true)
                            .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                        
                    }
                    Spacer()
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
                }
                .padding(.horizontal, 10)
    //            .font(.system(size: sizing.smallTextSize))
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
                    Button(action: {AddReferralFunc()}, label: {
                        ZStack
                        {
                            RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                .stroke(Color.MyBlue, lineWidth: 2)
    //                            .foregroundColor(.MyBlue)
                            Text(storeAccount.ref.name == "" ? defaultLocalizer.stringForKey(key: "ADD") : defaultLocalizer.stringForKey(key: "UPDATE"))
                                .fontWeight(.semibold)
                                .foregroundColor(.MyBlue)
                                .font(.system(size: 15))
                        }
                    })
                }
                .onAppear(perform: {onloadfunc()})
                .onAppear {
                    setInitialValues()
                    account.infoPage = 11
                }
                .frame(height: 60.0)
                .padding(.horizontal, 10.0)
                .padding(.bottom, 20.0)
    //            .alert(isPresented: $error) {
    //
    //                Alert(
    //                    title: Text(alerttext),
    //                    dismissButton: .default(Text("OK"), action: {
    //                        Back()
    //                    })
    //                )
    //            }.padding()
                .alert(isPresented: $isAdded) {
                           Alert(
                            title: Text("\(defaultLocalizer.stringForKey(key: "Referral is saved successfully"))!")
                           )
                       }.padding()
            }
            .padding(.bottom, 1)
            
        } //: Scrollview
    }
    func Back() -> Void{
        currentPage = 0
    }
    
    private func setInitialValues() {
        name = storeAccount.ref.name
        senderamount = String(storeAccount.ref.senderamount)
        recieveamount = String(storeAccount.ref.recieveramount)
    }
    
    func GetReferralFunc() -> Void{

            APIRequest().Post(withParameters: ["action":"get-referral","store":String(storeAccount.id),"session":account.SessionToken])
            {data in
                DispatchQueue.main.async {
                    print("\n-----------test----------\n" + data + "\n-----------test----------")
                    
                }
            }
    }
    func AddReferralFunc() -> Void{
        alerttext = ""
        if(recieveamount == "" || senderamount == "")
        {
            alerttext = "\(defaultLocalizer.stringForKey(key: "Please fill in the fields"))."
            return
        }
        
        
        APIRequest().Post(withParameters: ["action":"add-referral","store":String(storeAccount.id),"message":message,"session":account.SessionToken, "name":name, "senderamount":senderamount,"recieveramount":recieveamount])
        {data in
            DispatchQueue.main.async {
                print("\n-----------test----------\n" + data + "\n-----------test----------")
                if(data != "failed" && data != "nosession" && data != "[]")
                {
                    //added
//                    alerttext = storeAccount.ref.name == "" ? "Referral added!" : "Referral updated!"
                    alerttext = ""
                    isAdded = true
//                    error = true
                    storeAccount.ref.senderamount = Float(senderamount) ?? 0
                    storeAccount.ref.name = name
                    storeAccount.ref.message = message
                    storeAccount.ref.recieveramount =  Float(recieveamount) ?? 0
                }
            }
        }
        
    }
    func onloadfunc()
    {
        if(storeAccount.ref.message == "")
        {
            message = "Comment about the referral"
            placeholderString = defaultLocalizer.stringForKey(key: "Comment about the referral")
        }
        else
        {
            message = storeAccount.ref.message
            placeholderString = defaultLocalizer.stringForKey(key: "Comment about the referral")
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

