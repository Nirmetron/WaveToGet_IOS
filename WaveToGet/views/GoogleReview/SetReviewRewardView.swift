//
//  SetReviewRewardView.swift
//  ReferralAndRewards
//
//  Created by Ismail Gok on 2022-08-11.
//

import SwiftUI

struct SetReviewRewardView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var custAccount:CustomerAccount
    @EnvironmentObject var storeAccount:StoreAccount
    @EnvironmentObject var account:Account
    @EnvironmentObject var sizing:Sizing
    @Binding var currentPage:Int
    
    @State var quantity = "0"
    @State var type = "points"
    @State private var isSuccess = false
    @State private var errorMessage = ""
    @State private var reviewURL = ""
    
    let defaultLocalizer = AMPLocalizeUtils.defaultLocalizer
    
    var body: some View {
        VStack(spacing: 20) {
            HStack
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
                
                Text(defaultLocalizer.stringForKey(key: "EDIT GOOGLE REVIEWS"))
                    .font(.system(size: 17))
                    .padding(.top, 5.0)
                    .padding(.leading, -35)
                
                Spacer()
                
            } //: HStack
            
            // Error message
            Text(errorMessage)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundColor(.red)
                .font(.system(size: 15))
            
            HStack(spacing: 5) {
                
                Text("\(defaultLocalizer.stringForKey(key: "Amount")): ")
                    .font(.system(size: 17))
                
                TextField("\(quantity)", text: $quantity)
                    .font(.system(size: 15))
                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.vertical, 5)
                    .padding(.trailing, 10.0)
                    .disableAutocorrection(true)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .keyboardType(.numberPad)
                
                Menu {
                    Button {
                        type = defaultLocalizer.stringForKey(key: "points")
                    } label: {
                        Text(defaultLocalizer.stringForKey(key: "points"))
                            .font(.system(size: 15))
                    }
                    Button {
                        type = defaultLocalizer.stringForKey(key: "dollars")
                    } label: {
                        Text(defaultLocalizer.stringForKey(key: "dollars"))
                            .font(.system(size: 15))
                    }
                } label: {
                    Text(type)
                        .font(.system(size: 15))
                }
                .padding(.trailing, 10.0)
               
            }
            
            HStack(spacing: 5)
            {
                Text("Google Review Link:")
                    .font(.system(size: 17))
                    .frame(width: 100)
                TextField("Google Review Link:", text: $reviewURL)
                    .font(.system(size: 15))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                    .disableAutocorrection(true)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .padding(.vertical, 5)
                    .padding(.trailing, 10.0)
                
            }
            
            if !reviewURL.isEmpty, reviewURL.isValidURL {
                HStack(spacing: 5)
                {
                    Text(.init("\(defaultLocalizer.stringForKey(key: "Tap to go to your")) [Google URL Preview](\(reviewURL))"))
                        .font(.system(size: 17))
                }
            }
            
            
            HStack
            {
                Button(action: {
                    setReward()
                }, label: {
                    ZStack
                    {
                        RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                            .stroke(Color.MyBlue, lineWidth: 2)
//                            .foregroundColor(.MyBlue)
                        
                        Text(defaultLocalizer.stringForKey(key: "SET REWARD"))
                            .fontWeight(.semibold)
                            .foregroundColor(.MyBlue)
                            .font(.system(size: 15))
                    }
                })
                .padding(.horizontal, 10.0)
                .frame(height: 50.0)
            }
            .padding(.bottom, 10.0)
            
            Spacer()
            
        } //:VStack
        .onAppear {
            assignInitialValues()
        }
        .alert(isPresented: $isSuccess) {
                   Alert(
                    title: Text("\(defaultLocalizer.stringForKey(key: "Successfully set"))!")
                   )
               }.padding()
        
    }
    
    func Back() -> Void{
        currentPage = 0
    }
    
    private func setReward() {
        
        let params: [String: String] = [
            "action": "set-reward",
            "store_id": "\(storeAccount.id)",
            "type": type,
            "value": quantity,
            "review_url": reviewURL
        ]
        
        APIRequest().Post(withParameters: params, _url: ReviewAPI.CHECK_REVIEWS)
        {data in
            DispatchQueue.main.async {
                if(data != "false" && data != "" && data != "nosession" && data != "[]")
                {
                    let jsonData = data.data(using: .utf8)!
                    let rewardResult: rewardTempObj = try! JSONDecoder().decode(rewardTempObj.self, from: jsonData)
                    //print(test)
                    if let setResult = rewardResult.msg, setResult == true {
                        isSuccess = true
                    }
                    else {
                        errorMessage = "\(defaultLocalizer.stringForKey(key: "Couldn't set the reward data"))!"
                    }
                    

                }
                else
                {
                    errorMessage = "\(defaultLocalizer.stringForKey(key: "Couldn't set the reward data"))!"
                }
            }
            
        }
    }
    
    private func assignInitialValues() {
        getReviewAmount()
        getReviewURL()
    }
    
    private func getReviewAmount() {
        APIRequest().Post(withParameters: ["action": "get-reward",
                                           "store_id": "\(storeAccount.id)"],
                          _url: ReviewAPI.CHECK_REVIEWS)
        {data in
            DispatchQueue.main.async {
                if(data != "false" && data != "" && data != "nosession" && data != "[]")
                {
                    let jsonData = data.data(using: .utf8)!
                    let rewardResult: rewardObj = try! JSONDecoder().decode(rewardObj.self, from: jsonData)
                    //print(test)
                    if let rewardType = rewardResult.type, let rewardQuantity = rewardResult.value {
                        type = rewardType
                        quantity = rewardQuantity
                    }
                    

                }
                else
                {
                    errorMessage = "\(defaultLocalizer.stringForKey(key: "Couldn't set the reward data"))!"
                }
            }
            
        }
    }
    
    private func getReviewURL() {
        APIRequest().Post(withParameters: ["action": "get-review-url",
                                           "store_id": "\(storeAccount.id)"],
                          _url: ReviewAPI.CHECK_REVIEWS)
        {data in
            DispatchQueue.main.async {
                if(data != "false" && data != "" && data != "nosession" && data != "[]")
                {
                    let jsonData = data.data(using: .utf8)!
                    let rewardResult: reviewURLObj = try! JSONDecoder().decode(reviewURLObj.self, from: jsonData)
                    //print(test)
                    if let reviewURL = rewardResult.url {
                        self.reviewURL = reviewURL
                    }
                    

                }
                else
                {
                    errorMessage = "\(defaultLocalizer.stringForKey(key: "Couldn't set the reward data"))!"
                }
            }
            
        }
    }
    
    struct rewardObj: Decodable {
        var id: Int?
        var type: String?
        var value: String?
        var msg: Bool?
    }
    
    struct rewardTempObj: Decodable {
        var id: Int?
//        var sql: String?
        var msg: Bool?
    }
    
    struct reviewURLObj: Decodable {
        var msg: Bool?
        var url: String?
    }
}

//struct SetReviewRewardView_Previews: PreviewProvider {
//    static var previews: some View {
//        SetReviewRewardView()
//    }
//}
