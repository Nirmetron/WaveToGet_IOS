

import SwiftUI

struct ResetPassword: View {
    @EnvironmentObject var account:Account
    @EnvironmentObject var custAccount:CustomerAccount
    @EnvironmentObject var storeAccount:StoreAccount
    @EnvironmentObject var sizing:Sizing
    @State private var email = ""
    @State private var errorText = ""
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var alert = false
    @State private var alerttext = ""
    @State var emailChange = false
    @State private var accountList: [acc] = []
    @State private var selectedAccount: acc = acc()
    var body: some View
    {
        VStack(spacing: 0)
        {
            ZStack
            {
            Button(action: {self.presentationMode.wrappedValue.dismiss()}, label: {
                ZStack
                {
                    Image("back6")
                        .resizable()
                        .frame(width: 35.0, height: 35.0)
                        .scaledToFit()
                        .frame(alignment: .top)
                        .colorMultiply(.MyBlue)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            })
            Text("PASSWORD RESET")
                .font(.system(size: 17))
                .padding(.top, 5.0)
            }
            ZStack
            {
                VStack(alignment: .leading, spacing:0)
                {
                    Text(errorText)
                        .padding(.vertical, 5)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundColor(.red)
                        .font(.system(size: sizing.smallTextSize))
                    Spacer()
                    Text("Enter the email and select the store associated with the account.")
                        .font(.system(size: 15))
                        .padding(.vertical, 10)
                        .foregroundColor(.MyBlue)
                        .frame(maxWidth:.infinity, alignment: .center)
                    Spacer()
                    HStack(alignment: .top)
                    {
                        VStack
                        {
                            
                                TextField("Email", text: $email, onEditingChanged: { (editingChanged) in
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
                                    .padding(.vertical, 5)
                                    .disableAutocorrection(true)
                                    .keyboardType(.emailAddress)
                                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                Menu {
                                    ForEach(0..<accountList.count, id: \.self)
                                    { i in
                                        Button { selectedAccount = accountList[i]
                                        } label: {
                                            Text((accountList[i].store_displayname ?? "") + " - " + (accountList[i].typename ?? ""))
                                        }
                                    }
                                } label: {
                                    Text((selectedAccount.store_displayname ?? "") == "" ? "No store selected" : (selectedAccount.store_displayname ?? "") + " - " + (selectedAccount.typename ?? ""))
                                }
                                .padding([.top, .leading], 20.0)
                                .foregroundColor(Color.LoginLinks)
                                .frame(maxWidth:.infinity, alignment: .leading)
                        }
                    }
                    .frame(maxWidth:.infinity, alignment: .center)
                    Spacer()
                    Spacer()
                    HStack(spacing: 0)
                    {
                        Button(action: {Reset()}, label: {
                            ZStack
                            {
                                RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                    .foregroundColor(.MyBlue)
                                    .frame(height: 60)
                                
                                Text("RESET PASSWORD")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .font(.system(size: 20))
                            }
                        })
                        .padding([.leading, .bottom])
                        .padding(.trailing, 5.0)
                    }
                    .alert(isPresented: $alert) {

                        Alert(
                            title: Text(alerttext),
                            dismissButton: .default(Text("OK"), action: {
                                self.presentationMode.wrappedValue.dismiss()
                            })
                        )
                    }.padding()
                }
            }
        }
        .padding(.all,10)
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
    func Reset() -> Void{
        if(email == "")
        {
            errorText = "Please fill in the email field"
            return
        }
        if(selectedAccount.store == 0)
        {
            errorText = "Please Select a store"
            return
        }
        if(!isValidEmail(email))
        {
            errorText = "Please enter a valid email address..."
            return
        }
        errorText = ""
        APIRequest().Post(withParameters: ["email":email,"store":String(selectedAccount.store ?? 0)],_url: AuthAPI.REST_PASSWORD)
        {data in
            DispatchQueue.main.async {
                print("------------")
                print(data)
                print("------------")
                alerttext = "An email to reset your password will be sent to you shortly.  Thank you for your patience."
                alert = true
            }
        }
    }
    struct acc: Decodable {
        var store: Int?
        var usertype: Int?
        var store_displayname: String?
        var typename: String?
    }
    func isValidEmail(_ string: String) -> Bool {
        if string.count > 100 {
            return false
        }
        let emailFormat = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" + "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" + "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        //let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: string)
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
}


