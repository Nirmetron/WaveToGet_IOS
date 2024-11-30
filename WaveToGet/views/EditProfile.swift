//
//  EditProfile.swift
//  wavetoget
//
//  Created by Jesse Lugassy on 2021-03-11.
//

import SwiftUI

struct EditProfile: View {
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
    @State private var province = 0
    @State private var zipcode = ""
    @State private var errorText = ""
    @State private var store = ""
    @State private var reviewURL = ""
    @State var agree:Bool = false
    @State private var showDeletePrompt = false
    @State private var showStoreOwnerDeleteAlert = false
    @State private var hasAccountDeleted = false
    @State private var showTerms = false
    
    let defaultLocalizer = AMPLocalizeUtils.defaultLocalizer
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View
    {
        
        if hasAccountDeleted {
            Login()
        }
        else {
            ScrollView {
                VStack(spacing: 0)
                {
                    
                    HStack {
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
                            .padding([.top, .trailing], 10.0)
                            
                        })

                        Spacer()

                        if account.isCust {
                            Button(action: {
                                showDeletePrompt = true
                            }, label: {
                                ZStack
                                {
                                    RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                        .stroke(Color.MyRed, lineWidth: 2)
                                        .frame(height: 35)

                                    Text("DELETE ACCOUNT")
                                        .fontWeight(.semibold)
                                        .foregroundColor(.MyRed)
                                        .font(.system(size: 14))
                                }
                                .frame(maxWidth: 200)
                                .frame(alignment: .leading)
                                .padding([.top, .leading], 10.0)
                            })
                        }
                        else if !account.isCust && !account.EditCust {
                            Button(action: {
                                showDeletePrompt = true
                            }, label: {
                                ZStack
                                {
                                    RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                        .stroke(Color.MyRed, lineWidth: 2)
                                        .frame(height: 35)

                                    Text(defaultLocalizer.stringForKey(key: "DELETE ACCOUNT"))
                                        .fontWeight(.semibold)
                                        .foregroundColor(.MyRed)
                                        .font(.system(size: 14))
                                }
                                .frame(maxWidth: 200)
                                .frame(alignment: .leading)
                                .padding([.top, .leading], 10.0)
                            })
                        }


                    } //: HStack
                    .padding(.bottom)
                    .actionSheet(isPresented: $showDeletePrompt) {
                        ActionSheet(
                            title: Text("\(defaultLocalizer.stringForKey(key: "Are you sure you want to delete your account"))?"),
                            buttons: [
                                .destructive(Text(defaultLocalizer.stringForKey(key: "Delete Account"))) {

                                    if account.isCust {
                                        deleteClientAccount()
                                    }
                                    else if !account.isCust && !account.EditCust {
                                        showStoreOwnerDeleteAlert = true
                                    }


                                },

                                    .default(Text(defaultLocalizer.stringForKey(key: "Cancel"))) {
                                        showDeletePrompt = false
                                    }
                            ]
                        )
                    }
                    .alert(isPresented: $showStoreOwnerDeleteAlert) {
                               Alert(
                                title: Text("\(defaultLocalizer.stringForKey(key: "Please contact application administrator in order to delete your store account")).")
                               )
                           }.padding()

                    
                    if(account.EditCust == account.isCust)
                    {
                        Text(defaultLocalizer.stringForKey(key: "EDIT ACCOUNT CREDENTIALS"))
                            .font(.system(size: 17))
                            .padding(.top, 5.0)
                    }
                    ZStack
                    {
        //                RoundedRectangle(cornerRadius: 2).stroke(Color.MyGrey, lineWidth: 2)
                        VStack(alignment: .leading, spacing:0)
                        {
                            Text(errorText)
                                .padding(.vertical, 5)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .foregroundColor(.red)
                                .font(.system(size: sizing.smallTextSize))
                            
                            HStack(alignment: .top)
                            {
                                VStack
                                {
                                    Group{
                                        if(account.EditCust)
                                        {
                                            HStack
                                            {
                                                Text("\(defaultLocalizer.stringForKey(key: "Display Name")):")
                                                    .foregroundColor(.MyBlue)
                                                    .frame(width: account.Ipad ? sizing.ipadHorizontalInputForForm : sizing.horizontalInputForForm,alignment: .leading)
                                                    .font(.system(size: 17))
                                                
                                                TextField(account.EditCust != account.isCust ? "" : account.Username == "" ? "\(defaultLocalizer.stringForKey(key: "Add a display name"))..." : account.Username, text: $displayname)
                                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                                                    .disableAutocorrection(true)
                                                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                                    .font(.system(size: 15))
                                                    
                                            }
                                            HStack
                                            {
                                                Text("\(defaultLocalizer.stringForKey(key: "Email")):")
                                                    .foregroundColor(.MyBlue)
                                                    .frame(width: account.Ipad ? sizing.ipadHorizontalInputForForm : sizing.horizontalInputForForm, alignment: .leading)
                                                    .font(.system(size: 17))
                                                
                                                TextField(account.EditCust != account.isCust ? "" : account.Email, text: $email)
                                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                                                    .disableAutocorrection(true)
                                                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                                    .font(.system(size: 15))
                                                
                                            }
                                            HStack
                                            {
                                                Text("\(defaultLocalizer.stringForKey(key: "Password")):")
                                                    .foregroundColor(.MyBlue)
                                                    .frame(width: account.Ipad ? sizing.ipadHorizontalInputForForm : sizing.horizontalInputForForm,alignment: .leading)
                                                    .font(.system(size: 17))
                                                
                                                HStack
                                                {
                                                    SecureField(defaultLocalizer.stringForKey(key: "Enter new password"), text: $password)
                                                        .font(.system(size: 15))
                                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                                        .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                                                        .disableAutocorrection(true)
                                                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                                    SecureField(defaultLocalizer.stringForKey(key: "Re-enter password"), text: $repassword)
                                                        .font(.system(size: 15))
                                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                                        .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                                                        .disableAutocorrection(true)
                                                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                                }
                                                
                                            }
                                            HStack
                                            {
                                                Text("\(defaultLocalizer.stringForKey(key: "First Name")):")
                                                    .foregroundColor(.MyBlue)
                                                    .frame(width: account.Ipad ? sizing.ipadHorizontalInputForForm : sizing.horizontalInputForForm,alignment: .leading)
                                                    .font(.system(size: 17))
                                                
                                                TextField(custAccount.firstname == "" ? "\(defaultLocalizer.stringForKey(key: "Add a first name"))..." : custAccount.firstname, text: $firstname)
                                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                                                    .disableAutocorrection(true)
                                                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                                    .font(.system(size: 15))
                                            }
                                            HStack
                                            {
                                                Text("\(defaultLocalizer.stringForKey(key: "Last Name")):")
                                                    .foregroundColor(.MyBlue)
                                                    .frame(width: account.Ipad ? sizing.ipadHorizontalInputForForm : sizing.horizontalInputForForm,alignment: .leading)
                                                    .font(.system(size: 17))
                                                
                                                TextField(custAccount.lastname == "" ? "\(defaultLocalizer.stringForKey(key: "Add a last name"))..." : custAccount.lastname, text: $lastname)
                                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                                                    .disableAutocorrection(true)
                                                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                                    .font(.system(size: 15))
                                            }
                                            HStack
                                            {
                                                Text("\(defaultLocalizer.stringForKey(key: "Phone")):")
                                                    .foregroundColor(.MyBlue)
                                                    .frame(width: account.Ipad ? sizing.ipadHorizontalInputForForm : sizing.horizontalInputForForm,alignment: .leading)
                                                    .font(.system(size: 17))
                                                TextField(custAccount.phone == "" ? "\(defaultLocalizer.stringForKey(key: "Add a phone number"))...": custAccount.phone, text: $phone)
                                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                                                    .disableAutocorrection(true)
                                                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                                    .font(.system(size: 15))
                                            }
                                            HStack
                                            {
                                                Text("\(defaultLocalizer.stringForKey(key: "Address")):")
                                                    .foregroundColor(.MyBlue)
                                                    .frame(width: account.Ipad ? sizing.ipadHorizontalInputForForm : sizing.horizontalInputForForm,alignment: .leading)
                                                    .font(.system(size: 17))
                                                TextField(custAccount.address == "" ? "\(defaultLocalizer.stringForKey(key: "Add a street address"))..." : custAccount.address, text: $streetAddress)
                                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                                                    .disableAutocorrection(true)
                                                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                                    .font(.system(size: 15))
                                            }
                                            HStack
                                            {
                                                Text("\(defaultLocalizer.stringForKey(key: "City")):")
                                                    .foregroundColor(.MyBlue)
                                                    .frame(width: account.Ipad ? sizing.ipadHorizontalInputForForm : sizing.horizontalInputForForm,alignment: .leading)
                                                    .font(.system(size: 17))
                                                TextField(custAccount.city == "" ? "\(defaultLocalizer.stringForKey(key: "Add a city"))..." : custAccount.city, text: $city)
                                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                                                    .disableAutocorrection(true)
                                                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                                    .font(.system(size: 15))
                                            }
                                            HStack
                                            {
                                                Text("\(defaultLocalizer.stringForKey(key: "Province/State")):")
                                                    .foregroundColor(.MyBlue)
                                                    .frame(width: account.Ipad ? sizing.ipadHorizontalInputForForm : sizing.horizontalInputForForm,alignment: .leading)
                                                    .font(.system(size: 17))

                                                Menu {
                                                    ForEach(0..<account.ProvinceList.count, id: \.self)
                                                    { i in
                                                        Button { province = i + 1
                                                            print(province)
                                                        } label: {
                                                            Text((account.ProvinceList[i]))
                                                                .font(.system(size: 15))
                                                        }
                                                    }
                                                } label: {
                                                    Text(province == 0 ? defaultLocalizer.stringForKey(key: "Select a Province/State") : (account.ProvinceList[province - 1] ?? ""))
                                                        .frame(maxWidth:.infinity,alignment: .leading)
                                                        .font(.system(size: 15))
                                                }
                                            }
                                            HStack
                                            {
                                                Text("\(defaultLocalizer.stringForKey(key: "Postal Code")):")
                                                    .foregroundColor(.MyBlue)
                                                    .frame(width: account.Ipad ? sizing.ipadHorizontalInputForForm : sizing.horizontalInputForForm,alignment: .leading)
                                                    .font(.system(size: 17))
                                                
                                                TextField(custAccount.postalcode == "" ? "\(defaultLocalizer.stringForKey(key: "Zip/Postal"))..." : custAccount.postalcode, text: $zipcode)
                                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                                                    .disableAutocorrection(true)
                                                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                                    .font(.system(size: 15))
                                            }
                                        }
                                        else
                                        {
                                            HStack
                                            {
                                                Text("\(defaultLocalizer.stringForKey(key: "Business Name")):")
                                                    .foregroundColor(.MyBlue)
                                                    .frame(width: account.Ipad ? sizing.ipadHorizontalInputForForm : sizing.horizontalInputForForm,alignment: .leading)
                                                    .font(.system(size: 17))
                                                TextField(storeAccount.name == "" ? "\(defaultLocalizer.stringForKey(key: "Add a business name"))..." : storeAccount.name, text: $displayname)
                                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                                                    .disableAutocorrection(true)
                                                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                                    .font(.system(size: 15))
                                            }
                                            HStack
                                            {
                                                Text("\(defaultLocalizer.stringForKey(key: "Email")):")
                                                    .foregroundColor(.MyBlue)
                                                    .frame(width: account.Ipad ? sizing.ipadHorizontalInputForForm : sizing.horizontalInputForForm,alignment: .leading)
                                                    .font(.system(size: 17))
                                                TextField(account.Email, text: $email)
                                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                                                    .disableAutocorrection(true)
                                                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                                    .font(.system(size: 15))
                                            }
                                            HStack
                                            {
                                                Text("\(defaultLocalizer.stringForKey(key: "Password")):")
                                                    .foregroundColor(.MyBlue)
                                                    .frame(width: account.Ipad ? sizing.ipadHorizontalInputForForm : sizing.horizontalInputForForm,alignment: .leading)
                                                    .font(.system(size: 17))
                                                HStack
                                                {
                                                    SecureField(defaultLocalizer.stringForKey(key: "Enter new password"), text: $password)
                                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                                        .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                                                        .disableAutocorrection(true)
                                                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                                        .font(.system(size: 15))
                                                    
                                                    SecureField(defaultLocalizer.stringForKey(key: "Re-enter password"), text: $repassword)
                                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                                        .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                                                        .disableAutocorrection(true)
                                                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                                        .font(.system(size: 15))
                                                }
                                                
                                            }
                                            HStack
                                            {
                                                Text("\(defaultLocalizer.stringForKey(key: "Card Name")):")
                                                    .foregroundColor(.MyBlue)
                                                    .frame(width: account.Ipad ? sizing.ipadHorizontalInputForForm : sizing.horizontalInputForForm,alignment: .leading)
                                                    .font(.system(size: 17))
                                                
                                                TextField(storeAccount.cardname == "" ? "\(defaultLocalizer.stringForKey(key: "Add a card name"))..." : storeAccount.cardname, text: $firstname)
                                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                                                    .disableAutocorrection(true)
                                                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                                    .font(.system(size: 15))
                                            }
                                            HStack
                                            {
                                                Text("\(defaultLocalizer.stringForKey(key: "Phone")):")
                                                    .foregroundColor(.MyBlue)
                                                    .frame(width: account.Ipad ? sizing.ipadHorizontalInputForForm : sizing.horizontalInputForForm,alignment: .leading)
                                                    .font(.system(size: 17))
                                                
                                                TextField(storeAccount.phone == "" ? "\(defaultLocalizer.stringForKey(key: "Add a phone number"))...": storeAccount.phone, text: $phone)
                                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                                                    .disableAutocorrection(true)
                                                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                                    .font(.system(size: 15))
                                            }
                                            HStack
                                            {
                                                Text("\(defaultLocalizer.stringForKey(key: "Address")):")
                                                    .foregroundColor(.MyBlue)
                                                    .frame(width: account.Ipad ? sizing.ipadHorizontalInputForForm : sizing.horizontalInputForForm,alignment: .leading)
                                                    .font(.system(size: 17))
                                                
                                                TextField(storeAccount.address == "" ? "\(defaultLocalizer.stringForKey(key: "Add a street address"))..." : storeAccount.address, text: $streetAddress)
                                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                                                    .disableAutocorrection(true)
                                                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                                    .font(.system(size: 15))
                                            }
                                            HStack
                                            {
                                                Text("\(defaultLocalizer.stringForKey(key: "City")):")
                                                    .foregroundColor(.MyBlue)
                                                    .frame(width: account.Ipad ? sizing.ipadHorizontalInputForForm : sizing.horizontalInputForForm,alignment: .leading)
                                                    .font(.system(size: 17))
                                                
                                                TextField(storeAccount.city == "" ? "\(defaultLocalizer.stringForKey(key: "Add a city"))..." : storeAccount.city, text: $city)
                                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                                                    .disableAutocorrection(true)
                                                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                                    .font(.system(size: 15))
                                            }
                                            HStack
                                            {
                                                Text("\(defaultLocalizer.stringForKey(key: "Province/State")):")
                                                    .foregroundColor(.MyBlue)
                                                    .frame(width: account.Ipad ? sizing.ipadHorizontalInputForForm : sizing.horizontalInputForForm,alignment: .leading)
                                                    .font(.system(size: 17))

                                                Menu {
                                                    ForEach(0..<account.ProvinceList.count, id: \.self)
                                                    { i in
                                                        Button { province = i + 1
                                                            print(province)
                                                        } label: {
                                                            Text((account.ProvinceList[i]))
                                                                .font(.system(size: 15))
                                                        }
                                                    }
                                                } label: {
                                                    Text(province == 0 ? defaultLocalizer.stringForKey(key: "Select a Province/State") : (account.ProvinceList[province - 1] ?? ""))
                                                        .frame(maxWidth:.infinity,alignment: .leading)
                                                        .font(.system(size: 15))
                                                }
                                            }
                                            HStack
                                            {
                                                Text("\(defaultLocalizer.stringForKey(key: "Postal Code")):")
                                                    .foregroundColor(.MyBlue)
                                                    .frame(width: account.Ipad ? sizing.ipadHorizontalInputForForm : sizing.horizontalInputForForm,alignment: .leading)
                                                    .font(.system(size: 17))
                                                
                                                TextField(storeAccount.postalcode == "" ? "\(defaultLocalizer.stringForKey(key: "Zip/Postal"))..." : storeAccount.postalcode, text: $zipcode)
                                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                                                    .disableAutocorrection(true)
                                                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                                    .font(.system(size: 15))
                                                    
                                            }
//                                            HStack //TODO: storeAccount.reviewURL
//                                            {
//                                                Text("\(defaultLocalizer.stringForKey(key: "Google Review Link")):")
//                                                    .foregroundColor(.MyBlue)
//                                                    .frame(width: account.Ipad ? sizing.ipadHorizontalInputForForm : sizing.horizontalInputForForm,alignment: .leading)
//                                                TextField(storeAccount.GoogleReviewURL == "" ? defaultLocalizer.stringForKey(key: "Google Review Link") : storeAccount.GoogleReviewURL, text: $reviewURL)
//                                                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                                                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
//                                                    .disableAutocorrection(true)
//                                                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
//
//                                            } //: HStack
                                        }
                                    }
                                }
                                .padding(.horizontal, 10)
                                .padding(.top, sizing.verticalFormSpacing)
                                .font(.system(size: sizing.smallTextSize))
                            }
                            .frame(maxWidth:.infinity, alignment: .center)
                            Spacer()
                            if(account.EditCust == account.isCust)
                            {
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
                                
                                // Privacy Policy
                                Button {
                                    showTerms = true
                                } label: {
                                    Group {
                                        Text("\(defaultLocalizer.stringForKey(key: "I agree with the")) ").font(.system(size: 15)) + Text("\(defaultLocalizer.stringForKey(key: "Terms & Conditions"))?").bold()
                                            .font(.system(size: 15))
                                        
                                    }
                                        .padding(.vertical, 20)
                                        .foregroundColor(.MyBlue)
                                }
                                .padding(5)
                                .fullScreenCover(isPresented: $showTerms, content: {
                                    SFSafariViewWrapper(url: URL(string: "https://www.referralandrewards.com/terms.php")!)
                                })
                                
                                
                                
                            }
                            }
                            HStack(spacing: 0)
                            {
                                Button(action: {EditUserFunc()}, label: {
                                    ZStack
                                    {
                                        RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                            .stroke(Color.MyBlue, lineWidth: 2)
        //                                    .foregroundColor(.MyBlue)
                                            .frame(height: 60)
                                        
                                        Text(defaultLocalizer.stringForKey(key: "Save"))
                                            .fontWeight(.semibold)
                                            .foregroundColor(.MyBlue)
                                            .font(.system(size: 20))
                                    }
                                })
                                .padding([.leading, .bottom])
                                .padding(.trailing, 5.0)
        //                        Button(action: {Back()}, label: {
        //                            ZStack
        //                            {
        //                                RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
        //                                    .stroke(Color.MyBlue, lineWidth: 2)
        ////                                    .foregroundColor(.MyBlue)
        //                                    .frame(height: 60)
        //
        //                                Text("Back")
        //                                    .fontWeight(.semibold)
        //                                    .foregroundColor(.MyBlue)
        //                                    .font(.system(size: 20))
        //                            }
        //                        })
        //                        .padding([.bottom, .trailing])
        //                        .padding(.leading, 5.0)
                            }
                        }
                    }
                    .onAppear(perform: AssignDefaults)
                    .onAppear(perform: {account.loadedAcc = true})
                    .onAppear {
                        if(account.isCust) {
                            account.infoPage = 6
                        }
                        else if account.EditCust {
                            account.infoPage = 19
                        }
                        else {
                            account.infoPage = 14
                        }
                        
                    }
                } //: Vstack
                .padding(.all,10)
                .navigationBarTitle("")
                .navigationBarHidden(true)
        //        .navigate(to: Login(), when: $hasAccountDeleted)
            } //: Scrollview
        }
        
        
    }
    func AssignDefaults() -> Void{
        
    }
    func Back() -> Void{
        self.presentationMode.wrappedValue.dismiss()
        account.loadedAcc = true
    }
    
    private func deleteClientAccount() {
        
        APIRequest().Post(withParameters: ["id": "\(custAccount.id)"],
                          _url: AuthAPI.DELETE_CLIENT_ACCOUNT)
        {data in
            DispatchQueue.main.async {
                if(data != "false" && data != "" && data != "nosession" && data != "[]")
                {
//                    self.presentationMode.wrappedValue.dismiss()
                    account.loadedAcc = false
                    hasAccountDeleted = true
//                    ContentView()
//                    Login()
                }
                else
                {
                    errorText = "\(defaultLocalizer.stringForKey(key: "Something went wrong"))!"
                }
            }

        }
    }
    
    func EditUserFunc() -> Void{
        
        var params = [ "session":account.SessionToken ]
        
        if(account.EditCust)
        {
            params.updateValue("update-cardholder", forKey: "action")
            params.updateValue(String(custAccount.id), forKey: "cardholder")
            params.updateValue(String(custAccount.user), forKey: "user")
            if(displayname != "")
            {
                params.updateValue(displayname, forKey: "displayname")
            }
            if(firstname != "")
            {
                params.updateValue(firstname, forKey: "firstname")
            }
        }
        else
        {
            params.updateValue("update-store", forKey: "action")
            params.updateValue(String(storeAccount.id), forKey: "store")
            params.updateValue(String(account.id), forKey: "user")
            if(displayname != "")
            {
                params.updateValue(displayname, forKey: "name")
            }
            if(firstname != "")
            {
                params.updateValue(firstname, forKey: "cardname")
            }
            // Update Google Review URL
            if reviewURL != "" {
                params.updateValue(reviewURL, forKey: "GoogleReviewURL")
            }
        }
        
        //params.updateValue(account.SessionToken, forKey: "session")
        if(password != "")
        {
            params.updateValue(password, forKey: "password")
        }
        if(email != "")
        {
            params.updateValue(email, forKey: "email")
        }
        if(phone != "")
        {
            params.updateValue(phone, forKey: "phone")
        }
        if(streetAddress != "")
        {
            params.updateValue(streetAddress, forKey: "address")
        }
        if(city != "")
        {
            params.updateValue(city, forKey: "city")
        }
        if(province != 0)
        {
            params.updateValue(String(province), forKey: "province")
        }
        if(zipcode != "")
        {
            params.updateValue(zipcode.trimmingCharacters(in: .whitespaces), forKey: "postalcode")
        }
        if(lastname != "")
        {
            params.updateValue(lastname, forKey: "lastname")
        }
        
        if(!agree && account.EditCust == account.isCust)
        {
            errorText = "\(defaultLocalizer.stringForKey(key: "You must agree to the Terms & Conditions"))..."
            return
        }
        
        if(password == "" && repassword == "" && email == "" && displayname == "" && phone == "" && streetAddress == "" && city == "" && province == 0 && zipcode == "" && firstname == "" && lastname == "" && reviewURL == "")
        {
            //errorText = "You must fill all fields..." changed nothing go back
            Back()
            return
        }
        if(password != repassword)
        {
            errorText = "\(defaultLocalizer.stringForKey(key: "Password fields don't match"))..."
            return
        }
        
        print("update-store params = \(params)")
        APIRequest().Post(withParameters: params)
        {data in
            DispatchQueue.main.async {
                print("------------")
                print(data)
                print("------------")
                if(data != "")
                {
                    if(account.EditCust == account.isCust)
                    {
                        if(email != "")
                        {
                            account.Email = email
                        }
                        if(displayname != "")
                        {
                            account.Username = displayname
                        }
                    }
                    else
                    {
                        if(phone != "")
                        {
                            custAccount.phone = phone
                        }
                        if(streetAddress != "")
                        {
                            custAccount.address = streetAddress
                        }
                        if(city != "")
                        {
                            custAccount.city = city
                        }
                        if(province != 0)
                        {
                            custAccount.provname = account.ProvinceList[province]
                            custAccount.provCode = account.ProvinceCodeList[province]
                        }
                        if(zipcode != "")
                        {
                            custAccount.postalcode = zipcode.trimmingCharacters(in: .whitespaces)
                        }
                        if(lastname != "")
                        {
                            custAccount.lastname = lastname
                        }
                    }
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
//struct EditProfile_Preview: PreviewProvider {
//    static var previews: some View {
//        var custAcc = CustomerAccount()
//        var storeAcc = StoreAccount()
//        var account = Account()//just for preview
//        EditProfile()
//            .environmentObject(account)
//            .environmentObject(storeAcc)
//            .environmentObject(custAcc)
//    }
//}
