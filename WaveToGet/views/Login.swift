//
//  Login.swift
//  wavetoget
//
//  Created by Jesse Lugassy on 2021-01-15.
//
import SwiftKeychainWrapper
import SwiftUI
import SafariServices
import XCTest

struct Login: View {
    @State var showSafari = false
    @State var urlString = "https://www.referralandrewards.com/locations/"
    @State private var password = ""
    @State private var email = ""
    @State var loggedIn = false
    @State var createacc = false
    @State var attemptingLogin = false
    @State var save:Bool = false
    @State var emailChange = false
    @State private var errorText = ""
    @State private var accountList: [acc] = []
    @State private var selectedAccount: acc = acc()
    @State private var showingInfoPage = false
     private var isPortrait : Bool { UIDevice.current.orientation.isPortrait }
    @State var orientationChanged = NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)
        .makeConnectable()
        .autoconnect()
    @State var orientation = UIDevice.current.orientation
    @EnvironmentObject var account:Account
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var selectedLanguage = ""
    let defaultLocalizer = AMPLocalizeUtils.defaultLocalizer
    
//    let emailLocalizedText: LocalizedStringKey = "Email"
    let emailLocalizedText = "Email"
//    let passwordLocalizedText: LocalizedStringKey = "Password"
    let passwordLocalizedText = "Password"
//    let createAccountLocalizedText: LocalizedStringKey = "Create account"
    let createAccountLocalizedText = "Create account"
//    let forgotPasswordLocalizedText: LocalizedStringKey = "Reset Password"
    let forgotPasswordLocalizedText = "Reset Password"
    let saveCredentialsLocalizedText = "Save Credentials"
    let loginLocalizedText = "Login"
    
    var body: some View {
        VStack
        {
            
            HStack {
                
                Spacer()
                
                Text("REFERRAL AND REWARDS")
                    .foregroundColor(.MyBlue)
                    .font(.system(size: 18))
                    .fontWeight(.semibold)
                
                Spacer()
                
            } //: HStack
            .padding()
            
            ZStack
            {
                ScrollView {
                    
                    Spacer()
                    
                    HStack {
                        
                        Spacer()
                        
                        VStack(alignment: .leading, spacing:0)
                        {
                            
                            Spacer()
                            
                            
                            Text(errorText)
                                .textInputFont()
                                .padding(.vertical, 10)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .foregroundColor(.red)
                            
                            TextField(defaultLocalizer.stringForKey(key: emailLocalizedText), text: $email, onEditingChanged: { (editingChanged) in
                                if editingChanged {
                                    emailChange = true
                                } else {
                                    emailChange = false
                                    GetAccStore()
                                }
                            })
                            .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                            .padding(.horizontal, 20)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .font(.system(size: 15))
                            .padding(.vertical, 5)
                            .disableAutocorrection(true)
                            .keyboardType(.emailAddress)
                            .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                            .onAppear(perform: {GetAccStore()})
                            SecureField(defaultLocalizer.stringForKey(key: passwordLocalizedText), text: $password)
                                .font(.system(size: 15))
                                .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                                .padding(.horizontal, 20)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.vertical, 5)
                                .keyboardType(.twitter)
                            
                            Menu {
                                ForEach(0 ..< accountList.count, id: \.self) { i in
                                    Button {
                                        selectedAccount = accountList[i]
                                    } label: {
                                        Text((accountList[i].store_displayname ?? "") + " - " + (accountList[i].typename ?? ""))
                                            .font(.system(size: 15))
                                    }
                                    
                                }
                            }
                        label: {
                            Text((selectedAccount.store_displayname ?? "") == "" ? "Enter your email and password..." : (selectedAccount.store_displayname ?? "") + " - " + (selectedAccount.typename ?? ""))
                                .font(.system(size: 15))
                        }
                        .padding(5)
                        .border(Color.LoginLinks)
                        .padding([.top, .leading], 20)
                        .foregroundColor(Color.LoginLinks)
                            
                            HStack(alignment: .center) {
                                
                                Menu {
                                    Button("French") {
                                        defaultLocalizer.setSelectedLanguage(lang: "fr")
                                        selectedLanguage = "French"
                                    }
                                    Button("Spanish") {
                                        defaultLocalizer.setSelectedLanguage(lang: "es")
                                        selectedLanguage = "Spanish"
                                    }
                                    Button("English") {
                                        defaultLocalizer.setSelectedLanguage(lang: "en")
                                        selectedLanguage = "English"
                                    }
                                } label: {
                                    if selectedLanguage == "", let languageName = Locale(identifier: Locale.preferredLanguages[0]).localizedString(forLanguageCode: Locale.preferredLanguages[0]) {
                                        Text("\(languageName)")
                                            .textInputFont()
                                    }
                                    else {
                                        Text(selectedLanguage == "" ? "Language:" : "\(selectedLanguage)")
                                            .textInputFont()
                                    }
                                    
                                }
                            } //: HStack
                            .padding()
                            
                            Spacer()
                            
                            VStack(alignment: .leading, spacing: 10)
                            {
                                
                                NavigationLink(destination: CreateAccountBridge()) {
                                    Text(defaultLocalizer.stringForKey(key: createAccountLocalizedText))
                                        .textInputFont()
                                        .foregroundColor(Color.LoginLinks)
                                }
                                //Spacer()
                                NavigationLink(destination: ResetPassword()) {
                                    Text(defaultLocalizer.stringForKey(key: forgotPasswordLocalizedText))
                                        .textInputFont()
                                        .foregroundColor(Color.LoginLinks)
                                }
                            }
                            .padding(.vertical, 10)
                            .padding(.leading, 20)
                            // summon the Safari sheet
                            //                .sheet(isPresented: $showSafari) {
                            //                    SafariView(url:URL(string: self.urlString)!)
                            //                }
                            HStack
                            {
                                Button(action:{SetBoolSaveCreds()}) {
                                    ZStack{
                                        Rectangle()
                                            .fill(save ? Color.MyBlue : Color.MyGrey)
                                            .frame(width:24, height:24)
                                            .cornerRadius(5)
                                        Rectangle()
                                            .fill(save ? Color.MyBlue : Color.white)
                                            .frame(width:20, height:20)
                                            .cornerRadius(5)
                                    }
                                }
                                .padding(.leading)
                                Text("\(defaultLocalizer.stringForKey(key: saveCredentialsLocalizedText))?")
                                    .textInputFont()
                                    .padding(.vertical, 20)
                                    .foregroundColor(Color.LoginLinks)
                                
                            }
                            NavigationLink(destination: SearchCard(), isActive: $loggedIn) {
                                Button(action: {
                                    LoginFunc()
                                })
                                {
                                    ZStack
                                    {
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color.MyBlue, lineWidth: 2)
                                            .padding()
                                            .foregroundColor(.MyBlue)
                                            .frame(height: 80)
                                        
                                        Text(defaultLocalizer.stringForKey(key: loginLocalizedText))
                                            .fontWeight(.semibold)
                                            .foregroundColor(Color.MyBlue)
                                            .font(.system(size: 20))
                                    }
                                }
                            }
                            
                        } //: VStack
                        
                        Spacer()
                        
                    } //: HStack
                } //: Scrollview
            } //: ZStack
            .padding(.vertical, orientation.isLandscape ? UIScreen.main.bounds.width/30 : UIScreen.main.bounds.height/25)
            .padding(.horizontal, orientation.isLandscape ? UIScreen.main.bounds.height/3 : UIScreen.main.bounds.width/15)
            .onAppear(perform: {self.account.loadedAcc = false})
            .onAppear(perform: {LoadSavedCredentials()})
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .onReceive(orientationChanged) { _ in
                self.orientation = UIDevice.current.orientation
                if(orientation.isLandscape)
                {
                    account.Landscape = true
                }
                else
                {
                    account.Landscape = false
                }

            }
            
            Spacer()
            
        } //: VStack
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .onAppear(perform: {
            self.orientation = UIDevice.current.orientation
            if(orientation.isLandscape)
            {
                account.Landscape = true
            }
            else
            {
                account.Landscape = false
            }
            
            // Check for updates
//            CheckUpdate.shared.showUpdate(withConfirmation: false)
        })
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
            GetAccStore()
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
    func GetAccStore() -> Void{
        var change = emailChange
        if(email != "")
        {
            APIRequest().Post(withParameters: ["email":email],_url: AuthAPI.ACCOUNT_CHECK)
            {data in
                DispatchQueue.main.async {
                    if(data != "false" && data != "" && data != "nosession" && data != "[]")
                    {
                        let jsonData = data.data(using: .utf8)!
                        let test: [acc] = try! JSONDecoder().decode([acc].self, from: jsonData)
                        //print(test)
                        accountList = test
                        if(accountList.count > 0)
                        {
                            selectedAccount = accountList[0]
                        }
                        errorText = ""
                        //                        for accs in accountList {
                        //                            print(accs.store_displayname)
                        //                        }
                        if(change)
                        {
                            emailChange = false
                            LoginFunc()
                        }
                    }
                    else
                    {
                        errorText = "Can't find any accounts associated with this email..."
                        accountList.removeAll()
                        selectedAccount = acc()
                    }
                }
            }
        }
        else
        {
//            accountList.removeAll()
//            selectedAccount = acc()
        }
    }
    struct acc: Decodable {
        var store: Int?
        var usertype: Int?
        var store_displayname: String?
        var typename: String?
    }
    func LoginFunc() -> Void{
        if(emailChange)
        {
            GetAccStore()
            return
        }
        //print("2222222222222222222222222222222222222")
        SaveCredentials()
        attemptingLogin = true
        if(email != "" && password != "" && selectedAccount.store != 0)
        {
            APIRequest().Post(withParameters: ["action":"login","email":email,"password":password, "store": String(selectedAccount.store ?? 0)])
            {data in
                print("DEBUG: data in Login.LoginFunc is \(data)")
                DispatchQueue.main.async {
                    if(data != "nosession" && data != "")
                    {
                        //                    let jsonData = data.data(using: .utf8)!
                        //                    let login: session = try! JSONDecoder().decode(session.self, from: jsonData)
                        //                    account.id = login.userId
                        //                    account.SessionToken = login.token
                        account.SessionToken = data
                        GetAccType()
                        errorText = ""
                    }
                    else
                    {
                        errorText = "Incorrect password..."
                        loggedIn = false
                    }
                    attemptingLogin = false
                }
            }
        }
        else
        {
            errorText = "Please fill in both fields..."
        }
    }
    struct session: Decodable {
        var token: String
        var userId: Int
    }
    func Back() -> Void{
        self.presentationMode.wrappedValue.dismiss()
    }
    func GetAccType() -> Void{
        APIRequest().Post(withParameters: ["action":"get-user","session":account.SessionToken])
        {data in
            print("DEBUG: data in Login.GetAccType is \(data)")
            DispatchQueue.main.async {
                if(data != "false" && data != "" && data != "nosession")
                {
                    let jsonData = data.data(using: .utf8)!
                    let test: accType = try! JSONDecoder().decode(accType.self, from: jsonData)
//                    if(account.isCust != (test.type == "cardholder"))
//                    {
//                        attemptingLogin = false
//                        loggedIn = false
//                        errorText = "Wrong account type..."
//                        return
//                    }
                    account.isCust = test.type == "cardholder" ? true : false
                    account.Username = test.displayname ?? ""
                    account.AccountType = test.type ?? ""
                    account.id = test.id ?? 0
                    account.store = test.store ?? 0
                    account.Email = email
                    
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
    var store: Int?
}

//struct PopoverContent: View {
//
//    @Binding var presentMe : Bool
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 20) {
//
//            HStack {
//
//                Text("Login")
//                    .font(.title2)
//                    .fontWeight(.bold)
//                    .multilineTextAlignment(.leading)
//                    .padding([.top, .leading])
//
//                Spacer ()
//
//                // This should be the button to return to the main screen that NOW IT'S FINALLY working
//                Button  (action: {
//
//                    // Change the value of the Binding
//                    presentMe = false
//
//                }, label: {
//                    Image(systemName: "xmark.circle")
//                        .foregroundColor(Color.gray)
//                })
//                .padding([.top, .trailing])
//            }
//
//            Divider()
//                .padding(.horizontal)
//                .frame(height: 3.0)
//                .foregroundColor(Color.gray)
//
//            Spacer()
//
//            HStack {
//                Spacer()
//
//                Image("infoButtonImage-blue")
//                    .resizable()
////                    .renderingMode(.template)
//                    .scaledToFit()
////                    .foregroundColor(.blue)
//                    .frame(width: 50, height: 50, alignment: .center)
//
//                Spacer()
//            }
//
//            //            Text("Account registration (main reg. Page)")
//            //                .font(.title3)
//            //                .fontWeight(.semibold)
//            //                .padding(.vertical, 20)
//
//            Text("- To log in enter your email address and password, then click “LOGIN” button.\n\n- If you don’t have account yet, create new account click 'create account button'\n\n- If you forgot your password, click 'reset password'")
//                .font(.body)
//                .padding(.vertical, 20)
//
//            Text("You can create multiple accounts for different stores with the same email address and password. To choose a store click the blue 'Name of the store-Cardholder' button below the password and select the one you need.")
//                .font(.body)
//                .padding(.vertical, 20)
//
//            Spacer()
//        }
//        .padding()
//    }
//}

//struct Login_Preview: PreviewProvider {
//    static var previews: some View {
//        var acc = Account()
//        Login().environmentObject(acc)
//    }
//}
struct SafariView: UIViewControllerRepresentable {

    let url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {

    }

}
