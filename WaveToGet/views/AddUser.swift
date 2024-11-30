//
//  AddUser.swift
//  wavetoget
//
//  Created by Jesse Lugassy on 2021-02-04.
//

import SwiftUI

struct AddUser: View {
    @EnvironmentObject var account:Account
    @EnvironmentObject var custAccount:CustomerAccount
    @EnvironmentObject var storeAccount:StoreAccount
    @EnvironmentObject var sizing:Sizing
    @State private var password = ""
    @State private var repassword = ""
    @State private var email = ""
    @State private var firstname = ""
    @State private var lastname = ""
    @State private var displayname = ""
    @State private var phone = ""
    @State private var streetAddress = ""
    @State private var city = ""
    @State private var province = ""
    @State private var zipcode = ""
    @State private var errorText = ""
    @State private var store = ""
    @State var agree:Bool = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var search = false
    var body: some View
    {
        VStack
        {
            Text("Add store owner credentials")
                .font(.title2)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
            ZStack
            {
//                RoundedRectangle(cornerRadius: 2).stroke(Color.MyGrey, lineWidth: 2)
                VStack(alignment: .leading, spacing:0)
                {
                    Spacer()
                    Text(errorText)
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundColor(.red)
                    HStack(alignment: .top)
                    {
                        VStack(alignment: .leading)
                        {
                            Group{
                            Text(account.isCust ? "Display Name:" : "Business Name:")
                            Text("Email:")
                            Text("Password:")
                            Text("First Name:")
                            Text("Last Name:")
                            Text("Phone:")
                            Text("Address:")
                            }
                            .padding(.vertical, 13)
                            .font(.system(size: 15))
                        }
                        .padding(.leading, 10)
                        .foregroundColor(.MyBlue)
                        VStack
                        {
                            TextField(account.isCust ? "Enter your Display name..." : "Enter your business name...", text: $displayname)
                                .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.vertical, 5)
                                .disableAutocorrection(true)
                                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                            TextField("Enter your email...", text: $email)
                                .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.vertical, 5)
                                .disableAutocorrection(true)
                                .keyboardType(.emailAddress)
                                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                            HStack
                            {
                                SecureField("Enter password", text: $password)
                                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding(.vertical, 5)
                                SecureField("Re-enter password", text: $repassword)
                                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding(.vertical, 5)
                            }
                            TextField("Enter first name...", text: $firstname)
                                .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.vertical, 5)
                                .disableAutocorrection(true)
                                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                            TextField("Enter last name...", text: $lastname)
                                .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.vertical, 5)
                                .disableAutocorrection(true)
                                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                            TextField("Enter phone number...", text: $phone)
                                .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.vertical, 5)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                            TextField("Street address...", text: $streetAddress)
                                .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.vertical, 5)
                                .disableAutocorrection(true)
                                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                            TextField("City...", text: $city)
                                .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.vertical, 5)
                                .disableAutocorrection(true)
                                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                            HStack
                            {
                            TextField("State/Province...", text: $province)
                                .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.vertical, 5)
                                .disableAutocorrection(true)
                                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                TextField("Zip/Postal...", text: $zipcode)
                                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding(.vertical, 5)
                                    .disableAutocorrection(true)
                                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                            }
                            TextField("Store number...", text: $store)
                                .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.vertical, 5)
                                .disableAutocorrection(true)
                                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                        }
                        .font(Font.system(size: 13, design: .default))
                        .padding(.trailing, 10)
                    }
                    Spacer()
                    HStack
                    {
                        Button(action:{agree = !agree}) {
                            ZStack{
                                Rectangle()
                                    .fill(Color.MyGrey)
                                    .frame(width:24, height:24)
                                    .cornerRadius(sizing.mediumCornerRadius)
                                Rectangle()
                                    .fill(agree ? Color.MyBlue : Color.white)
                                    .frame(width:20, height:20)
                                    .cornerRadius(sizing.mediumCornerRadius)
                            }
                            
                        }
                        .padding(.leading)
                        Group {Text("I agree with the ") + Text("Terms & Conditions?").bold()}
                            .padding(.vertical, 20)
                            .foregroundColor(.MyBlue)
                        
                    }
                    Button(action: {AddUserFunc()}, label: {
                        ZStack
                        {
                            RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                .padding()
                                .foregroundColor(.MyBlue)
                                .frame(height: 80)
                            
                            Text("REGISTER")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .font(.system(size: 20))
                        }
                    })
                }
            }
        }
        .padding(.horizontal,10)
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
    func Back() -> Void{
        self.presentationMode.wrappedValue.dismiss()
    }
    func AddUserFunc() -> Void{
        if(!agree)
        {
            errorText = "You must agree to the Terms & Conditions..."
            return
        }
        else if(password == "" || repassword == "" || email == "" || displayname == "" || password == "" || phone == "" || streetAddress == "" || city == "" || province == "" || zipcode == "" || firstname == "" || lastname == "")
        {
            errorText = "You must fill all fields..."
            return
        }
        else if(password != repassword)
        {
            errorText = "Password fields don't match..."
            return
        }
        var usertype = account.isCust ? "1" : "2"
        var _store = ""
        if(usertype == "1")
        {
            if(store == "")
            {
                errorText = "You must fill all fields..."
                return
            }
            _store = store
        }
        APIRequest().Post(withParameters: ["action":"add-user","store":store,"user_type":usertype,"email":email,"password":password,"displayname":displayname,"firstname":firstname,"lastname":lastname,"address":streetAddress,"city":city,"province":province,"postal":zipcode,"phone":phone,"businessname":displayname,"pin":"0000","session":account.SessionToken])
        {data in
            DispatchQueue.main.async {
                print("------------")
                print(data)
                print("------------")
                if(data != "")
                {
                    Back()
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
        var custAcc = CustomerAccount()
        var storeAcc = StoreAccount()
        var account = Account()//just for preview
        AddUser()
            .environmentObject(account)
            .environmentObject(storeAcc)
            .environmentObject(custAcc)
    }
}
