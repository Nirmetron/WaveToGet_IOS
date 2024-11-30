//
//  EditATimestampView.swift
//  ReferralAndRewards
//
//  Created by Ismail Gok on 2022-06-13.
//

import SwiftUI

struct EditATimestampView: View {
    
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
    @State var shape = "star"
    @State var autostamp = false
    @State var autoreward = false
    @State var isUpdated = false
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
            ZStack
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
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.top, .leading, .trailing], 10.0)
                })
                Text("EDIT A STAMPSHEET")
                    .font(.system(size: 17))
                    .padding(.top, 5.0)
                    .padding(.leading, -35)
            } //: ZStack
            
            // Error message
            Text(errorText)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundColor(.red)
            
            // Rewards input field (String)
            TextField(storeAccount.stampsheets[selectedPlan].prize, text: $rewards)
                .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.vertical, 5)
                .padding(.horizontal, 10.0)
                .disableAutocorrection(true)
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
            
            HStack(spacing: 5)
            {
                // Stamp input (Int)
                TextField("\(storeAccount.stampsheets[selectedPlan].size)", text: $stamps)
                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.vertical, 5)
                    .padding(.trailing, 10.0)
                    .disableAutocorrection(true)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .keyboardType(.numberPad)
                    .frame(width: 200)
                
                // Shape selection
                Text("Shape: ")
                    .font(.system(size: 14, weight: .semibold))
                
                Menu(storeAccount.stampsheets[selectedPlan].shape) {
                    ForEach(shapeMenuItems, id: \.self) { item in
                        Button(item) {
                            shape = item
                        }
                    }
                }
               
            } //: HStack
            .padding(.horizontal)
            
            HStack(spacing: 10) {
                Toggle("Autostamp", isOn: $autostamp)
                
                Toggle("Autoreward", isOn: $autoreward)
                
                
            } //: HStack
            .padding(.bottom, 10.0)
            
            HStack {
                
                Spacer()
                
                Button(action: {
                    updateTimestamp()
                }, label: {
                    ZStack
                    {
                        RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                            .stroke(Color.MyBlue, lineWidth: 2)
//                            .foregroundColor(.MyBlue)
                        
                        Text("UPDATE")
                            .fontWeight(.semibold)
                            .foregroundColor(.MyBlue)
                            .font(.system(size: 14))
                    }
                })
                .padding(.trailing, 10.0)
                .frame(width: 120.0, height: 40.0)
                
                Spacer()
            } //: HStack
            
            Spacer()
            
        } //: VStack
        .onAppear(perform: {
            setInitialValues()
            account.infoPage = -1
        })
        .alert(isPresented: $isUpdated) {
                   Alert(
                       title: Text("Successfully updated!")
                   )
               }.padding()
        
    } //: body
    
    func Back() {
        currentPage = 12
    }
    
    private func setInitialValues() {
        rewards = storeAccount.stampsheets[selectedPlan].prize
        stamps = String(storeAccount.stampsheets[selectedPlan].size) ?? ""
    }
    
    func updateTimestamp() {
        print("DEBUG: editTimestamp is called..")
        
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
        let newStamps = stamps
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
}

//struct EditATimestampView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditATimestampView()
//    }
//}
