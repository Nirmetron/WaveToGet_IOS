//
//  ClientHome.swift
//  wavetoget
//
//  Created by Jesse Lugassy on 2021-01-15.
//

import SwiftUI

struct SearchCard: View {
    @State var cardId = "045D9562E74081"
    @EnvironmentObject var account:Account
    @EnvironmentObject var custAccount:CustomerAccount
    @EnvironmentObject var storeAccount:StoreAccount
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var search = false
    var body: some View {
        ZStack{
//            Color.MyGrey
//                .edgesIgnoringSafeArea(.all)
            VStack
            {
                HStack
                {
                    Button(action: {Back()}, label: {
                            Text("Back")
                                .foregroundColor(.white)
                                .font(.largeTitle)
                                .frame(minWidth: 90, maxWidth: 90, minHeight: 50, maxHeight: 50)
                                .background(RoundedRectangle(cornerRadius: 2)).foregroundColor(.MyBlue)
                    })
                        .padding(.leading, 30.0)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    NavigationLink(destination: AddUser().environmentObject(account)) {
                        Text("+")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .frame(minWidth: 50, maxWidth: 50, minHeight: 50, maxHeight: 50)
                            .background(RoundedRectangle(cornerRadius: 2)).foregroundColor(.MyBlue)
                    }
                    .padding(.trailing, 30.0)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                ZStack
                {
                    RoundedRectangle(cornerRadius: 2).stroke(Color.MyGrey, lineWidth: 2)
                
                VStack(alignment: .leading)
                {
                    Text("Search Account")
                        .font(.largeTitle)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 40)
                    Spacer()
                    Text("Scan QR code or...")
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity, alignment: .center)
                    TextField("Enter Card ID...", text: $cardId)
                        .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.black, lineWidth: 1))
                        .padding(.horizontal, 20)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.vertical, 5)
                        .disableAutocorrection(true)
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
                            SearchFunc()
                        })
                        {
                            Text("Search")
                                .foregroundColor(.white)
                                .font(.largeTitle)
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 80, maxHeight: 80)
                                .background(RoundedCorners(color: .MyBlue, tl: 0, tr: 0, bl: 2, br: 2))
                        }
                    }
                    }
//                    ZStack
//                    {
//                        Text("")
//                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 82, maxHeight: 82)
//                            .background(RoundedCorners(color: .MyGrey, tl: 0, tr: 0, bl: 28, br: 28))
//                        Button(action: {}, label: {
//                            Text("Scan QR Code")
//                                .foregroundColor(.blue)
//                                .font(.largeTitle)
//                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 80, maxHeight: 80)
//                                .background(RoundedCorners(color: .white, tl: 0, tr: 0, bl: 28, br: 28))})
//
//                    }
                }
                }
                .padding(.horizontal,25)
                .frame(height: 250.0)
                .onAppear(perform: GetStoreAccount)
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
    
    func Back() -> Void{
        self.presentationMode.wrappedValue.dismiss()
    }
    func testJsonParse()
    {
        APIRequest().Post(withParameters: ["action":"get-user","session":account.SessionToken])
        {data in
            print(data + " ---- TestJsonParse() ----")
            DispatchQueue.main.async {
                if(data != "nosession" && data != "")
                {
                    let jsonData = data.data(using: .utf8)!
                    let test: Test = try! JSONDecoder().decode(Test.self, from: jsonData)
                    print(test.displayname)
                }
                else
                {
                    //fail
                }
            }
        }
    }
    struct Test: Decodable {
        var id: Int
        var displayname: String
        var type: String
        var lastactive: String
    }
    func SearchFunc(IsCust:Bool = false) -> Void{
        var val:String = cardId
        var key:String = "carduid"
        if(IsCust)
        {
            key = "cardholder"
            val = String(account.id)
        }
        APIRequest().Post(withParameters: ["action":"get-cardholder",key:val,"session":account.SessionToken])
        {data in
            DispatchQueue.main.async {
                if(data != "nosession" && data != "")
                {
                    print(data)
                    //load account
                    let jsonData = data.data(using: .utf8)!
                    let test: SearchedAccount = try! JSONDecoder().decode(SearchedAccount.self, from: jsonData)
                    //account.CardUId = cardId
                    assignAccount(withParameters: test)
                    GetRedeemables()
                    GetPlanDetails()
                }
                else
                {
                    //add card to store
                }
            }
        }
    }
    func GetRedeemables(){
        APIRequest().Post(withParameters: ["cardnumber":cardId],_url: "https://www.wavetoget.com/lib/form-checkcard.php")
        {data in
            DispatchQueue.main.async {
                if(data != "")
                {
                    print(data)
                    //load account
                    let jsonData = data.data(using: .utf8)!
                    let test: CheckCard = try! JSONDecoder().decode(CheckCard.self, from: jsonData)
                    assignRedeemable(cc: test)
                }
                else
                {
                    //add card to store
                }
            }
        }
    }
    func GetStoreAccount(){
        
        APIRequest().Post(withParameters: ["action":"get-store","session":account.SessionToken])
        {data in
            DispatchQueue.main.async {
                print(data)
                if(data != "nosession" && data != "")
                {
                    //load account
                    let jsonData = data.data(using: .utf8)!
                    let test: MyStoreAccount = try! JSONDecoder().decode(MyStoreAccount.self, from: jsonData)
                    assignStoreAccount(withParameters: test)
                    if(account.AccountType == "cardholder")
                    {
                        SearchFunc(IsCust: true)
                    }
                }
                else
                {
                    //no store found
                }
            }
        }
    }
    func GetPlanDetails(){
        
        APIRequest().Post(withParameters: ["action":"get-cardholder-plan","session":account.SessionToken, "cardholder":String(custAccount.id)])
        {data in
            DispatchQueue.main.async {
                if(data != "nosession" && data != "")
                {
                    print(data)
                    let jsonData = data.data(using: .utf8)!
                    let test: PlanDetails = try! JSONDecoder().decode(PlanDetails.self, from: jsonData)
                    assignPlanDetails(withParameters: test)
                    search = true
                }
                else
                {
                }
            }
        }
    }
    struct CheckCard: Decodable {
        var success: Bool?
        var message: String?
        var records: [Int]?
        var redeemables: [Redeemable]?
    }
    struct Redeemable: Decodable {
        var name: String?
        var description: String?
        var image: String?
        var points: Int?
    }
    func assignRedeemable(cc: CheckCard)
    {
        custAccount.redeemables.removeAll()
        if(cc.redeemables != nil)
        {
            for Redeemables in cc.redeemables! {
                custAccount.redeemables.append(AssignRedeemable(withParameters: Redeemables.name ?? "", description: Redeemables.description ?? "", image: Redeemables.image ?? "", points: Redeemables.points ?? 0))
            }
        }
    }
    func assignPlanDetails(withParameters sa: PlanDetails)
    {
        custAccount.planDetails = sa.details ?? ""
        custAccount.planName = sa.name ?? ""
        custAccount.planExpiry = sa.expirydate ?? ""
    }
    struct PlanDetails: Decodable {
        var name: String?
        var details: String?
        var startdate: String?
        var expirydate: String?
        var plan: Int?
        var id: Int?
    }
    func assignAccount(withParameters sa: SearchedAccount)
    {
        custAccount.id = sa.id ?? 0
        custAccount.user = sa.user ?? 0
        custAccount.firstname =  sa.firstname ?? ""
        custAccount.lastname =  sa.lastname ?? ""
        custAccount.middleinitials =  sa.middleinitials ?? ""
        custAccount.birthday =  sa.birthday ?? ""
        custAccount.address =  sa.address ?? ""
        custAccount.city =  sa.city ?? ""
        custAccount.province =  sa.province ?? ""
        custAccount.country =  sa.country ?? ""
        custAccount.postalcode =  sa.postalcode ?? ""
        custAccount.phone =  sa.phone ?? ""
        custAccount.sms_promo = sa.sms_promo ?? 0
        custAccount.pin =  sa.pin ?? ""
        custAccount.dollars =  Float(sa.dollars ?? "0") ?? 0
        custAccount.points = sa.points ?? 0
        custAccount.parent =  sa.parent ?? ""
        custAccount.group =  sa.group ?? ""
        custAccount.created =  sa.created ?? ""
        custAccount.updated =  sa.updated ?? ""
        custAccount.provCode =  sa.provCode ?? ""
        custAccount.provname =  sa.provname ?? ""
        custAccount.country_code =  sa.country_code ?? ""
        custAccount.country_name =  sa.country_name ?? ""
        custAccount.unix_birthday =  sa.unix_birthday ?? ""
        custAccount.parent_id =  sa.parent_id ?? ""
        custAccount.parent_firstname =  sa.parent_firstname ?? ""
        custAccount.parent_lastname =  sa.parent_lastname ?? ""
        custAccount.group_name =  sa.group_name ?? ""
        custAccount.group_logo =  sa.group_logo ?? ""
        custAccount.email =  sa.email ?? ""
        custAccount.type = sa.type ?? 0
        custAccount.store = sa.store ?? 0
        custAccount.active = sa.active ?? 0
        custAccount.stampsheets.removeAll()
        if(sa.stampsheets != nil)
        {
            for StampSheet in sa.stampsheets! {
                custAccount.stampsheets.append(AssignStampSheet(withParameters: StampSheet.stampsheet ?? 0, updated: StampSheet.updated ?? "", prize: StampSheet.prize ?? "", rewarded: StampSheet.rewarded ?? "", redeemed: StampSheet.redeemed ?? "", stamps: StampSheet.stamps ?? 0))
            }
        }
        custAccount.stamps.removeAll()
        if(sa.stamps != nil)
        {
            for Stamp in sa.stamps! {
                custAccount.stamps.append(AssignStamp(withParameters: Stamp.stampsheet ?? 0, rewardstatus: Stamp.rewardstatus ?? 0, created: Stamp.created ?? 0, updated: Stamp.updated ?? 0))
            }
        }
        custAccount.benefits.removeAll()
        if(sa.benefits != nil)
        {
            for Benefits in sa.benefits! {
                custAccount.benefits.append(AssignBenefit(withParameters: Benefits.id!, benefit: Benefits.benefit!, quantity: Benefits.quantity!, startdate: Benefits.startdate!, expirydate: Benefits.expirydate ?? "", description: Benefits.description!))
            }
        }
    }
    struct SearchedAccount: Decodable {
        var id: Int?
        var user: Int?
        var firstname: String?
        var lastname: String?
        var middleinitials: String?
        var birthday: String?
        var address: String?
        var city: String?
        var province: String?
        var country: String?
        var postalcode: String?
        var phone: String?
        var sms_promo: Int?
        var pin: String?
        var dollars: String?
        var points: Int?
        var parent: String?
        var group: String?
        var created: String?
        var updated: String?
        var provCode: String?
        var provname: String?
        var country_code: String?
        var country_name: String?
        var unix_birthday: String?
        var parent_id: String?
        var parent_firstname: String?
        var parent_lastname: String?
        var group_name: String?
        var group_logo: String?
        var email: String?
        var type: Int?
        var store: Int?
        var active: Int?
        var stampsheets: [StampSheet]?
        var stamps: [Stamp]?
        var benefits: [Benefits]?
//        var benifitid: Int?
//        var benefit: Int?
//        var quantity: Int?
//        var startdate: String?
//        var expirydate: String?
//        var description: String?
        
        //var meta: Meta?
    }
    struct StampSheet: Decodable {
        var stampsheet: Int?
        var updated: String?
        var prize: String?
        var rewarded: String?
        var redeemed: String?
        var stamps: Int?
    }
    struct Stamp: Decodable {
        var stampsheet: Int?
        var rewardstatus: Int?
        var created: Int?
        var updated: Int?
    }
    struct Benefits: Decodable {
        var id: Int?
        var benefit: Int?
        var quantity: Int?
        var startdate: String?
        var expirydate: String?
        var description: String?
    }
    struct Meta: Decodable {
    }
    func assignStoreAccount(withParameters sa: MyStoreAccount)
    {
        storeAccount.id = sa.id ?? 0
        storeAccount.name = sa.name ?? ""
        storeAccount.cardname = sa.cardname ?? ""
        storeAccount.shortcode = sa.shortcode ?? 0
        storeAccount.status = sa.status ?? 0
        storeAccount.publickey = sa.publickey ?? ""
        storeAccount.address = sa.address ?? ""
        storeAccount.city = sa.city ?? ""
        storeAccount.province = sa.province ?? ""
        storeAccount.country = sa.country ?? ""
        storeAccount.postalcode = sa.postalcode ?? ""
        storeAccount.phone = sa.phone ?? 0
        storeAccount.website = sa.website ?? ""
        storeAccount.created = sa.created ?? ""
        storeAccount.updated = sa.updated ?? ""
        storeAccount.cardduration = sa.cardduration ?? ""
        storeAccount.employee_timesheets = sa.employee_timesheets ?? ""
        storeAccount.interest_percent = sa.interest_percent ?? ""
        storeAccount.license_agreed = sa.license_agreed ?? 0
        storeAccount.local_currency = Float(sa.local_currency ?? "0") ?? 0
        storeAccount.local_language = sa.local_language ?? ""
        storeAccount.location_balance = Float(sa.location_balance ?? "0") ?? 0
        storeAccount.logo = sa.logo ?? ""
        storeAccount.mini_info = sa.mini_info ?? ""
        storeAccount.point_expand = Float(sa.point_expand ?? "0") ?? 0
        storeAccount.point_value = Float(sa.point_value ?? "0") ?? 0
        storeAccount.registration_nocard = sa.registration_nocard ?? ""
        storeAccount.stamp_times = Int(sa.stamp_times ?? "0") ?? 0
        storeAccount.tab_balance = Int(sa.tab_balance ?? "0") ?? 0
        storeAccount.tab_default = sa.tab_default ?? ""
        storeAccount.tab_dental = sa.tab_dental ?? ""
        storeAccount.tab_hide = Int(sa.tab_hide ?? "0") ?? 0
        storeAccount.tab_info = Int(sa.tab_info ?? "0") ?? 0
        storeAccount.tab_membership = Int(sa.tab_membership ?? "0") ?? 0
        storeAccount.tab_notes = Int(sa.tab_notes ?? "0") ?? 0
        storeAccount.tab_punchclock = Int(sa.tab_punchclock ?? "0") ?? 0
        storeAccount.tab_redeemables = Int(sa.tab_redeemables ?? "0") ?? 0
        storeAccount.tab_rewards = Int(sa.tab_rewards ?? "0") ?? 0
        storeAccount.theme_colour = sa.theme_colour ?? ""
        storeAccount.virtual_card_price = Float(sa.virtual_card_price ?? "") ?? 0
        storeAccount.stampsheets.removeAll()
        if(sa.stampsheets != nil)
        {
            for StoreStampSheet in sa.stampsheets! {
                storeAccount.stampsheets.append(AssignStampSheet(withParameters: StoreStampSheet.id ?? 0, prize: StoreStampSheet.prize ?? "", size: StoreStampSheet.size ?? 0, autostamp: StoreStampSheet.autostamp ?? 0, autoreward: StoreStampSheet.autoreward ?? 0, shape_id: StoreStampSheet.shape_id ?? 0, shape: StoreStampSheet.shape ?? ""))
            }
        }
        storeAccount.plans.removeAll()
        if(sa.plans != nil)
        {
            for Plan in sa.plans! {
                storeAccount.plans.append(AssignPlan(withParameters: Plan.id ?? 0, store: Plan.store ?? 0, name: Plan.name ?? "", term_months: Plan.term_months ?? 0, details: Plan.details ?? "", fallback_plan: Plan.fallback_plan ?? 0, created: Plan.created ?? "", updated: Plan.updated ?? ""))
            }
        }
    }
    struct MyStoreAccount: Decodable {
        var id: Int?
        var name: String?
        var cardname: String?
        var shortcode: Int?
        var status: Int?
        var publickey: String?
        var address: String?
        var city: String?
        var province: String?
        var country: String?
        var postalcode: String?
        var phone: Int?
        var website: String?
        var created: String?
        var updated: String?
        var cardduration: String?
        var employee_timesheets: String?
        var interest_percent: String?
        var license_agreed: Int?
        var local_currency: String?
        var local_language: String?
        var location_balance: String?
        var logo: String?
        var mini_info: String?
        var point_expand: String?
        var point_value: String?
        var registration_nocard: String?
        var stamp_times: String?
        var tab_balance: String?
        var tab_default: String?
        var tab_dental: String?
        var tab_hide: String?
        var tab_info: String?
        var tab_membership: String?
        var tab_notes: String?
        var tab_punchclock: String?
        var tab_redeemables: String?
        var tab_rewards: String?
        var theme_colour: String?
        var virtual_card_price: String?
        var stampsheets: [StoreStampSheet]?
        var plans: [Plan]?
    }
    struct StoreStampSheet: Decodable {
        var id: Int?
        var prize: String?
        var size: Int?
        var autostamp: Int?
        var autoreward: Int?
        var shape_id: Int?
        var shape: String?
    }
    struct Plan: Decodable {
        var id: Int?
        var store: Int?
        var name: String?
        var term_months: Int?
        var details: String?
        var fallback_plan: Int?
        var created: String?
        var updated: String?
    }
}


struct SearchCard_Preview: PreviewProvider {
    static var previews: some View {
        var account = Account()//just for preview
        SearchCard().environmentObject(account)
    }
}

//            ScrollView(showsIndicators: false) {
//                VStack(spacing: 20) {
//                    ForEach(0..<10) {
//                        Text("Store \($0)")
//                            .foregroundColor(.white)
//                            .font(.largeTitle)
//                            .frame(width: 390, height: 150)
//                            .background(Color.MyBlue)
//                    }
//                }
//            }.frame(height: 600)
