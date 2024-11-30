//
//  MoreInfo.swift
//  wavetoget
//
//  Created by Jesse Lugassy on 2021-03-26.
//

import SwiftUI

struct MoreInfo: View {
    @EnvironmentObject var account:Account
    @EnvironmentObject var custAccount:CustomerAccount
    @EnvironmentObject var storeAccount:StoreAccount
    @EnvironmentObject var sizing:Sizing
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var notesList: [NoteObj] = []
    @State var activity = false
    @State var messages = false
    @State var errorText = ""
    @State private var showSafari = false
    @State private var showReviewAlert = false
    @State private var reviewerFirstname = ""
    @State private var reviewerLastname = ""
    @State private var hasGoogleReviewError = false
    @State private var googleReviewErrorMessage = ""
    
    let defaultLocalizer = AMPLocalizeUtils.defaultLocalizer
    
    var body: some View {
        ZStack {
            VStack
            {
                VStack(spacing:0)
                {
                    Text(defaultLocalizer.stringForKey(key: "Rewards Chart"))
                        .font(.system(size: 17))
                    
                    Text(errorText)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundColor(.red)
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
                        HStack(alignment:.lastTextBaseline, spacing: 0)
                        {
                            if(storeAccount.stampsheets[i].size > temp.count)
                            {
                                Text("\(defaultLocalizer.stringForKey(key: "Collect")) " + String(storeAccount.stampsheets[i].size - temp.count) + " \(defaultLocalizer.stringForKey(key: "more to get your")) ")
                                    .font(.system(size: 13))
                            }
                            else
                            {
                                Text("\(defaultLocalizer.stringForKey(key: "You can now claim your")) ")
                                    .font(.system(size: 13))
                            }
                            Text(storeAccount.stampsheets[i].prize)
                                .font(.system(size: 15))
                                .fontWeight(.bold)
                                .foregroundColor(.MyBlue)
                                .textCase(.uppercase)
                        }
                        .padding(.vertical, 10.0)
                    }
                }
                .frame(maxWidth:.infinity)
                .overlay(
                    RoundedRectangle(cornerRadius: 2)
                        .stroke(Color.MyGrey, lineWidth: 2))
                VStack
                {
                    Text(defaultLocalizer.stringForKey(key: "Membership"))
                        .font(.system(size: 17))
                        .padding(.vertical, 10.0)
                    Rectangle()
                        .foregroundColor(.MyGrey)
                        .frame(height:1)
                        .padding(.horizontal,20)
                    Group{
                        Text(custAccount.planName)
                            .font(.system(size: 17))
                            .fontWeight(.bold)
                        Text("\(defaultLocalizer.stringForKey(key: "Expires")): " + custAccount.planExpiry)
                            .font(.system(size: 16))
                        Text("\(defaultLocalizer.stringForKey(key: "Details")): " + custAccount.planDetails)
                            .font(.system(size: 16))
                    }
                    .frame(maxWidth:.infinity, alignment: .leading)
                    .padding(.horizontal, 10.0)
                }
                .frame(maxWidth:.infinity)
                .padding(.horizontal, (UIDevice.modelName == "Simulator iPhone 11 Pro" || UIDevice.modelName == "iPhone 11 Pro") ? 20 : 0)
                .overlay(
                    RoundedRectangle(cornerRadius: 2)
                        .stroke(Color.MyGrey, lineWidth: 2))
                VStack{
                    Text(defaultLocalizer.stringForKey(key: "Redeemable"))
                        .font(.system(size: 17))
                        .padding(.vertical, 10.0)
                    Rectangle()
                        .foregroundColor(.MyGrey)
                        .frame(height:1)
                        .padding(.horizontal,20)
                    ScrollView
                    {
                        ForEach(0..<storeAccount.redeemables.count, id: \.self) { i in
                            Rectangle()
                                .foregroundColor(.MyGrey)
                                .frame(height:1)
                                .padding(.horizontal,20)
                            HStack
                            {
                                Text(storeAccount.redeemables[i].name)
                                    .font(.system(size: 17))
                                    .fontWeight(.semibold)
                                    .padding(.leading, 10.0)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text(String(storeAccount.redeemables[i].points))
                                    .font(.system(size: 16))
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .padding(.trailing, 10.0)
                            }
                        }
                    }
                }
                .padding(.bottom, 10.0)
//                .padding(.horizontal)
                .padding(.horizontal, (UIDevice.modelName == "Simulator iPhone 11 Pro" || UIDevice.modelName == "iPhone 11 Pro") ? 20 : 0)
                .overlay(
                    RoundedRectangle(cornerRadius: 2)
                        .stroke(Color.MyGrey, lineWidth: 2))
                VStack
                {
                    Text(defaultLocalizer.stringForKey(key: "Notes"))
                        .font(.system(size: 17))
                        .padding(.vertical, 10.0)
                    ScrollView
                    {
                        ForEach(0..<notesList.count, id: \.self)
                        { i in
                            Rectangle()
                                .foregroundColor(.MyGrey)
                                .frame(height:1)
                                .padding(.horizontal,20)
                            VStack(spacing:0)
                            {
                                HStack
                                {//metanum != 1
                                    Text(notesList[i].text ?? "")
                                        .fontWeight(.semibold)
                                        .font(.system(size: 20))
                                        .fixedSize(horizontal: false, vertical: true)
                                }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, alignment: .leading)
                                HStack
                                {
//                                    Text("Published by: " + notesList[i].creator_displayname!)
                                    Text("\(defaultLocalizer.stringForKey(key: "Published by")): \(notesList[i].creator_displayname ?? "")")
                                        .font(.system(size: 17))
                                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, alignment: .leading)
                                    Text(GetDate(notesList[i].metatime ?? ""))
                                        .font(.system(size: 17))
                                }
                            }
                            .padding(.horizontal, 10.0)
                        }
                        Rectangle()
                            .foregroundColor(.MyGrey)
                            .frame(height:1)
                            .padding(.horizontal,20)
                    }
                }
                .padding(.bottom, 10.0)
//                .padding(.horizontal)
                .padding(.horizontal, (UIDevice.modelName == "Simulator iPhone 11 Pro" || UIDevice.modelName == "iPhone 11 Pro") ? 20 : 0)
                //.frame(height: 250.0)
                .overlay(
                    RoundedRectangle(cornerRadius: 2)
                        .stroke(Color.MyGrey, lineWidth: 2))
                .onAppear(perform: GetNotes)
                HStack{
                    Button(action: {self.Back()}, label: {
                        ZStack
                        {
                            RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                .stroke(Color.MyBlue, lineWidth: 2)
    //                            .foregroundColor(.MyBlue)
                                .frame(width: 80, height: 35)
                            
                            Image("back4")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(.MyBlue)
                                .frame(width: 20.0, height: 20.0)
                                .scaledToFit()
                                .padding(.trailing, 60.0)
                            Text(defaultLocalizer.stringForKey(key: "Back"))
                                .fontWeight(.bold)
                                .foregroundColor(.MyBlue)
                                .font(.system(size: 15))
                                .padding(.leading, 10.0)
                        }
                    })
                        .padding(.leading, 10.0)
                    Spacer()
                    Button(action: {OpenMap()}, label: {
                        ZStack
                        {
                            RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                .stroke(Color.MyBlue, lineWidth: 2)
    //                            .foregroundColor(.MyBlue)
                                .frame(width: (UIDevice.modelName == "Simulator iPhone 11 Pro" || UIDevice.modelName == "iPhone 11 Pro") ? 60 : 70, height: 35)
                            Text(defaultLocalizer.stringForKey(key: "Map"))
                                .fontWeight(.bold)
                                .foregroundColor(.MyBlue)
                                .font(.system(size: 15))
                        }
                    })
                    Spacer()
                    NavigationLink(destination: Messages(), isActive: $messages) {
                        Button(action: { if(account.isCust)
                            {
                            messages = true
                        }
                        })
                        {
                            ZStack
                            {
                                RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                    .stroke(Color.MyBlue, lineWidth: 2)
    //                                .foregroundColor(.MyBlue)
                                    .frame(width: 80, height: 35)
                                
                                Text(defaultLocalizer.stringForKey(key: "Messages"))
                                    .fontWeight(.bold)
                                    .foregroundColor(.MyBlue)
                                    .font(.system(size: 13))
                                
                                ZStack
                                {
                                    if(account.newMessage)
                                    {
                                        Ellipse()
                                            .fill(Color.red)
                                            .frame(width: 20, height: 20)
                                    }
                                }.frame(maxWidth:90, alignment: .trailing)
                                    .padding(.bottom, 15.0)
                            }
                        }
                    }
                    Spacer()
                    NavigationLink(destination: Activity(), isActive: $activity) {
                        Button(action: { if(account.isCust)
                            {
                            activity = true
                        }
                        })
                        {
                            ZStack
                            {
                                RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                    .stroke(Color.MyBlue, lineWidth: 2)
    //                                .foregroundColor(.MyBlue)
                                    .frame(width: 75, height: 35)
                                
                                Text(defaultLocalizer.stringForKey(key: "Activity"))
                                    .fontWeight(.bold)
                                    .foregroundColor(.MyBlue)
                                    .font(.system(size: 15))
                            }
                        }
                    }
    //                .padding(.trailing, 10.0)
                    Spacer()
                    
                    Button(
                        action: {
                            if !storeAccount.GoogleReviewURL.isEmpty {
                                errorText = ""
                                showSafari.toggle()
                            }
                            else {
                                errorText = "\(defaultLocalizer.stringForKey(key: "Google Review link cannot be found")).."
                            }
                            
                        },label:{
                            ZStack
                            {
                                RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                    .stroke(Color.MyBlue, lineWidth: 2)
    //                                .foregroundColor(.MyBlue)
                                    .frame(width: (UIDevice.modelName == "Simulator iPhone 11 Pro" || UIDevice.modelName == "iPhone 11 Pro") ? 40 : 60, height: 35)
                                
                                Image("google-review-icon")
                                    .resizable()
                                    .frame(width: 30, height: 30, alignment: .center)
                                
                            } //: ZStack
                        })
                    .padding(.trailing, 10.0)
                    .fullScreenCover(isPresented: $showSafari, onDismiss: {
                        showReviewAlert.toggle()
                    }, content: {
//                        SFSafariViewWrapper(url: URL(string: "https://search.google.com/local/writereview?placeid=ChIJhwTCaHUuK4gR9axlG5JOhFs")!)
                        SFSafariViewWrapper(url: URL(string: storeAccount.GoogleReviewURL)!)
                    })
            }
//                .padding(.horizontal, (UIDevice.modelName == "Simulator iPhone 11 Pro" || UIDevice.modelName == "iPhone 11 Pro") ? 20 : 0)
                //add activity button on right side
                Spacer()
            }
            .padding(10)
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationViewStyle(StackNavigationViewStyle())
            .onAppear {
                account.infoPage = 7
            }
            
            // Input Alert
            InputAlertView(title: "\(defaultLocalizer.stringForKey(key: "In order to get the reward")):", isShown: $showReviewAlert, text1: $reviewerFirstname, text2: $reviewerLastname, onDone: { (text1, text2) in
                sendReviewerInfo(firstName: text1, lastName: text2)
                                })
            
        } //: ZStack
        .alert(isPresented: $hasGoogleReviewError) {
                   Alert(
                       title: Text(googleReviewErrorMessage)
                   )
               }.padding()
        
    }
    func Back() -> Void{
        self.presentationMode.wrappedValue.dismiss()
        account.loadedAcc = true
    }
    
    func OpenMap() {
        if(storeAccount.address != "" && storeAccount.city != "")
        {
            errorText = ""
            var storeLocation = storeAccount.address + " " + storeAccount.city
            let replacedSpaces = storeLocation.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
            print(replacedSpaces)
            if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {  //if phone has an app
                
                if let url = URL(string: "comgooglemaps-x-callback://?saddr=&daddr=" + replacedSpaces)
                {
                    UIApplication.shared.open(url, options: [:])
                }
            }
            else if (UIApplication.shared.canOpenURL(URL(string:"http://maps.apple.com/?q=")!))
            {
                if let url = URL(string: "http://maps.apple.com/?-x-callback://?saddr=&daddr=" + replacedSpaces)
                {
                    UIApplication.shared.open(url, options: [:])
                }
            }
            else
            {
                //Open in browser
                if let urlDestination = URL.init(string: "https://www.google.co.in/maps/dir/?saddr=&daddr=" + replacedSpaces) {
                    UIApplication.shared.open(urlDestination)
                }
            }
        }
        else
        {
            errorText = "This store has not set their location information."
        }
        
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
    func GetDate(_ dateTime:String) -> String{
        var dateString = ""
        if(dateTime != "")
        {
            if(dateTime == "Now")
            {
                return "Now"
            }
            var datesplit = dateTime.components(separatedBy: " ")
            var timesplit = datesplit[1].components(separatedBy: ":")
            
            var hour = Int(timesplit[0]) ?? 0
            var ampm = "am"
            
            if(hour == 0)
            {
                hour = 12
            }
            else if(hour > 11)
            {
                if(hour != 12)
                {
                    hour -= 12
                }
                ampm = "pm"
            }
            
            dateString = datesplit[0] + " at " + String(hour) + ":" + timesplit[1] + " " + ampm
        }
        return dateString
    }
    func GetNotes() -> Void{
        notesList.removeAll()
        APIRequest().Post(withParameters: ["action":"get-records","record_format":"5","cardholder":String(custAccount.id),"session":account.SessionToken])
        {data in
            print(data)
            DispatchQueue.main.async {
                if(data != "failed" && data != "nosession" && data != "")
                {
                    let jsonData = data.data(using: .utf8)!
                    let test: [NoteObj] = try! JSONDecoder().decode([NoteObj].self, from: jsonData)
                    //print(test)
                    for note in test {
                        if((note.metanum ?? 1) != 1)
                        {
                            notesList.append(note)
                        }
                    }
                }
                else
                {
                }
            }
        }
    }
    
    func sendReviewerInfo(firstName: String, lastName: String) {
        print("DEBUG: Reviewer is \(firstName) \(lastName), store id = \(custAccount.store)")
        
        APIRequest().Post(withParameters: ["first_name": firstName,
                                           "last_name": lastName,
                                           "id": "\(custAccount.id)",
                                           "store_id": "\(custAccount.store)"],
                          _url: ReviewAPI.CHECK_REVIEWS)
        {data in
            DispatchQueue.main.async {
                if(data != "false" && data != "" && data != "nosession" && data != "[]")
                {
                    let jsonData = data.data(using: .utf8)!
                    let reviewResult: GoogleReviewObj = try! JSONDecoder().decode(GoogleReviewObj.self, from: jsonData)
                    //print(test)
                    if let review = reviewResult.review {
                        if !review {
                            hasGoogleReviewError = true
                            googleReviewErrorMessage = reviewResult.reason ?? "No review!"
                        }
                        else {
                            if let reviewReason = reviewResult.reason {
                                if !reviewReason.isEmpty {
                                    hasGoogleReviewError = true
                                    googleReviewErrorMessage = reviewReason
                                }
                                else {
                                    hasGoogleReviewError = true
                                    googleReviewErrorMessage = "Your reward has been loaded to your account!"
                                }
                            }
                        }
                        
                    }
                    

                }
                else
                {
                    hasGoogleReviewError = true
                    googleReviewErrorMessage = "Something went wrong!"
                }
            }
            
            // TODO: I only need to call the API and backend should determine if the reward will be sent. Maybe return true or false based on the reward is sent or not.
        }
    }
    
    struct NoteObj: Decodable {
        var id: Int?
        var cardholder: Int?
        var location: Int?
        var permission_group: Int?
        var record_format: Int?
        var title: String?
        var text: String?
        var metanum: Int?
        var metavar: String?
        var metatime: String?
        var created: String?
        var creator: Int?
        var updater: Int?
        var precedent: Int?
        var isSuperseded: Int?
        var firstname: String?
        var lastname: String?
        var location_displayname: String?
        var creator_displayname: String?
    }
    
    struct GoogleReviewObj: Decodable {
        var id: Int?
        var review: Bool?
        var reason: String?
        var reward: String?
    }
}
