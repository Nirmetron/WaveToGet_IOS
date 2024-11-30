//
//  EditStampsheetView.swift
//  ReferralAndRewards
//
//  Created by Ismail Gok on 2022-06-13.
//

import SwiftUI

struct EditStampsheetView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var custAccount:CustomerAccount
    @EnvironmentObject var storeAccount:StoreAccount
    @EnvironmentObject var account:Account
    @EnvironmentObject var sizing:Sizing
    
    @Binding var currentPage: Int
    @Binding var selectedPlan: Int
    
    @State var errorText = ""
    @State var rewards = ""
    @State var stamps = ""
    @State var stampsAsInt = 10.0
    @State var shape = "star"
    @State var autostamp = false
    @State var autoreward = false
    @State var isDeleted = false
    @State var isUpdated = false
    
    let defaultLocalizer = AMPLocalizeUtils.defaultLocalizer
    
    let shapeMenuItems = ["bag", "bank", "bill", "card", "cup", "dollar", "flag", "gem", "gift", "heart", "smile", "star", "sun"]
    let shapeMenuItemsDic: [String: String] = [
        "dollar": "1",
        "heart": "2",
        "flag": "3",
        "star": "4",
        "sun": "5",
        "gem": "6",
        "gift": "7",
        "card": "8",
        "cup": "9",
        "bill": "10",
        "bag": "11",
        "smile": "12",
        "bank": "13"
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            // Go Back Button
            HStack(alignment: .center)
            {
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
                    } //: ZStack
                    .frame(alignment: .leading)
                    .padding([.top, .leading, .trailing], 10.0)
                })
                
                Spacer()
                
                Text(defaultLocalizer.stringForKey(key: "EDIT STAMPSHEET"))
                    .font(.system(size: 17))
                    .padding(.top, 5.0)
                    .padding(.leading, -35)

                Spacer()
                
            } //: HStack
            
            // Error message
            Text(errorText)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundColor(.red)
            
            // Rewards input field (String)
            HStack
            {
                Text("\(defaultLocalizer.stringForKey(key: "Reward Name")):")
                    .foregroundColor(.MyBlue)
                    .frame(width: account.Ipad ? sizing.ipadHorizontalInputForForm : sizing.horizontalInputForForm,alignment: .leading)
                    .font(.system(size: 17))
                
                TextField(defaultLocalizer.stringForKey(key: "Rewards"), text: $rewards)
                    .font(.system(size: 15))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                    .disableAutocorrection(true)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    
            }
            
            HStack
            {
                Text("\(defaultLocalizer.stringForKey(key: "Stamp Count")):")
                    .foregroundColor(.MyBlue)
                    .frame(width: account.Ipad ? sizing.ipadHorizontalInputForForm : sizing.horizontalInputForForm,alignment: .leading)
                    .font(.system(size: 17))
                
//                TextField(defaultLocalizer.stringForKey(key: "Stamps"), text: $stamps)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
//                    .disableAutocorrection(true)
//                    .keyboardType(.numberPad)
                    
                VStack {
                    Slider(
                            value: $stampsAsInt,
                            in: 0...10,
                            step: 2
                        ) {
                            Text("Stamps")
                                .font(.system(size: 15))
                        } minimumValueLabel: {
                            Text("0")
                                .font(.system(size: 15))
                        } maximumValueLabel: {
                            Text("10")
                                .font(.system(size: 15))
                        }
                    Text("\(Int(stampsAsInt)) Stamps")
                            .foregroundColor(.blue)
                            .font(.system(size: 15))
                    } //: VStack

            }
            
            HStack(spacing: 10) {
                Toggle(defaultLocalizer.stringForKey(key: "Autostamp"), isOn: $autostamp)
                    .font(.system(size: 15))
                
                Toggle(defaultLocalizer.stringForKey(key: "Autoreward"), isOn: $autoreward)
                    .font(.system(size: 15))
                
                
            } //: HStack
            .padding(.bottom, 10.0)
            
            Spacer()
            
            // Save Button
            HStack
            {
                Button(action: {
                    saveStampsheet()
                }, label: {
                    ZStack
                    {
                        RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                            .stroke(Color.MyBlue, lineWidth: 2)
//                            .foregroundColor(.MyBlue)
                        
                        Text(defaultLocalizer.stringForKey(key: "SAVE"))
                            .fontWeight(.semibold)
                            .foregroundColor(.MyBlue)
                            .font(.system(size: 15))
                    }
                })
                .padding(.horizontal, 10.0)
                .frame(height: 50.0)
            }
            .padding(.bottom, 10.0)
            
        } //: VStack
        .alert(isPresented: $isUpdated) {
                   Alert(
                    title: Text("\(defaultLocalizer.stringForKey(key: "Successfully updated"))!")
                   )
               }.padding()
        .onAppear {
            account.infoPage = -1
            getAllStampsheets()
        }
        
    } //: body
    
    func Back() {
        currentPage = 0
    }
    
    func editStampsheet(_ index: Int) {
        currentPage = 13
        selectedPlan = index
    }
    
    private func saveStampsheet() {
        print("DEBUG: saveStampsheet is called..")
        
        if(rewards == "")
        {
            errorText = "Please add a rewards to the stampsheet..."
            return
        }
        if(stamps == "")
        {
            errorText = "Please add stamps to the stampsheet..."
            return
        }
        let newRewards = rewards
//        let newStamps = stamps
        let newStamps = "\(stampsAsInt)"
        let newShape = shape
        let newAutoStamp = autostamp
        let newAutoReward = autoreward
        
        let params: [String: String] = [
            "action": "edit-stampsheets",
            "session": account.SessionToken,
            "id": "\(storeAccount.stampsheets[selectedPlan].id)",
            "store":String(storeAccount.id),
            "prize": newRewards,
            "size": newStamps,
            "shape": shapeMenuItemsDic[newShape] ?? "0",
            "autostamp": newAutoStamp ? "1" : "0",
            "autoreward": newAutoReward ? "1" : "0"
        ]
        print("DEBUG: params = \(params)")
        APIRequest().Post(withParameters: params)
        {data in
            DispatchQueue.main.async {
                if(data == "")
                {
                   isUpdated = true
                }
                else {
                    isUpdated = true
                }
            }
        }
    }
    
    func removeStampsheet(_ id: Int) {
        print("DEBUG: removeStampsheet is called..")
        
        let params: [String: String] = [
            "action": "delete-stampsheets",
            "session":account.SessionToken,
            "id": String(id)
        ]
        
        print("DEBUG: params = \(params)")
        
        APIRequest().Post(withParameters: params)
        {data in
            DispatchQueue.main.async {
                if(data != "" && data != "nosession")
                {
                    print(data)
                    //load transactions
                    let jsonData = data.data(using: .utf8)!
                    do {
//                        storeAccount.stampsheets = try JSONDecoder().decode([StoreStampSheet].self, from: jsonData)
//                        let stampsheets = try JSONDecoder().decode([StoreStampSheet].self, from: jsonData)
                        getAllStampsheets()
                        isDeleted = true
                        errorText = ""
                    }
                    catch {
                        print("Failed to fetch the stamsheets: \(error)")
                        errorText == "\(defaultLocalizer.stringForKey(key: "Something went wrong"))!"
                    }
                    
                }
                else
                {
                    print("DEBUG: getAllStampsheets return type is different then expected..")
                    errorText == "\(defaultLocalizer.stringForKey(key: "Something went wrong"))!"
                }
            }
        }
    }
    
    func getAllStampsheets() {
        let params: [String: String] = [
            "action": "get-stampsheets",
            "session":account.SessionToken,
            "id": String(storeAccount.id)
        ]
        print("DEBUG: params = \(params)")
        APIRequest().Post(withParameters: params)
        {data in
            DispatchQueue.main.async {
                if(data != "" && data != "nosession")
                {
                    print(data)
                    //load transactions
                    let jsonData = data.data(using: .utf8)!
                    do {
                        storeAccount.stampsheets = try JSONDecoder().decode([StoreStampSheet].self, from: jsonData)
                        if storeAccount.stampsheets.count > 0 {
                            let stampsheet = storeAccount.stampsheets[0]
                            rewards = stampsheet.prize
                            stamps = "\(stampsheet.size)"
                            stampsAsInt = Double(stampsheet.size)
                            autostamp = stampsheet.autostamp == 0 ? false : true
                            autoreward = stampsheet.autoreward == 0 ? false : true
                        }
                    }
                    catch {
                        print("Failed to fetch the stamsheets: \(error)")
                    }
                    
                }
                else
                {
                    print("DEBUG: getAllStampsheets return type is different then expected..")
                }
            }
        }
    }
    
    func addNewStampsheet() {
        if(rewards == "")
        {
            errorText = "\(defaultLocalizer.stringForKey(key: "Please add a rewards to the stampsheet"))..."
            return
        }
        if(stamps == "")
        {
            errorText = "\(defaultLocalizer.stringForKey(key: "Please add stamps to the stampsheet"))..."
            return
        }
        let newRewards = rewards
        let newStamps = stamps
        let newShape = shape
        let newAutoStamp = autostamp
        let newAutoReward = autoreward
        
        let params: [String: String] = [
            "action": "edit-stampsheets",
            "session": account.SessionToken,
//            "id": "\(storeAccount.stampsheets[selectedPlan].id)",
            "store":String(storeAccount.id),
            "prize": newRewards,
            "size": newStamps,
            "shape": shapeMenuItemsDic[newShape] ?? "0",
            "autostamp": newAutoStamp ? "1" : "0",
            "autoreward": newAutoReward ? "1" : "0"
        ]
        print("DEBUG: params = \(params)")
        APIRequest().Post(withParameters: params)
        {data in
            DispatchQueue.main.async {
                if(data != "nosession" && data != "failed")
                {
                    getAllStampsheets()
                }
            }
        }
    }
}

//struct EditStampsheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditStampsheetView()
//    }
//}
