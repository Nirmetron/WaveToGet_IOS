//
//  AddUser.swift
//  wavetoget
//
//  Created by Jesse Lugassy on 2021-02-04.
//

import SwiftUI

struct AddUser: View {
    @State var cardId = "045D9562E74081"
    @EnvironmentObject var account:Account
    @EnvironmentObject var custAccount:CustomerAccount
    @EnvironmentObject var storeAccount:StoreAccount
    @State private var password = ""
    @State private var email = ""
    @State private var display = ""
    @State private var phone = ""
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var search = false
    var body: some View {
        ZStack{
            //            Color.MyGrey
            //                .edgesIgnoringSafeArea(.all)
            VStack
            {
                Button(action: {Back()}, label: {
                        Text("Back")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .frame(minWidth: 90, maxWidth: 90, minHeight: 50, maxHeight: 50)
                            .background(RoundedCorners(color: .MyBlue, tl: 0, tr: 0, bl: 0, br: 0))})
                    .padding(.leading, 30.0)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ZStack
                {
                    RoundedRectangle(cornerRadius: 2).stroke(Color.MyGrey, lineWidth: 2)
                    VStack(alignment: .leading)
                    {
                        Text("Add Account")
                            .font(.largeTitle)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.top, 40)
                        Spacer()
                        TextField("Email", text: $email)
                            .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.black, lineWidth: 1))
                            .padding(.horizontal, 20)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.vertical, 5)
                            .disableAutocorrection(true)
                            .keyboardType(.emailAddress)
                            .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                        SecureField("Password", text: $password)
                            .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.black, lineWidth: 1))
                            .padding(.horizontal, 20)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.vertical, 5)
                        TextField("Display name", text: $display)
                            .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.black, lineWidth: 1))
                            .padding(.horizontal, 20)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.vertical, 5)
                            .disableAutocorrection(true)
                            .keyboardType(.emailAddress)
                            .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                        TextField("Phone number", text: $phone)
                            .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.black, lineWidth: 1))
                            .padding(.horizontal, 20)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.vertical, 5)
                            .keyboardType(.numberPad)
                        Spacer()
                        Spacer()
                        ZStack
                        {
                            Text("")
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 82, maxHeight: 82)
                                .background(RoundedCorners(color: .MyGrey, tl: 0, tr: 0, bl: 2, br: 2))
                            NavigationLink(destination: CustomerAccountView(), isActive: $search) {
                                Button(action: {
                                    AddUserFunc()
                                })
                                {
                                    Text("Add User")
                                        .foregroundColor(.white)
                                        .font(.largeTitle)
                                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 80, maxHeight: 80)
                                        .background(RoundedCorners(color: .MyBlue, tl: 0, tr: 0, bl: 2, br: 2))
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal,25)
                .frame(height: 400.0)
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        }
    }
    func Back() -> Void{
        self.presentationMode.wrappedValue.dismiss()
    }
    func AddUserFunc() -> Void{
        APIRequest().Post(withParameters: ["action":"add-user","email":email,"password":password,"displayname":display,"phone":phone,"permissions":"storeadmin","session":account.SessionToken])
        {data in
            DispatchQueue.main.async {
                print("------------")
                print(data)
                print("------------")
                if(data != "nosession" && data != "")
                {
                    //load account
//                    let jsonData = data.data(using: .utf8)!
//                    let test: SearchedAccount = try! JSONDecoder().decode(SearchedAccount.self, from: jsonData)
//                    account.CardUId = cardId
                    
                }
                else
                {
                    //add card to store
                }
            }
        }
    }
}
struct AddUser_Preview: PreviewProvider {
    static var previews: some View {
        var account = Account()//just for preview
        AddUser().environmentObject(account)
    }
}
