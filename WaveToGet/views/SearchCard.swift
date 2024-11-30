//
//  ClientHome.swift
//  wavetoget
//
//  Created by Jesse Lugassy on 2021-01-15.
//

import SwiftUI
import CodeScanner
import SwiftKeychainWrapper
import Combine

struct SearchCard: View {
    @State var cardId = ""
    @EnvironmentObject var account:Account
    @EnvironmentObject var custAccount:CustomerAccount
    @EnvironmentObject var storeAccount:StoreAccount
    @EnvironmentObject var sizing:Sizing
//    @ObservedObject private var inappPurchaseViewModel = InAppPurhaseViewModel()
    @EnvironmentObject var inAppPurchaseViewModel: InAppPurhaseViewModel
//    @EnvironmentObject private var storeManager: StoreManager
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var search = false
    @State var searchError = ""
    @State var perk = ""
    @State var perkError = ""
    @State var perkSuccess = false
    @State var buyCode = ""
    @State var isShowingScanner = false
    @State var goBack = false
    //@State var activity = false
    @State var setup = false
    @State var editProfile = false
    @State var more = false
    @State var convert = false
    @State var buying = false
    @State var loadBuy = false
    @State private var offset = CGSize.zero
    @State var refresh = false
    @State var activity = false
    @State var downloadQr = false
    @State var searcherr = false
    @State private var showingAlert = false
    @State var test = 0
    @State private var showAd = false
    @State private var haveSubscriptionForStoreOwner = false
    @State private var isLoading = false
    @State private var showSafari = false
    @State private var showReviewAlert = false
    @State private var reviewerFirstname = ""
    @State private var reviewerLastname = ""
    @State private var value: CGFloat = 0
//    @State private var showingCustomerInfoPage = false
    
    let textLimit = 10
    
    let defaultLocalizer = AMPLocalizeUtils.defaultLocalizer
    let inviteLocalizedText = "Invite"

    var model = ViewModelPhone()
    var body: some View {
            
                VStack
                {
                    
                    if account.isCust || haveSubscriptionForStoreOwner {
                        ZStack
                        {
                            VStack
                            {
                                if !account.isCust {
                                    
                                    HStack {
                                        Spacer()
                                        
                                        Text("REFERRAL AND REWARDS")
                                            .foregroundColor(.MyBlue)
                                            .font(.system(size: 18))
                                            .fontWeight(.semibold)
                                        
                                        Spacer()
                                    } //: HStack
                                    
                                }
                                
                                HStack
                                {
                                    ZStack
                                    {
                                        RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                            .stroke(Color.MyBlue, lineWidth: 2)
                                        //                                            .foregroundColor(.MyBlue)
                                        HStack
                                        {
                                            Text(account.isCust ? custAccount.firstname : storeAccount.name)
                                                .fontWeight(.bold)
                                                .foregroundColor(.MyBlue)
                                                .font(.system(size: 15))
                                                .frame(maxWidth: .infinity)
                                                .padding(.leading, 10.0)
                                            if(!account.isCust)
                                            {
                                                NavigationLink(destination: Setup(), isActive: $setup) {
                                                    Button(action: { setup = true })
                                                    {
                                                        Image("settings")
                                                            .resizable()
                                                        //                                                            .renderingMode(.template)
                                                            .scaledToFit()
                                                        //                                                            .foregroundColor(.MyBlue)
                                                            .frame(width: 25, height: 25)
                                                    }
                                                }.padding(.trailing, 10.0)
                                            }
                                            else{
                                                NavigationLink(destination: EditProfile(), isActive: $editProfile) {
                                                    Button(action: { editProfile = true
                                                        self.account.EditCust = self.account.isCust})
                                                    {
                                                        Image("settings")
                                                            .resizable()
                                                        //                                                            .renderingMode(.template)
                                                            .scaledToFit()
                                                        //                                                            .foregroundColor(.MyBlue)
                                                            .frame(width: 25, height: 25)
                                                    }
                                                }.padding(.trailing, 10.0)
                                            }
                                        } //: HStack
                                    } //: ZStack
                                    .frame(width: 165.0, height: 35)
                                    .padding([.top, .leading], 10.0)
                                    
                                    Spacer()
                                    
                                    if(!account.isCust && goBack)
                                    {
                                        NavigationLink(destination: Activity(), isActive: $activity) {
                                            Button(action: {
                                                account.currentPage = 4
                                            })
                                            {
                                                ZStack
                                                {
                                                    RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                                        .stroke(Color.MyBlue, lineWidth: 2)
                                                    //                                                        .foregroundColor(.MyBlue)
                                                        .frame(width: sizing.smallButtonWidth, height: 35)
                                                    
                                                    Text("ACTIVITY")
                                                        .fontWeight(.bold)
                                                        .foregroundColor(.MyBlue)
                                                        .font(.system(size: 15))
                                                }
                                                .frame(alignment: .trailing)
                                                .padding(.top, 10.0)
                                            }
                                        }
                                    }
                                    else if (account.isCust)
                                    {
                                        NavigationLink(destination: DownloadQr(), isActive: $downloadQr) {
                                            Button(action: {
                                                downloadQr = true
                                            })
                                            {
                                                ZStack
                                                {
                                                    RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                                        .stroke(Color.MyBlue, lineWidth: 2)
                                                    //                                                        .foregroundColor(.MyBlue)
                                                        .frame(width: sizing.smallButtonWidth, height: 35)
                                                    
                                                    Text(defaultLocalizer.stringForKey(key: inviteLocalizedText))
                                                        .fontWeight(.bold)
                                                        .foregroundColor(.MyBlue)
                                                        .font(.system(size: 15))
                                                }
                                                .frame(alignment: .trailing)
                                                .padding(.top, 10.0)
                                            }
                                        }
                                    }
                                    
                                    Spacer()
                                    
                                    Button(action: {Back()}, label: {
                                        ZStack
                                        {
                                            RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                                .stroke(Color.MyBlue, lineWidth: 2)
                                            //                                                .foregroundColor(.MyBlue)
                                                .frame(height: 35)
                                                .frame(maxWidth: sizing.wideButtonWidth)
//                                                .frame(width: sizing.wideButtonWidth, height: 35)
                                            
                                            Text(goBack ? "SEARCH" : defaultLocalizer.stringForKey(key: "Log out"))
                                                .fontWeight(.bold)
                                                .foregroundColor(.MyBlue)
                                                .font(.system(size: 14))
                                                .lineLimit(1)
                                                .frame(maxWidth: sizing.wideButtonWidth)
//                                                .frame(width: sizing.smallButtonWidth)
                                        }
                                        .frame(alignment: .trailing)
                                        .padding([.top, .trailing], 10.0)
                                    })
                                } //: HStack
                                if(account.isCust)
                                {
                                    
                                    CustomerQR(QrString: $custAccount.phone)
                                    //.padding(.vertical)
                                    
                                }
                                else
                                {
                                    
                                    NavigationView{
                                        VStack
                                        {
//                                            Spacer()
                                            Text(defaultLocalizer.stringForKey(key: "Search Account"))
                                                .font(.system(size: 25))
                                            
                                            TextField("\(defaultLocalizer.stringForKey(key: "Enter account number"))...", text: $cardId)
                                                .font(.system(size: 15))
                                                .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                                                .padding(.horizontal, 20)
                                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                                .padding(.top, 5)
                                                .keyboardType(.numberPad)
                                                .onReceive(Just(cardId), perform: { _ in
                                                    limitText(limit: textLimit, value: &cardId)
                                                })
//                                                .disableAutocorrection(true)
//                                                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                                .alert(isPresented: $searcherr) { // 4
                                                    
                                                    Alert(
                                                        title: Text(searchError)
                                                    )
                                                }.padding()
                                            HStack
                                            {
                                                Button(
                                                    action: {buying = false;ReadQr()},label:{
                                                        ZStack
                                                        {
                                                            RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                                                .stroke(Color.MyBlue, lineWidth: 2)
                                                            //                                                                    .foregroundColor(.MyBlue)
                                                            VStack
                                                            {
                                                                Text(defaultLocalizer.stringForKey(key: "SCAN QR CODE"))
                                                                    .font(.system(size: 15))
                                                                    .fontWeight(.semibold)
                                                                    .foregroundColor(.MyBlue)
                                                                    .padding([.top, .leading, .trailing])
                                                                Image("qrIcon")
                                                                    .resizable()
                                                                    .scaledToFit()
                                                                    .padding([.leading, .bottom, .trailing], 10.0)
                                                            }
                                                        }
                                                    })
                                                .sheet(isPresented: $isShowingScanner)
                                                {
                                                    CodeScannerView(codeTypes: [.qr], simulatedData: "TEST DATA",completion: self.HandleScan)
                                                }
                                                NavigationLink(destination: CustomerAccountView(goBack:$goBack), isActive: $search) {
                                                    Button(action: {
                                                        SearchFunc()
                                                    })
                                                    {
                                                        ZStack
                                                        {
                                                            RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                                                .stroke(Color.MyBlue, lineWidth: 2)
                                                            //                                                                    .foregroundColor(.MyBlue)
                                                            VStack
                                                            {
                                                                Text(defaultLocalizer.stringForKey(key: "SEARCH"))
                                                                    .font(.system(size: 15))
                                                                    .fontWeight(.semibold)
                                                                    .foregroundColor(.MyBlue)
                                                                    .padding([.top, .leading, .trailing])
                                                                Image("search")
                                                                    .resizable()
                                                                    .renderingMode(.template)
                                                                    .scaledToFit()
                                                                    .foregroundColor(.MyBlue)
                                                                    .padding([.leading, .bottom, .trailing], 30.0)
                                                                    .padding(.top,5)
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                            .padding(.horizontal, 10.0)
                                            .frame(height: 120.0)
                                            
                                            Text(defaultLocalizer.stringForKey(key: "Scan QR code or type and search"))
                                                .font(.system(size: 15))
                                                .padding(.vertical, 10)
                                                .foregroundColor(.MyBlue)
                                            
                                            if UIDevice.current.orientation.isLandscape || account.Landscape || UIScreen.main.bounds.size.width > UIScreen.main.bounds.size.height {
                                                Spacer()
                                            }
                                            
                                        } //: VStack
                                        .onAppear {
                                            account.infoPage = 9
                                        }
                                    }
                                    
                                    
                                    
                                }
                            }
                            
                            // Input Alert
                            InputAlertView(title: "In order to get the reward:", isShown: $showReviewAlert, text1: $reviewerFirstname, text2: $reviewerLastname, onDone: { (text1, text2) in
                                sendReviewerInfo(firstName: text1, lastName: text2)
                                                })
                        }
                        
                        if(account.isCust)
                        {
                            VStack
                            {
                                ZStack
                                {
                                    HStack()
                                    {
                                        NavigationLink(destination: CustomerConvert(), isActive: $convert) {
                                            Button(action: { convert = true
                                            })
                                            {
                                                ZStack
                                                {
                                                    RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                                        .stroke(Color.MyBlue, lineWidth: 2)
                                                    //                                                        .foregroundColor(.MyBlue)
                                                        .frame(width: 90, height: 80)
                                                    VStack
                                                    {
                                                        Text(defaultLocalizer.stringForKey(key: "Convert"))
                                                            .fontWeight(.bold)
                                                            .foregroundColor(.MyBlue)
                                                            .font(.system(size: 15))
                                                        Image("convert")
                                                            .resizable()
                                                            .renderingMode(.template)
                                                            .scaledToFit()
                                                            .foregroundColor(.MyBlue)
                                                            .frame(maxWidth: 35, maxHeight: 35)
                                                            .padding(.top, -5.0)
                                                    }
                                                }
                                            }
                                        }
                                        VStack(alignment: .leading, spacing:0)
                                        {
                                            HStack{
                                                Text(String(custAccount.points))
//                                                    .font(.system(size: 30))
                                                    .font(.system(size: 17))
                                                    .allowsTightening(true)
                                                Text("pts")
                                                    .font(.system(size: 15))
                                                    .lineLimit(1)
                                                    .allowsTightening(true)
                                                //.frame(maxHeight: 30, alignment: .bottom)
                                            }
                                            
                                            Text("$" + String(format: "%.2f",custAccount.dollars) )
//                                                .font(.system(size: 30))
                                                .font(.system(size: 17))
                                                .allowsTightening(true)
                                            //                                    if(custAccount.referraltotal > 0)
                                            //                                    {
                                            HStack{
                                                Text("$" + String(format: "%.2f",custAccount.referraltotal))
//                                                    .font(.system(size: 30))
                                                    .font(.system(size: 17))
                                                    .allowsTightening(true)
                                                Text(defaultLocalizer.stringForKey(key: "Referral"))
                                                    .font(.system(size: 15))
                                                    .lineLimit(1)
                                                    .allowsTightening(true)
                                                //.frame(maxHeight: 30, alignment: .bottom)
                                            }
                                            //}
                                        }
                                        Spacer()
                                        VStack
                                        {
                                            Button(
                                                action: {buying = true
                                                    ReadQr()},label:{
                                                        ZStack
                                                        {
                                                            RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                                                .stroke(Color.MyBlue, lineWidth: 2)
                                                            //                                                                .foregroundColor(.MyBlue)
                                                                .frame(maxWidth: 90, maxHeight: 35)
                                                            
                                                            Text(defaultLocalizer.stringForKey(key: "Pay QR"))
                                                                .fontWeight(.bold)
                                                                .foregroundColor(.MyBlue)
                                                                .font(.system(size: 15))
                                                        }
                                                    })
                                            .sheet(isPresented: $isShowingScanner)
                                            {
                                                CodeScannerView(codeTypes: [.qr], simulatedData: "testItem 20 dollars",completion: self.HandleScan)
                                            }
                                            NavigationLink(destination: MoreInfo(), isActive: $more) {
                                                Button(action: { more = true
                                                })
                                                {
                                                    ZStack
                                                    {
                                                        RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                                            .stroke(Color.MyBlue, lineWidth: 2)
                                                        //                                                            .foregroundColor(.MyBlue)
                                                            .frame(maxWidth: 90, maxHeight: 35)
                                                        
                                                        Text(defaultLocalizer.stringForKey(key: "More"))
                                                            .fontWeight(.bold)
                                                            .foregroundColor(.MyBlue)
                                                            .font(.system(size: 15))
                                                        ZStack
                                                        {
                                                            Image("back")
                                                                .resizable()
                                                                .scaledToFit()
                                                                .rotationEffect(.degrees(180))
                                                                .frame(maxWidth: 12.0, maxHeight: 12.0)
                                                        }
                                                        .frame(maxWidth:70, alignment: .trailing)
                                                        ZStack
                                                        {
                                                            if(account.newMessage)
                                                            {
                                                                Ellipse()
                                                                    .fill(Color.red)
                                                                    .frame(maxWidth: 20, maxHeight: 20)
                                                            }
                                                        }.frame(maxWidth:90, alignment: .trailing)
                                                            .padding(.bottom, 15.0)
                                                    }
                                                }
                                            }
                                            
                                        } //: VStack
                                        .onAppear {
                                            account.infoPage = 4
                                        }
//                                        .popover(isPresented: $showingCustomerInfoPage) {
//                                            CustomerHomePopoverContent(presentMe: $showingCustomerInfoPage)
//                                        }
                                    }
                                }
                                .padding(10)
                            }
                            .frame(maxWidth: .infinity)
                            //                            .overlay(//fixed visual bug when putting it in first ZStack
                            //                                RoundedRectangle(cornerRadius: 2)
                            //                                    .stroke(Color.MyGrey, lineWidth: 2)
                            //                            )
                            .onAppear {
                                showAd = false // TODO: change this logic to display it once
                            }
                  
                            VStack(spacing:0)
                            {
                                Text(defaultLocalizer.stringForKey(key: "Scan QR or enter offer code to claim perks"))
                                    .lineLimit(nil)
                                    .font(.system(size: 15))
//                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 10.0)
                                    .padding(.top, 5)
                                    .padding(.bottom, 5)
                                    .foregroundColor(Color.LoginLinks)
                                HStack(spacing: 0)
                                {
                                    Button(
                                        action: {buying = false;ReadQr()},label:{
                                            ZStack
                                            {
                                                RoundedRectangle(cornerRadius: sizing.smallCornerRadius)
                                                    .stroke(Color.MyGrey, lineWidth: 2)
                                                    .frame(width: 35, height: 35)
                                                Image("qrcust")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 33.0, height: 33.0)
                                            }
                                        })
                                    .padding(.leading, 10)
                                    .sheet(isPresented: $isShowingScanner)
                                    {
                                        CodeScannerView(codeTypes: [.qr], simulatedData: "TEST DATA",completion: self.HandleScan)
                                    }
                                    TextField(defaultLocalizer.stringForKey(key: "Enter offer code here"), text: $perk)
                                        .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                                        .padding(.leading, 5)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .disableAutocorrection(true)
                                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                        .font(.system(size: 15))
                                    
                                    Button(action: {RedeemPerk()}, label: {
                                        Text(defaultLocalizer.stringForKey(key: "Get"))
                                            .foregroundColor(.MyBlue)
                                            .fontWeight(.bold)
                                            .font(.system(size: 17))
                                            .frame(width: 90, height: 35)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 5)
                                                    .stroke(Color.MyBlue, lineWidth: 2)
                                            )
                                        //.background(RoundedCorners(color: .MyBlue, tl: 0, tr: 4, bl: 0, br: 4))
                                        
                                    })
                                    .padding(.trailing,10)
                                    .alert(isPresented: $searcherr) {
                                        
                                        Alert(
                                            title: Text(searchError)
                                        )
                                    }.padding()
                                    
                                }
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: 2)
                                    .stroke(Color.MyGrey, lineWidth: 2)
                            )
                            VStack(spacing:0)
                            {
                                
                                ForEach(0..<storeAccount.stampsheets.count, id: \.self)
                                { i in
                                    var temp:[Stamp] = getArray(i: i)
                                    HStack(spacing:0)
                                    {
                                        ForEach(0..<storeAccount.stampsheets[i].size, id: \.self){ j in
                                            
                                            Image("star")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: account.Ipad ? sizing.ipadStarSize : sizing.starSize, height: account.Ipad ? sizing.ipadStarSize : sizing.starSize)
                                                .colorMultiply(temp.count > j ? .MyBlue : .MyGrey)
                                                .padding(.horizontal, 5.0)
                                        }
                                    }
                                }
                            }
                            .frame(maxWidth:.infinity)
                            .frame(height:50)
                            .overlay(
                                RoundedRectangle(cornerRadius: 2)
                                    .stroke(Color.MyGrey, lineWidth: 2))
                        }
                        
                        NavigationLink(destination: EditProfile(), isActive: $account.settings)
                        {
                            ZStack
                            {
                                
                            }
                        }
                        .hidden()
                        NavigationLink(destination: Buy(code: $buyCode), isActive: $loadBuy)
                        {
                            ZStack
                            {
                                
                            }
                        }
                        .hidden()
                        
                        Spacer()
                    }
                    
                    else {
                        if !isLoading {
                            RevenueCatSubscriptionView()
                        }   
                    }
                    
                    
                } //: VStack
                .onAppear(perform: account.isCust ? initCardholder : GetStoreAccount)
                .onAppear(perform: {account.loadedAcc = true})
//                .padding([.top, .leading, .trailing],10)
                .navigationBarTitle("")
                .navigationBarHidden(true)
                .navigationViewStyle(StackNavigationViewStyle())
                .offset(y: -self.value)
//                .animation(.spring())
                .onAppear{
                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { noti in
//                        let value = noti.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
//                        let height = value.height
//
//                        self.value = height
                        self.value = account.Ipad ? 20 : 0
                        
                    }
                    
                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { noti in
                        self.value = 0
                    }
                    
                }
        
//                .offset(x: 0, y: offset.height / 10)
//                .gesture( account.isCust ?
//                          DragGesture()
//                    .onChanged { gesture in
//                        self.offset = gesture.translation
//                        if abs(self.offset.height) > 100
//                        {
//                            refresh = true
//                        }
//                    }
//
//                    .onEnded { _ in
//                        if abs(self.offset.height) > 100 {
//                            // remove the card
//                            self.offset = .zero
//                            refresh = false
//                            SearchFunc()
//                        } else {
//                            self.offset = .zero
//                            refresh = false
//                        }
//                    } : nil
//                )
//                if(refresh)
//                {
//                    GIFView(gifName: "loading")
//                        .frame(width: 40.0, height: 40.0)
//                        .frame(maxHeight: .infinity, alignment: .top)
//                }
    } //: body
    
    func sendMessage() {
        
        var sms = "sms:&body=Join me to get a $10 reward. Download ReferralAndRewards app and register to \(custAccount.store) with my reference number \(custAccount.phone)"
        
//        APIRequest().Post(withParameters: ["action":"get","id":String(account.store),"session":account.SessionToken], _url: SmsAPI.GET_SMS_TEXT)
        APIRequest().Post(withParameters: ["action":"get","id":String(account.store)], _url: SmsAPI.GET_SMS_TEXT)
        {data in
            DispatchQueue.main.async {
                print("\n-----------test----------\n" + data + "\n-----------test----------")
                if(data != "failed" && data != "nosession" && data != "[]")
                {
                    let jsonData = data.data(using: .utf8)!
                    let test: SmsObject = try! JSONDecoder().decode(SmsObject.self, from: jsonData)
                    print("DEBUG: SmsObject = \(test)")
                    //messageList = test
                    
                    sms = "sms:&body=\(test.msg ?? "") (Use the reference number: \(custAccount.phone) for store named: \(test.store_name ?? String(custAccount.store))"
                    let strURL = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                    UIApplication.shared.open(URL(string: strURL)!, options: [:], completionHandler: nil)
                }
            }
        }
                
    }
    
    func sendReviewerInfo(firstName: String, lastName: String) {
        print("DEBUG: Reviewer is \(firstName) \(lastName)")
        
        let compName = "infoEmpire"
        
        APIRequest().Post(withParameters: ["":""],_url: "\(ReviewAPI.CHECK_REVIEWS)?comp_name=\(compName)&first_name=\(firstName)&last_name=\(lastName)")
        {data in
//            DispatchQueue.main.async {
//                if(data != "false" && data != "" && data != "nosession" && data != "[]")
//                {
//                    let jsonData = data.data(using: .utf8)!
//                    let test: [acc] = try! JSONDecoder().decode([acc].self, from: jsonData)
//                    //print(test)
//                    accountList = test
//                    if(accountList.count > 0)
//                    {
//                        selectedAccount = accountList[0]
//                    }
//
//                }
//                else
//                {
//
//                }
//            }
            
            // TODO: I only need to call the API and backend should determine if the reward will be sent. Maybe return true or false based on the reward is sent or not.
        }
    }

    func GetStoreMessage() -> Void{
        APIRequest().Post(withParameters: ["action":"get-storemessages","id":String(account.store),"session":account.SessionToken])
        {data in
            DispatchQueue.main.async {
                print("\n-----------test----------\n" + data + "\n-----------test----------")
                if(data != "failed" && data != "nosession" && data != "[]")
                {
                    let jsonData = data.data(using: .utf8)!
                    let test: [MessageObj] = try! JSONDecoder().decode([MessageObj].self, from: jsonData)
                    //print(test)
                    //messageList = test
                    account.messages.removeAll()
                    
                    for message in test {
                        account.messages.append(AssignMessage(withParameters: message.id ?? 0, store: message.store ?? 0, message: message.message ?? "" , created: message.created ?? ""))
                    }
                    for newMess in account.lastMessages
                    {
                        if(newMess.store == account.store && newMess.id == account.messages[account.messages.count - 1].id)
                        {
                            account.newMessage = false
                            return
                        }
                    }
                    account.newMessage = true
                }
                else
                {
                    account.newMessage = false
                }
            }
        }
    }
    struct MessageObj: Decodable {
        var id: Int?
        var store: Int?
        var message: String?
        var created: String?
    }
    struct SmsObject: Decodable {
//        var id: Int?
        var msg: String?
        var store_name: String?
    }
    func ReadQr()
    {
        self.isShowingScanner = true
    }
    func HandleScan(result: Result<String, CodeScannerView.ScanError>) {
        self.isShowingScanner = false
        switch result {
        case .success(let code):
            print(code)
            if(account.isCust)
            {
                if(buying)
                {
                    APIRequest().Post(withParameters: ["action":"get-storeitem","session":account.SessionToken,"id":code])
                    {data in
                        print(data + " ---- TestJsonParse() ----")
                        DispatchQueue.main.async {
                            if(data != "nosession" && data != "" && data != "[]")
                            {
                                let jsonData = data.data(using: .utf8)!
                                let test: storeItem = try! JSONDecoder().decode(storeItem.self, from: jsonData)
                                
                                var codeString = (test.code ?? "") + "`"
                                codeString += (test.amount ?? "") + "`" + (test.type ?? "") + "`"
                                codeString += String(test.id ?? 0) + "`" + String(test.quantity ?? 0)
                                loadBuy = true
                                buyCode = codeString
                            }
                        }
                    }
                }
                else
                {
                    perk = code
                    RedeemPerk()
                }
            }
            else
            {
                cardId = code
                SearchFunc()
            }
        case .failure(let error):
            print("Scan Failed")
        }
    }
    struct storeItem: Decodable {
        var id: Int?
        var store: Int?
        var code: String?
        var amount: String?
        var type: String?
        var quantity: Int?
        var active: Int?
        var created: String?
    }
    func getArray(i:Int)->[Stamp]
    {
        var array:[Stamp] = []
        for stamp in custAccount.stamps {
            if(stamp.stampsheet == storeAccount.stampsheets[i].id)
            {
                array.append(stamp)
            }
        }
        return array
    }
    func SendToWatch()
    {
        if self.model.session.isReachable{
            self.model.session.sendMessage(["phone" : custAccount.phone, "dollars" : String(custAccount.dollars), "points" : String(custAccount.points)], replyHandler: nil) { (error) in
                print(error.localizedDescription)
            }
            print("send to watch")
        }
        else
        {
            print("watch not reachable")
        }
    }
    func Back() -> Void{
        if(!goBack)
        {
            self.presentationMode.wrappedValue.dismiss()
            account.loadedAcc = false
        }
        goBack = !goBack
        cardId = ""
    }
    func RedeemPerk()
    {
        if(perk != "")
        {
            APIRequest().Post(withParameters: ["action":"redeem-offercode","session":account.SessionToken,"cardholder":String(custAccount.id),"code":perk])
            {data in
                print(data + " ---- TestJsonParse() ----")
                DispatchQueue.main.async {
                    if(data != "nosession" && data != "" && data != "\"failed\"" && data != "false")
                    {
                        let jsonData = data.data(using: .utf8)!
                        let test: RedeemedPerk = try! JSONDecoder().decode(RedeemedPerk.self, from: jsonData)
                        
                        test.type == "points" ? (custAccount.points += Int(Float(test.amount) ?? 0)) : (custAccount.dollars += Float(test.amount) ?? 0)
                        print(Int(Float(test.amount) ?? 0))
                        searchError = test.amount + " " + test.type + " claimed!"
                        searcherr = true
                    }
                    else
                    {
                        searchError = "failed to claim..."
                        searcherr = true
                    }
                }
            }
            perk = ""
        }
    }
    
    // In-app Purchase DB Functions - TEST
//    func addSubscriptionToDB() {
//        
//        let params = ["action": "subscribe",
//                      "id": String(account.store)]
//        
//        APIRequest().Post(withParameters: params)
//        {data in
//            DispatchQueue.main.async {
//                if(data == "success")
//                {
//                    self.dbError = ""
//                }
//                else
//                {
//                    self.dbError = data
//                }
//            }
//        }
//    }
//    
//    func fetchSubscriptionStatusFromDB() {
//        
//        let params = ["action": "is-subscribed",
//                      "id": String(account.store)]
//        APIRequest().Post(withParameters: params)
//        {data in
//            DispatchQueue.main.async {
//                if(data != "false")
//                {
//                    self.dbError = ""
//                }
//                else
//                {
//                    self.dbError = data
//                }
//            }
//        }
//        
//        
//    }
    
    
    
    struct RedeemedPerk: Decodable {
        var type: String
        var amount: String
    }
    func initCardholder()
    {
        SearchFunc()
    }
    func SearchFunc() -> Void{
        var val:String = cardId
        if(account.isCust)
        {
            val = String(account.id)
        }
        APIRequest().Post(withParameters: ["action":"get-cardholder","val":val,"store":String(account.store),"session":account.SessionToken])
        {data in
            DispatchQueue.main.async {
                print("DEBUG: data in SearchCard.SearchFunc is \(data)")
                if(data != "msg:Card not found" && data != "" && data != "failed" && data != "nosession" )
                {
                    searchError = ""
                    print(data)
                    //load account
                    let jsonData = data.data(using: .utf8)!
                    let test: SearchedAccount = try! JSONDecoder().decode(SearchedAccount.self, from: jsonData)
                    //account.CardUId = cardId
                    assignAccount(withParameters: test)
                    GetPlanDetails()
                    if(!account.isCust)
                    {
                        goBack = true
                    }
                    else
                    {
                        GetStoreAccount()
                        GetStoreMessage()
                        SendToWatch()
                    }
                    Getreferrals()
                    //GetStoreReferral()
                }
                else
                {
                    searcherr = true
                    searchError = "Account not found at this store...";
                }
            }
        }
    }
    func GetRedeemables(){
        test += 1
        print(String(test) + "TEST.............")
        APIRequest().Post(withParameters: ["action":"get-store-redeemables","session":account.SessionToken,"store":String(storeAccount.id)])
        {data in
            DispatchQueue.main.async {
                if(data != "" && data != "nosession")
                {
                    print(data)
                    //load account
                    let jsonData = data.data(using: .utf8)!
                    let test: [Redeemable] = try! JSONDecoder().decode([Redeemable].self, from: jsonData)
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
        isLoading = true
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
                    
                    // Fetch subscription status from DB
                    inAppPurchaseViewModel.fetchSubscriptionStatusFromDB(storeID: storeAccount.id) { isSubscribed in
                        isLoading = false
                        self.haveSubscriptionForStoreOwner = isSubscribed
                    }
                    
                    GetRedeemables()
                    GetStoreReferral()
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
    func GetStoreReferral() -> Void{
        var sto = 0
        if(storeAccount.id != 0 )
        {
            sto = storeAccount.id
        }
        if(custAccount.store != 0 )
        {
            sto = custAccount.store
        }
        APIRequest().Post(withParameters: ["action":"get-referral","store":String(sto),"session":account.SessionToken])
        {data in
            DispatchQueue.main.async {
                if(data != "[]")
                {
                    print("\n-----------test----------\n" + data + "\n-----------test----------")
                    print(data)
                    let jsonData = data.data(using: .utf8)!
                    let testee: [storeref] = try! JSONDecoder().decode([storeref].self, from: jsonData)
                    let test = testee[0]
                    storeAccount.ref = AssignStoreReferral(withParameters: test.id ?? 0, senderamount: test.senderamount ?? "", recieveramount: test.recieveramount ?? "", name: test.name ?? "", message: test.message ?? "")
                    Getreferrals()
                }
            }
        }
    }
    func Getreferrals(){
        custAccount.referraltotal = 0
        if(custAccount.store == 0)
        {
            return
        }
        APIRequest().Post(withParameters: ["action":"get-customer-referrals","session":account.SessionToken,"store":String(custAccount.store), "phone":String(custAccount.phone)])
        {data in
            DispatchQueue.main.async {
                if(data != "nosession" && data != "")
                {
                    print(data)
                    let jsonData = data.data(using: .utf8)!
                    let test: [Referral] = try! JSONDecoder().decode([Referral].self, from: jsonData)
                    assignReferrals(cc: test)
                    
                    for ref in custAccount.referrals {
                        if(ref.reciever == Int(custAccount.phone) && ref.claimed == 1)
                        {
                            custAccount.referraltotal += storeAccount.ref.recieveramount
                            print(String(custAccount.referraltotal) + " referal total " + String(storeAccount.ref.recieveramount) + " amount")
                        }
                        if(ref.sender == Int(custAccount.phone) && ref.claimed == 0)
                        {
                            custAccount.referraltotal += storeAccount.ref.senderamount
                            print(String(custAccount.referraltotal) + " referal total " + String(storeAccount.ref.senderamount) + " amount")
                        }
                    }
                }
                else
                {
                }
            }
        }
    }
    struct storeref: Decodable {
        var id: Int?
        var senderamount: String?
        var recieveramount: String?
        var name: String?
        var message: String?
    }
    struct Redeemable: Decodable {
        var id: Int?
        var name: String?
        var description: String?
        var image: String?
        var points: Int?
    }
    func assignRedeemable(cc: [Redeemable])
    {
        storeAccount.redeemables.removeAll()
        for Redeemables in cc {
            storeAccount.redeemables.append(AssignRedeemable(withParameters: Redeemables.id ?? 0, name: Redeemables.name ?? "", description: Redeemables.description ?? "", image: Redeemables.image ?? "", points: Redeemables.points ?? 0))
        }
    }
    func assignReferrals(cc: [Referral])
    {
        custAccount.referrals.removeAll()
        for Referrals in cc {
            custAccount.referrals.append(Assignreferral(withParameters: Referrals.id ?? 0, sender: Referrals.sender ?? 0, reciever: Referrals.reciever ?? 0,  claimed: Referrals.claimed ?? 0))
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
        custAccount.province =  sa.province ?? 0
        custAccount.country =  sa.country ?? 0
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
        custAccount.unix_birthday =  sa.unix_birthday ?? 0
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
    
    //Function to keep text length in limits
    func limitText(limit upper: Int, value: inout String) {
        if value.count > upper {
            value = String(value.prefix(upper))
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
        var province: Int?
        var country: Int?
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
        var unix_birthday: Int?
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
        var stamps: [Stamp_]?
        var benefits: [Benefit]?
    }
    struct StampSheet: Decodable {
        var stampsheet: Int?
        var updated: String?
        var prize: String?
        var rewarded: String?
        var redeemed: String?
        var stamps: Int?
    }
    struct Stamp_: Decodable {
        var stampsheet: Int?
        var rewardstatus: Int?
        var created: Int?
        var updated: Int?
    }
    struct Benefit: Decodable {
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
        storeAccount.shortcode = sa.shortcode ?? ""
        storeAccount.status = sa.status ?? 0
        storeAccount.publickey = sa.publickey ?? ""
        storeAccount.address = sa.address ?? ""
        storeAccount.city = sa.city ?? ""
        storeAccount.province = sa.province ?? 0
//        storeAccount.country = sa.country ?? ""
        storeAccount.country = sa.country ?? 0
        storeAccount.postalcode = sa.postalcode ?? ""
        storeAccount.GoogleReviewURL = sa.GoogleReviewURL ?? "" // assign Google Review URL here
        storeAccount.phone = sa.phone ?? ""
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
        var shortcode: String?
        var status: Int?
        var publickey: String?
        var address: String?
        var city: String?
        var province: Int?
//        var country: String?
        var country: Int?
        var postalcode: String?
        var GoogleReviewURL: String?
        var phone: String?
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
    struct Referral: Decodable {
        var id: Int?
        var store: Int?
        var sender: Int?
        var reciever: Int?
        var claimed: Int?
        var created: String?
    }
}

// Help Button Popover view
struct CustomerHomePopoverContent: View {
   
    @Binding var presentMe : Bool
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 20) {
            
            HStack {
                
                Text("Home Page")
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
            
//            Spacer()
            
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
            
            Text("In the middle of the page, you will see your Personal QR-code, which the store can scan to see your account information when you visit them or they can find you by phone number. Also, have an opportunity to convert dollars into points and vice versa. To the left of your balance, there is a 'CONVERT' button.")
//                .font(.body)
//                .padding(.vertical, 20)
            
            Text("You can find QR-scanner (to the bottom left) to add points (or virtual dollars) to your account. Or you can manually enter the offer code to get points. After you enter the code, click 'GET' button. And the points or virtual dollars will be displayed on your Home Page below your Personal QR-code.")
//                .font(.body)
//                .padding(.vertical, 20)
            
            Text("Another interesting function is the ability to pay with QR-code. To make a purchase at the store simply click the 'PAY QR' button to the right of your account balance.A phone camera will show up where you can point it to QR code to redeem points/dollars and purchase a product.")
//                .font(.body)
//                .padding(.vertical, 20)
            
            Text("At the very bottom of the Home Page, you will notice stars. This is a Rewards Chart, after a certain amount of visits or purchases at the store, you will collect stamps that will allow you to get eligible rewards.")
//                .font(.body)
//                .padding(.vertical, 20)
            
            Text("A referral number is a phone number mentioned in your account info. The only thing you need to do is share the number with your friends, family, and colleagues. If those people will enter your referral number while registering in the app both of you will get the bonus!")
//                .font(.body)
//                .padding(.vertical, 20)
            
            Text("To edit account credentials click the button with your name on the top left corner.  To log out, go to Home Page and click the 'LOG OUT' button in the top right corner.")
//                .font(.body)
//                .padding(.vertical, 20)
            
           
            
        }
        .font(.caption)
        .padding()
    }
}


//struct SearchCard_Preview: PreviewProvider {
//    static var previews: some View {
//        var store = StoreAccount()
//        var cust = CustomerAccount()
//        var account = Account()//just for preview
//        SearchCard().environmentObject(account).environmentObject(cust).environmentObject(store)
//    }
//}

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
