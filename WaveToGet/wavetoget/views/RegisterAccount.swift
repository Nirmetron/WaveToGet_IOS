//
//  RegisterAccount.swift
//  wavetoget
//
//  Created by Jesse Lugassy on 2021-01-28.
//

import SwiftUI

struct RegisterAccount: View {
    //@EnvironmentObject var account:Account
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var password = ""
    @State private var email = ""
    @State private var verify = ""
    @State private var display = ""
    @State private var phone = ""
    @State private var errorText = ""
    @State var success = false
    var body: some View {
        ZStack
        {
            RoundedRectangle(cornerRadius: 2).stroke(Color.MyGrey, lineWidth: 2)
            VStack(alignment: .leading)
            {
                VStack(alignment: .leading)
                {
                    Text("Register")
                        .font(.largeTitle)
                        .padding(.top,40)
                        .frame(maxWidth: .infinity, alignment: .center)
                    Spacer()
                    Text("Please enter your credentials")
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity, alignment: .center)
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
                    SecureField("Verify password", text: $verify)
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
                        .autocapitalization(.none)
                    TextField("Phone number", text: $phone)
                        .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.black, lineWidth: 1))
                        .padding(.horizontal, 20)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.vertical, 5)
                        .disableAutocorrection(true)
                        .keyboardType(.emailAddress)
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    Text(errorText)
                        .foregroundColor(.red)
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity, alignment: .center)
                    Spacer()
                }
                Button(action: {RegisterFunc()}, label: {
                    Text("Sign up")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 80, maxHeight: 80)
                        .background(RoundedCorners(color: .MyBlue, tl: 0, tr: 0, bl: 2, br: 2))})
            }
        }
        .padding(.horizontal,25)
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
    func RegisterFunc() -> Void{
        if(email != "" && password != "" && display != "" && phone != "")
        {
            APIRequest().Post(withParameters: ["action":"add-user","email":email,"password":password,"displayname":display,"phone":phone,"permissions":"1"])
            {data in
                print(data)
                DispatchQueue.main.async {
                    if(data != "nosession" && data != "")
                    {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    else
                    {
                        errorText = "fail"
                    }
                }
            }
        }
        else
        {
            errorText = "Please fill in all fields."
        }
    }
}
struct RegisterAccount_Preview: PreviewProvider {
    static var previews: some View {
        RegisterAccount()
    }
}
