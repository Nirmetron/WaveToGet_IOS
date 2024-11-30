

import SwiftUI
import Combine

struct CreateStoreAccount: View {
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
    @State private var displayname = ""
    @State private var phone = ""
    @State private var streetAddress = ""
    @State private var city = ""    
    @State private var zipcode = ""
    @State private var errorText = ""
    @State private var loading = false
    @State private var alerttext = ""
    @State private var alert = false
    @State private var reviewURL = ""
    @State private var province = 0
    @Binding public var page:Int
    
    let textLimit = 10
    
    let provinceList = [
        "Alberta",
        "British Columbia",
        "Manitoba",
        "New Brunswick",
        "Newfoundland and Labrador",
        "Nova Scotia", "Nunavut",
        "Ontario",
        "Prince Edward Island",
        "Quebec", "Saskatchewan",
        "Yukon",
        "Alabama",
        "Alaska",
        "Arizona",
        "Arkansas",
        "California",
        "Colorado",
        "Connecticut",
        "Delaware",
        "District of Columbia",
        "Florida",
        "Georgia",
        "Hawaii",
        "Idaho",
        "Illinois",
        "Indiana",
        "Iowa",
        "Kansas",
        "Kentucky",
        "Louisiana",
        "Maine",
        "Maryland",
        "Massachusetts",
        "Michigan",
        "Minnesota",
        "Mississippi",
        "Missouri",
        "Montana",
        "Nebraska",
        "Nevada",
        "New Hampshire",
        "New Jersey",
        "New Mexico",
        "New York",
        "North Carolina",
        "North Dakota",
        "Ohio",
        "Oklahoma",
        "Oregon",
        "Pennsylvania",
        "Rhode Island",
        "South Carolina",
        "South Dakota",
        "Tennessee",
        "Texas",
        "Utah",
        "Vermont",
        "Virginia",
        "Washington",
        "West Virginia",
        "Wisconsin",
        "Wyoming",
        "American Samoa",
        "Guam",
        "Northern Mariana Islands",
        "Puerto Rico",
        "U.S. Virgin Islands",
        "U.S. Minor Outlying Islands"
    ]
    
    let provinceListDict: [String: String] = [
        "Alberta" : "1",
        "British Columbia" : "2",
        "Manitoba" : "3",
        "New Brunswick" : "4",
        "Newfoundland and Labrador" : "5",
        "Nova Scotia" : "6",
        "Nunavut" : "7",
        "Ontario" : "8",
        "Prince Edward Island" : "9",
        "Quebec" : "10",
        "Saskatchewan" : "11",
        "Yukon" : "12",
        "Alabama" : "13",
        "Alaska" : "14",
        "Arizona" : "15",
        "Arkansas" : "16",
        "California" : "17",
        "Colorado" : "18",
        "Connecticut" : "19",
        "Delaware" : "20",
        "District of Columbia" : "21",
        "Florida" : "22",
        "Georgia" : "23",
        "Hawaii" : "24",
        "Idaho" : "25",
        "Illinois" : "26",
        "Indiana" : "27",
        "Iowa" : "28",
        "Kansas" : "29",
        "Kentucky" : "30",
        "Louisiana" : "31",
        "Maine" : "32",
        "Maryland" : "33",
        "Massachusetts" : "34",
        "Michigan" : "35",
        "Minnesota" : "36",
        "Mississippi" : "37",
        "Missouri" : "38",
        "Montana" : "39",
        "Nebraska" : "40",
        "Nevada" : "41",
        "New Hampshire" : "42",
        "New Jersey" : "43",
        "New Mexico" : "44",
        "New York" : "45",
        "North Carolina" : "46",
        "North Dakota" : "47",
        "Ohio" : "48",
        "Oklahoma" : "49",
        "Oregon" : "50",
        "Pennsylvania" : "51",
        "Rhode Island" : "52",
        "South Carolina" : "53",
        "South Dakota" : "54",
        "Tennessee" : "55",
        "Texas" : "56",
        "Utah" : "57",
        "Vermont" : "58",
        "Virginia" : "59",
        "Washington" : "60",
        "West Virginia" : "61",
        "Wisconsin" : "62",
        "Wyoming" : "63",
        "American Samoa" : "64",
        "Guam" : "65",
        "Northern Mariana Islands" : "66",
        "Puerto Rico" : "67",
        "U.S. Virgin Islands" : "68",
        "U.S. Minor Outlying Islands" : "69"
    ]
    
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
                Text("CREATE STORE ACCOUNT")
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
                        HStack(alignment: .top)
                        {
                            VStack
                            {
                                Group
                                {
                                
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
    //                                        Text(account.verifiedEmail)
    //                                            .foregroundColor(.MyBlue)
    //                                            .frame(maxWidth: .infinity, alignment: .leading)
                                                
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
                                        Text("Store Name:")
                                            .foregroundColor(.MyBlue)
                                            .frame(width: account.Ipad ? sizing.ipadHorizontalInputForForm : sizing.horizontalInputForForm,alignment: .leading)
                                            .font(.system(size: 17))
                                        TextField("Store Name:", text: $displayname)
                                            .font(.system(size: 15))
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                            .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                                            .disableAutocorrection(true)
                                            .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                            
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
                                            TextField("4161234567", text: $phone)
                                                .font(.system(size: 15))
                                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                                .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                                                .keyboardType(.numberPad)
                                                .onReceive(Just(phone), perform: { _ in
                                                    limitText(limit: textLimit, value: &phone)
                                                })
                                                
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
                                    HStack()
                                    {
                                        Text("Province/State:")
                                            .foregroundColor(.MyBlue)
                                            .frame(width: account.Ipad ? sizing.ipadHorizontalInputForForm : sizing.horizontalInputForForm,alignment: .leading)
                                            .font(.system(size: 17))
    //                                    Menu(province) {
    //                                        ForEach(provinceList, id: \.self) { item in
    //                                            Button(item) {
    //                                                province = item
    //                                            }
    //                                        }
    //                                    }
                                        
                                        Menu {
                                            ForEach(0..<account.ProvinceList.count, id: \.self)
                                            { i in
                                                Button {
                                                    province = i + 1
                                                    print(province)
                                                } label: {
                                                    Text((account.ProvinceList[i]))
                                                        .font(.system(size: 15))
                                                }
                                            }
                                        } label: {
                                            Text(province == 0 ? "Select a Province/State" : (account.ProvinceList[province - 1] ?? ""))
                                                .frame(maxWidth:.infinity,alignment: .leading)
                                                .font(.system(size: 15))
                                        }
                                        
    //                                    Spacer()
                                            
                                    }
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
                                                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                                
                                        }
    //                                HStack
    //                                {
    //                                    Text("Google Review Link:")
    //                                        .foregroundColor(.MyBlue)
    //                                        .frame(width: account.Ipad ? sizing.ipadHorizontalInputForForm : sizing.horizontalInputForForm,alignment: .leading)
    //                                    TextField("Google Review Link:", text: $reviewURL)
    //                                        .textFieldStyle(RoundedBorderTextFieldStyle())
    //                                        .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
    //                                        .disableAutocorrection(true)
    //                                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
    //
    //                                }
                                }
                            }
                            .padding(.horizontal, 10)
                            .padding(.top, sizing.verticalFormSpacing)
                            .font(.system(size: sizing.smallTextSize))
                        }
                        .frame(maxWidth:.infinity, alignment: .center)
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
    //                                    .foregroundColor(.white)
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
                    }
                }
                .alert(isPresented: $alert) {

                    Alert(
                        title: Text(alerttext),
                        dismissButton: .default(Text("OK"), action: {
                            self.presentationMode.wrappedValue.dismiss()
                        })
                    )
                }.padding()
            } //: Vstack
            .onAppear(perform: {
                account.infoPage = 8
            })
            .padding(.all,10)
            .navigationBarTitle("")
            .navigationBarHidden(true)
        } //: Scrollview
    }
    func Back() -> Void{
        page = 0
    }
    struct acc: Decodable {
        var id: Int?
        var name: String?
    }
    func CreateAccount() -> Void {
        if(loading)
        {
            return
        }
        if(email == "" || password == "" || repassword == "" || firstname == "" || lastname == "" || displayname == "" || streetAddress == "" || city == "" || zipcode == "" || phone == "" || province == 0)
        {
            errorText = "Please fill in all fields..."
            return
        }
        if(password != repassword)
        {
            errorText = "Passwords don't match..."
            return
        }
        loading = true
        errorText = "Loading this may take a couple of minutes..."
//        let provinceID = provinceListDict[province] ?? "1"
        let provinceID = String(province)
        let params: [String: String] = [
            "storename": displayname,
            "cardname": displayname,
            "password": password,
            "firstname": firstname,
            "lastname": lastname,
            "email": email,
            "phone": phone,
            "address": streetAddress,
            "city": city,
            "province" : provinceID,
            "postal": zipcode
//            "GoogleReviewURL": reviewURL
        ]
        print("DEBUG: Store Creation params = \(params)")
        APIRequest().Post(withParameters: params, _url: StoreAPI.CREATE_STORE) { data in
            DispatchQueue.main.async {
                print("DEBUG: data is \(data)")
                if !data.isEmpty {
                    if data.contains("could not be added") {
                        loading = false
                        errorText = data
                    }
                    else {
                        alerttext = "You have successfully registered."
                        alert = true
                        loading = true
                        errorText = ""
                    }
                    
                }
                else {
                    loading = false
                    errorText = "Something went wrong"
                }
                
            }
        }
//        APIRequest().Post(withParameters: ["action":"send-ron-store-register","storename":displayname,"password":password,"firstname":firstname,"lastname":lastname,"email":account.verifiedEmail,"phone":phone,"address":streetAddress,"city":city,"postal":zipcode,"app":"2"])
//        {data in
//            DispatchQueue.main.async {
//                print("------------")
//                print(data)
//                print("------------")
//                if(data != "")
//                {
//                    alerttext = "You will be contacted soon to complete registration.  Thank you for your patience."
//                    alert = true
//                    loading = true
//                }
//                else
//                {
//                    loading = false
//                }
//                errorText = ""
//            }
//        }
    }
    
    //Function to keep text length in limits
    func limitText(limit upper: Int, value: inout String) {
        if value.count > upper {
            value = String(value.prefix(upper))
        }
    }
    
}
