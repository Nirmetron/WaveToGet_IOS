//
//  CreateCustomerAccount.swift
//  wavetoget
//
//  Created by Jesse Lugassy on 2021-10-08.
//

import SwiftUI
import Combine

struct CreateCustomerAccount: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var account:Account
    @EnvironmentObject var custAccount:CustomerAccount
    @EnvironmentObject var storeAccount:StoreAccount
    @EnvironmentObject var sizing:Sizing
    @State private var password = ""
    @State private var repassword = ""
    @State private var email = ""
    @State private var firstname = ""
    @State private var lastname = ""
    @State private var phone = ""
    @State private var streetAddress = ""
    @State private var city = ""
    @State private var zipcode = ""
    @State private var errorText = ""
    
    @State private var refferalerrorText = ""
    @State private var refferalpersonfound = false
    
    @State private var alerttext = ""
    @State private var error = false
    @State private var store = ""
    @State private var referral = ""
    @State private var referralphone = ""
    @State private var referralsuccuess = false
    
    @State private var refid = ""
    
    @State private var referralchange = false
    @Binding public var page:Int
    @State private var accountList: [acc] = []
//    @State private var selectedAccount: acc = acc()
    
    var selectedAccountFromSearch: acc
    
    @State private var SelectedProvince: Int = 0
    
    @State private var loading = false
//    @State private var showingInfoPage = false
    
    let textLimit = 10
        
    var body: some View
    {
        ScrollView {
            VStack(spacing: 0)
            {
                ZStack
                {
                    Button(action: { Back() }, label: {
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
                    HStack {
                        
    //                    Spacer()
                        
                        Text("CREATE CUSTOMER ACCOUNT")
                            .font(.system(size: 17))
                            .padding(.top, 5.0)
                                            
                        // Help Button
    //                    Button {
    //                        showingInfoPage = true
    //                    } label: {
    //                        Image("infoButtonImage-blue")
    //                            .resizable()
    //                            .scaledToFit()
    //                            .frame(width: 30, height: 30)
    //                            .padding()
    //                    }
                    } //: HStack
    //                .popover(isPresented: $showingInfoPage, arrowEdge: .bottom) {
    //                    CreateCustomerAccountPopoverContent(presentMe: $showingInfoPage)
    //                }
                
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
                      
                        
                        VStack
                        {
                            
                            HStack
                            {
                                Text("Store:")
                                    .foregroundColor(.MyBlue)
                                    .frame(width: account.Ipad ? sizing.ipadHorizontalInputForForm : sizing.horizontalInputForForm,alignment: .leading)
                                    .font(.system(size: 17))
                                
                                Text(selectedAccountFromSearch.name ?? "")
                                    .font(.system(size: 15))
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                            }
                            HStack
                            {
                                Text("Email:")
                                    .foregroundColor(.MyBlue)
                                    .frame(width: account.Ipad ? sizing.ipadHorizontalInputForForm : sizing.horizontalInputForForm, alignment: .leading)
                                    .font(.system(size: 17))
                                TextField("Email:", text: $email)
                                    .font(.system(size: 15))
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                                    .disableAutocorrection(true)
                                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                
                            }
                            HStack
                            {
                                Text("Password:")
                                    .foregroundColor(.MyBlue)
                                    .frame(width: account.Ipad ? sizing.ipadHorizontalInputForForm : sizing.horizontalInputForForm,alignment: .leading)
                                    .font(.system(size: 17))
                                HStack
                                {
                                    SecureField("Enter new password", text: $password)
                                        .font(.system(size: 15))
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                                        .disableAutocorrection(true)
                                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                    SecureField("Re-enter password", text: $repassword)
                                        .font(.system(size: 15))
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                                        .disableAutocorrection(true)
                                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                }
                                
                            }
                            HStack
                            {
                                Text("First Name:")
                                    .foregroundColor(.MyBlue)
                                    .frame(width: account.Ipad ? sizing.ipadHorizontalInputForForm : sizing.horizontalInputForForm,alignment: .leading)
                                    .font(.system(size: 17))
                                TextField("First Name:", text: $firstname)
                                    .font(.system(size: 15))
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                                    .disableAutocorrection(true)
                                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                
                            }
                            HStack
                            {
                                Text("Last Name:")
                                    .foregroundColor(.MyBlue)
                                    .frame(width: account.Ipad ? sizing.ipadHorizontalInputForForm : sizing.horizontalInputForForm,alignment: .leading)
                                    .font(.system(size: 17))
                                TextField("Last Name:", text: $lastname)
                                    .font(.system(size: 15))
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                                    .disableAutocorrection(true)
                                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                
                            }
                            HStack
                            {
                                Text("Phone:")
                                    .foregroundColor(.MyBlue)
                                    .frame(width: account.Ipad ? sizing.ipadHorizontalInputForForm : sizing.horizontalInputForForm,alignment: .leading)
                                    .font(.system(size: 17))
                                TextField("4161234567", text: $phone, onEditingChanged: { (editingChanged) in
                                    if editingChanged {
                                    } else {
                                        FindReferral()
                                    }
                                })
                                .onReceive(Just(referralphone), perform: { _ in
                                    limitText(limit: textLimit, value: &phone)
                                })
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                                .keyboardType(.numberPad)
                                .font(.system(size: 15))
                                
                            }
                            HStack
                            {
                                Text("Address:")
                                    .foregroundColor(.MyBlue)
                                    .frame(width: account.Ipad ? sizing.ipadHorizontalInputForForm : sizing.horizontalInputForForm,alignment: .leading)
                                    .font(.system(size: 17))
                                TextField("Address:", text: $streetAddress)
                                    .font(.system(size: 15))
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                                    .disableAutocorrection(true)
                                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                
                            }
                            HStack
                            {
                                Text("City:")
                                    .foregroundColor(.MyBlue)
                                    .frame(width: account.Ipad ? sizing.ipadHorizontalInputForForm : sizing.horizontalInputForForm,alignment: .leading)
                                    .font(.system(size: 17))
                                TextField("City:", text: $city)
                                    .font(.system(size: 15))
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                                    .disableAutocorrection(true)
                                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                
                            }
                            HStack
                            {
                                Text("Province/State:")
                                    .foregroundColor(.MyBlue)
                                    .frame(width: account.Ipad ? sizing.ipadHorizontalInputForForm : sizing.horizontalInputForForm,alignment: .leading)
                                    .font(.system(size: 17))
                                
                                Menu {
                                    ForEach(0..<account.ProvinceList.count, id: \.self)
                                    { i in
                                        Button { SelectedProvince = i + 1
                                            print(SelectedProvince)
                                        } label: {
                                            Text((account.ProvinceList[i]))
                                                .font(.system(size: 15))
                                        }
                                    }
                                } label: {
                                    Text(SelectedProvince == 0 ? "Select a Province/State" : (account.ProvinceList[SelectedProvince - 1] ?? ""))
                                        .frame(maxWidth:.infinity,alignment: .leading)
                                        .font(.system(size: 15))
                                }
                                .foregroundColor(Color.LoginLinks)
                            }
                            .font(.system(size: 15))
                            
                            HStack
                            {
                                Text("Postal Code:")
                                    .foregroundColor(.MyBlue)
                                    .frame(width: account.Ipad ? sizing.ipadHorizontalInputForForm : sizing.horizontalInputForForm,alignment: .leading)
                                    .font(.system(size: 17))
                                TextField("Postal Code:", text: $zipcode)
                                    .font(.system(size: 15))
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                
                            }
                            //}
                        }
                        .padding(.horizontal, 10)
                        .padding(.top, sizing.verticalFormSpacing)
                        .font(.system(size: sizing.smallTextSize))
                        
                        HStack
                        {
                            Text("Referral:")
                                .foregroundColor(.MyBlue)
                                .frame(width: account.Ipad ? sizing.ipadHorizontalInputForForm : sizing.horizontalInputForForm,alignment: .leading)
                                .font(.system(size: 17))
                            Text(referral)
                                .foregroundColor(Color.LoginLinks)
                                .font(.system(size: 15))
                        }
                        .padding(.horizontal, 10)
                        .padding(.top, sizing.verticalFormSpacing)
                        .font(.system(size: sizing.smallTextSize))
                        if(referralsuccuess)
                        {
                            HStack
                            {
                                Text("Referral Phone:")
                                    .foregroundColor(.MyBlue)
                                    .frame(width: account.Ipad ? sizing.ipadHorizontalInputForForm : sizing.horizontalInputForForm,alignment: .leading)
                                    .font(.system(size: 17))
                                TextField("4161234567", text: $referralphone, onEditingChanged: { (editingChanged) in
                                    if editingChanged {
                                        referralchange = true
                                        loading = true
                                    } else {
                                        referralchange = false
                                        findcardholder()
                                    }
                                })
                                .onReceive(Just(referralphone), perform: { _ in
                                    limitText(limit: textLimit, value: &referralphone)
                                })
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
    //                            .disableAutocorrection(true)
                                .keyboardType(.numberPad)
                                .font(.system(size: 15))
                                
                                Button {
    //                                findcardholder()
                                    print("DEBUG: Check for cardholder button is tapped. Since findcardholder() will be called when textField is out of focussed. There is no need to call that function again.")
                                } label: {
                                    Image(systemName: "checkmark.circle")
                                        .resizable()
                                        .renderingMode(.template)
                                        .foregroundColor(Color.MyBlue)
                                        .scaledToFit()
                                        .frame(width: 30, height: 30)
                                }

                            }
                            .padding(.horizontal, 10)
                            .padding(.top, sizing.verticalFormSpacing)
                            .font(.system(size: sizing.smallTextSize))
                            Text(refferalerrorText)
                                .foregroundColor(Color.LoginLinks)
                                .padding(.horizontal, 10)
                                .padding(.top, sizing.verticalFormSpacing)
                                .font(.system(size: sizing.smallTextSize))
                        }
                        //                    }
                        //                    .frame(maxWidth:.infinity, alignment: .center)
                        Spacer()
                        HStack(spacing: 0)
                        {
                            Button(action: {CreateAccount()}, label: {
                                ZStack
                                {
                                    RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                        .stroke((loading ? Color.MyGrey : Color.MyBlue), lineWidth: 2)
                                    //                                    .foregroundColor(loading ? .MyGrey : .MyBlue)
                                        .frame(height: 60)
                                    
                                    Text("Create Account")
                                        .fontWeight(.semibold)
                                        .foregroundColor((loading ? Color.MyGrey : Color.MyBlue))
                                        .font(.system(size: 20))
                                }
                            })
                            .padding([.leading, .bottom])
                            .padding(.trailing, 5.0)
                            //                        Button(action: {Back()}, label: {
                            //                            ZStack
                            //                            {
                            //                                RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                            //                                    .foregroundColor(.MyBlue)
                            //                                    .frame(height: 60)
                            //
                            //                                Text("Back")
                            //                                    .fontWeight(.semibold)
                            //                                    .foregroundColor(.white)
                            //                                    .font(.system(size: 20))
                            //                            }
                            //                        })
                            //                        .padding([.bottom, .trailing])
                            //                        .padding(.leading, 5.0)
                        }
                        .alert(isPresented: $error) {
                            Alert(
                                title: Text(alerttext),
                                dismissButton: .default(Text("OK"), action: {
                                    self.presentationMode.wrappedValue.dismiss()
                                })
                            )
                        }.padding()
                    }
                }
            } //: VStack
            .onAppear(perform:{
                account.infoPage = 3
                FindReferral()
    //            GetAccStore()
            })
            .padding(.all,10)
            .navigationBarTitle("")
            .navigationBarHidden(true)
        } //: Scrollview
    }
    func Back() -> Void{
//        page = 0
        page = 2
    }
//    struct acc: Decodable {
//        var id: Int?
//        var name: String?
//    }
//    func GetAccStore() -> Void {
//
//            APIRequest().Post(withParameters: ["action":"get-all-stores"])
//            {data in
//                DispatchQueue.main.async {
//                    print("------------")
//                    print(data)
//                    print("------------")
//                    if(data != "false" && data != "" && data != "nosession" && data != "[]")
//                    {
//                        let jsonData = data.data(using: .utf8)!
//                        let test: [acc] = try! JSONDecoder().decode([acc].self, from: jsonData)
//                        //print(test)
//                        var newAcc = acc()
//                        newAcc.id = 0
//                        newAcc.name = "Select a store"
//                        accountList.append(newAcc)
//                        accountList += test
//                        if(accountList.count > 0)
//                        {
//                            selectedAccount = accountList[0]
//                        }
//                        errorText = ""
//                        //                        for accs in accountList {
//                        //                            print(accs.store_displayname)
//                        //                        }
//                    }
//                    else
//                    {
//                        accountList.removeAll()
//                        selectedAccount = acc()
//                    }
//                }
//            }
//    }
    func findcardholder() -> Void {
        refid = ""
//        APIRequest().Post(withParameters: ["action":"find-cardholder","phone":referralphone,"store":String(selectedAccount.id ?? 0)])
        APIRequest().Post(withParameters: ["action":"find-cardholder","phone":referralphone,"store":String(selectedAccountFromSearch.id ?? 0)])
            {data in
                DispatchQueue.main.async {
                    print("------------")
                    print(data)
                    print("------------")
                    if(data != "false" && data != "" && data != "nosession" && data != "[]")
                    {
                        refferalerrorText = "Referral account found!"
                        refid = referralphone
                        refferalpersonfound = true
                    }
                    else
                    {
                        refferalerrorText = "Referral account not found..."
                        refferalpersonfound = false
                    }
                    loading = false
                }
            }
    }
    func FindReferral() -> Void{

        referral = ""
//        if(selectedAccount.id == 0)
            if(selectedAccountFromSearch.id == 0)
        {
            return
        }
//            APIRequest().Post(withParameters: ["action":"get-referral","store":String(selectedAccount.id!)])
        APIRequest().Post(withParameters: ["action":"get-referral","store":String(selectedAccountFromSearch.id!)])
            {data in
                DispatchQueue.main.async {
                    print("\n-----------test----------\n" + data + "\n-----------test----------")
                    if(data != "[]")
                    {
                        //already has referal at this store
                        let jsonData = data.data(using: .utf8)!
                        let test: [ref] = try! JSONDecoder().decode([ref].self, from: jsonData)
                        print(test[0].recieveramount!)
                        
                        referral = test[0].name ?? ""
                        referralsuccuess = true
                    }
                    else
                    {
                        referral = "No referral found at this store"
                        referralsuccuess = false
                    }
                }
            }
    }
    func CreateAccount() -> Void{
//        if(selectedAccount.id == 0)
//        {
//            errorText = "Please select a store..."
//            return
//        }
        if(!isValidEmail(email))
        {
            errorText = "Please enter a valid email address..."
            return
        }
        if(password == "" || repassword == "" || email == "" || firstname == "" || lastname == "" || streetAddress == "" || city == "" || zipcode == "" || phone == "")
        {
            errorText = "Please fill in all fields..."
            return
        }
        if(password != repassword)
        {
            errorText = "Passwords don't match..."
            return
        }
        if(SelectedProvince == 0)
        {
            errorText = "Please select a province/state..."
            return
        }
        if(!phone.isNumber)
        {
            errorText = "Please enter a valid phone number..."
            return
        }
        if(loading)
        {
            return
        }
        errorText = ""
        APIRequest().Post(withParameters: ["action":"add-user","displayname":"","firstname":firstname,"lastname":lastname,"email":email,"phone":phone,"address":streetAddress,"city":city,"province":String(SelectedProvince),"pin":"0000","postal":zipcode.trimmingCharacters(in: .whitespaces),"store":String(selectedAccountFromSearch.id!),"user_type":"1","password":password,"ref":refid])
        {data in
            DispatchQueue.main.async {
                print("------------")
                print(data)
                print("------------")
                if(data != "")
                {
                    alerttext = "Account created"
                    error = true
                }
                else
                {
                    errorText = "Email and/or phone number is in use at this store already..."
                }
            }
        }
    }
    
    //Function to keep text length in limits
    func limitText(limit upper: Int, value: inout String) {
            if value.count > upper {
                value = String(value.prefix(upper))
            }
        }
    
    struct ref: Decodable {
        var id: Int?
        var store: Int?
        var senderamount: String?
        var recieveramount: String?
        var name: String?
        var message: String?
        var created: String?
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
}

extension String {
    var isNumber: Bool {
        return range(of: "[^0-9]", options: .regularExpression) == nil
    }
}

// Help Button Popover view
struct CreateCustomerAccountPopoverContent: View {
   
    @Binding var presentMe : Bool
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 20) {
            
            HStack {
                
                Text("Create Customer Account")
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .padding([.top, .leading])
                
                Spacer ()
                
                // This should be the button to return to the main screen that NOW IT'S FINALLY working
                Button  (action: {
                    
                    // Change the value of the Binding
                    presentMe = false
                    
                }, label: {
                    Image(systemName: "xmark.circle")
                        .foregroundColor(Color.gray)
                })
                .padding([.top, .trailing])
            }
            
            Divider()
                .padding(.horizontal)
                .frame(height: 3.0)
                .foregroundColor(Color.gray)
            
            Spacer()
            
            HStack {
                Spacer()
                
                Image("infoButtonImage-blue")
                    .resizable()
//                    .renderingMode(.template)
                    .scaledToFit()
//                    .foregroundColor(.blue)
                    .frame(width: 50, height: 50, alignment: .center)
                
                Spacer()
            }
            
//            Text("Account registration (main reg. Page)")
//                .font(.title3)
//                .fontWeight(.semibold)
//                .padding(.vertical, 20)
            
            Text("Here you need to choose a store you are planning to use the app for. You will see a button 'Select a store', fill in the information about yourself: Email, Password, First Name, Last Name, Phone, Address, City, and Postal Code. If you have a referral code, enter it on the bottom of the form. In this way, both you, and the referrer will get the bonus. After the account will be created you will not be able to enter the referral number.")
                .font(.body)
                .padding(.vertical, 20)
            
            Text("After you have done all the steps, you need to press the 'Create Account' button at the very bottom. “Account created” notification will pop up, press 'OK'. Now you are ready to log in with your credentials!")
                .font(.body)
                .padding(.vertical, 20)
            
            Spacer()
        }
        .padding()
    }
}
