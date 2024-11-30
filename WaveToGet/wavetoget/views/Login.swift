//
//  Login.swift
//  wavetoget
//
//  Created by Jesse Lugassy on 2021-01-15.
//
import SwiftKeychainWrapper
import SwiftUI

struct Login: View {
    @State private var password = ""
    @State private var email = ""
    @State var loggedIn = false
    @State var attemptingLogin = false
    @State var save:Bool = false
    @EnvironmentObject var account:Account
    var body: some View {
        ZStack
        {
            RoundedRectangle(cornerRadius: 2).stroke(Color.MyGrey, lineWidth: 2)
            VStack(alignment: .leading)
            {
//                ZStack{
//                    NavigationLink(destination: LoginSettings()) {Image("gear")
//                        .resizable()
//                        .scaledToFit()
//                        .colorMultiply(.MyBlue)
//                        .frame(width: 40.0, height: 40.0)}
//                    .padding(.trailing, 20)
//                    .frame(maxWidth: .infinity, alignment: .trailing)
//                Text("Log in")
//                    .font(.largeTitle)
//                    .padding(.top,40)
//                    .frame(maxWidth: .infinity, alignment: .center)
//                }
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
                NavigationLink(destination: RegisterAccount()) {
                Text("Create account")
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    .padding(.leading, 20)
                    .padding(.vertical, 20)
                }
                Spacer()
                HStack
                {
                    Text("Save Credentials?")
                        .padding(.leading, 20)
                        .padding(.vertical, 20)
                    Button(action:{SetBoolSaveCreds()}) {
                        ZStack{
                            Rectangle()
                                .fill(Color.MyBlue)
                                .frame(width:24, height:24)
                                .cornerRadius(5)
                            Rectangle()
                                .fill(save ? Color.MyBlue : Color.white)
                                .frame(width:20, height:20)
                                .cornerRadius(5)
                        }
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing, 20)
                    
                }
                ZStack
                {
                    Text("")
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 83, maxHeight: 83)
                        .background(RoundedCorners(color: .MyGrey, tl: 0, tr: 0, bl: 2, br: 10))
                    HStack(spacing: 1.0)
                    {
//                        Button(action: {ClearFunc()}, label: {
//                                Text("Clear")
//                                    .foregroundColor(.white)
//                                    .font(.largeTitle)
//                                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 80, maxHeight: 80)
//                                    .background(RoundedCorners(color: .MyBlue, tl: 0, tr: 0, bl: 2, br: 0))})
                        NavigationLink(destination: SearchCard(), isActive: $loggedIn) {
                            Button(action: {
                                LoginFunc()
                            })
                            {
                                Text("Login")
                                    .foregroundColor(.white)
                                    .font(.largeTitle)
                                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 80, maxHeight: 80)
                                    .background(RoundedCorners(color: .MyBlue, tl: 0, tr: 0, bl: 2, br: 2))
                            }
                        }
                    }
                }
            }
        }
        .padding(.horizontal,25)
        .onAppear(perform: {LoadSavedCredentials()})
    }
    func SetBoolSaveCreds()
    {
        save = !save
        KeychainWrapper.standard.set(save, forKey: "save")
        print("State : \(save)")
        if(!save)
        {
            KeychainWrapper.standard.set("", forKey: "email")
            KeychainWrapper.standard.set("", forKey: "password")
        }
    }
    func LoadSavedCredentials()
    {
        save = KeychainWrapper.standard.bool(forKey: "save") ?? false
        if(save)
        {
            email = KeychainWrapper.standard.string(forKey: "email") ?? ""
            password = KeychainWrapper.standard.string(forKey: "password") ?? ""
        }
    }
    func SaveCredentials()
    {
        if(save)
        {
            KeychainWrapper.standard.set(email, forKey: "email")
            KeychainWrapper.standard.set(password, forKey: "password")
        }
    }
    func ClearFunc() -> Void{
        email = "";
        password = "";
    }
    func Settings() -> Void{
        //scene = 3
    }
    func LoginFunc() -> Void{
        SaveCredentials()
        attemptingLogin = true
        
        APIRequest().Post(withParameters: ["action":"login","email":email,"password":password])
        {data in
            print(data)
            DispatchQueue.main.async {
                if(data != "nosession" && data != "")
                {
                    account.SessionToken = data
                    GetAccType()
                }
                else
                {
                    loggedIn = false
                }
                attemptingLogin = false
            }
        }
    }
    func GetAccType() -> Void{
        APIRequest().Post(withParameters: ["action":"get-user","session":account.SessionToken])
        {data in
            print(data)
            DispatchQueue.main.async {
                if(data != "nosession" && data != "")
                {
                    let jsonData = data.data(using: .utf8)!
                    let test: accType = try! JSONDecoder().decode(accType.self, from: jsonData)
                    
                    account.AccountType = test.type ?? ""
                    account.id = test.id ?? 0
                    account.isCust = account.AccountType == "cardholder" ? true : true
                    loggedIn = true
                    attemptingLogin = false
                }
            }
        }
    }
}
struct accType: Decodable {
    var id: Int?
    var displayname: String?
    var lastactive: String?
    var type: String?
    
}
//func getDestination(isStore:Bool) -> AnyView {
//    if isStore {
//        return AnyView(SearchCard())
//    } else {
//        return AnyView(CustomerView())
//    }
//}
//Button(action: {scene = LoginFunc()}, label: {
//    MyButton(name: "Login", color: .MyBlue)
//})
//Button(action: {scene = LoginFunc()}, label: {
//    MyButton(name: "Login", color: .MyBlue)
//})
struct Login_Preview: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
