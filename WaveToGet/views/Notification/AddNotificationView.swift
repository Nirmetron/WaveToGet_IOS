//
//  EditNotificationView.swift
//  ReferralAndRewards
//
//  Created by Ismail Gok on 2022-06-16.
//

import SwiftUI

struct AddNotificationView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var custAccount:CustomerAccount
    @EnvironmentObject var storeAccount:StoreAccount
    @EnvironmentObject var account:Account
    @EnvironmentObject var sizing:Sizing
    @Binding var currentPage:Int
//    @Binding var selectedPlan: Int
    @Binding var notification: NewNotification?
    @State var errorText = ""
    @State var type = "Pre-Registration"
    @State var description = ""
    @State var send = ""
    @State var emailNotification = false
    @State var htmlEmails = false
    @State var emailSubject = ""
    @State var emailMessage = ""
    @State var smsNotification = false
    @State var smsMessage = ""
    @State var deliveryTimeNumber = "0"
    @State var deliveryTimePeriod = "Days"
    @State var deliveryTimeOrder = "After"
    @State var notificationList = [NewNotification]()
    
    @State var isUpdated = false
    
    let typeItems = ["Pre-Registration", "Registration", "Visit", "Transaction", "Birthday", "Interest", "Rewarded", "Expired", "Benefit Used", "Plan Renewed", "Stampsheet - 1 Day", "Stampsheet - 7 Days", "Stampsheet - 14 Days"]
    
    let typeItemsDic: [String: String] = [
        "Pre-Registration": "16",
        "Registration": "1",
        "Visit": "2",
        "Transaction": "3",
        "Birthday": "17",
        "Interest": "4",
        "Rewarded": "5",
        "Expired": "10",
        "Benefit Used": "11",
        "Plan Renewed": "12",
        "Stampsheet - 1 Day": "13",
        "Stampsheet - 7 Days": "14",
        "Stampsheet - 14 Days": "15"
    ]
    
    var body: some View {
        
        VStack {
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
                    }
                    .frame(alignment: .leading)
                    .padding([.top, .leading, .trailing], 10.0)
                })
                
                Spacer()
                
                Text("ADD NOTIFICATION")
                    .font(.system(size: 17))
                    .padding(.top, 5.0)
                    .padding(.leading, -35)
                
                Spacer()
                
            } //: HStack
            Text(errorText)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundColor(.red)
                .font(.system(size: 20))
            
            VStack
            {
                
                HStack(spacing: 20) {
                    
                    // Type selection
                    Text("Notification Type: ")
                        .font(.system(size: 14, weight: .semibold))
                    
                    Menu(type) {
                        ForEach(typeItems, id: \.self) { item in
                            Button(item) {
                                type = item
                            }
                        }
                    }
                    .font(.system(size: 14))
                    
                    Spacer()
                    
                } //: HStack
                .font(.system(size: 14))
                
                // Delivery settings
                HStack {
                    Text("Delivery Time: ")
                        .font(.system(size: 14, weight: .semibold))
                    
                    // Delivery Time
                    TextField("0", text: $deliveryTimeNumber)
                        .font(.system(size: 14))
                        .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10.0)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .keyboardType(.numberPad)
                    
                    Menu {
                        Button {
                            deliveryTimePeriod = "Days"
                        } label: {
                            Text("Days")
                                .font(.system(size: 14))
                        }
                        Button {
                            deliveryTimePeriod = "Months"
                        } label: {
                            Text("Months")
                                .font(.system(size: 14))
                        }
                    } label: {
                        Text(deliveryTimePeriod)
                            .font(.system(size: 14))
                    }
                    
                    Menu {
                        Button {
                            deliveryTimeOrder = "Before"
                        } label: {
                            Text("Before")
                                .font(.system(size: 14))
                        }
                        Button {
                            deliveryTimeOrder = "After"
                        } label: {
                            Text("After")
                                .font(.system(size: 14))
                        }
                    } label: {
                        Text(deliveryTimeOrder)
                            .font(.system(size: 14))
                    }
                    
                } //: HStack
                
                HStack(spacing: 10) {
                    Toggle("Email Notification", isOn: $emailNotification)
                        .font(.system(size: 14))
                    
                    Toggle("HTML Emails", isOn: $htmlEmails)
                        .font(.system(size: 14))
                    
                    
                } //: HStack
                .padding(.bottom, 10.0)
                
                
                TextField("Email Subject", text: $emailSubject)
                    .font(.system(size: 14))
                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.vertical, 5)
                    .padding(.horizontal, 10.0)
                    .disableAutocorrection(true)
                    .autocapitalization(.sentences)
                
                TextField("Email Message", text: $emailMessage)
                    .font(.system(size: 14))
                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.vertical, 5)
                    .padding(.trailing, 10.0)
                    .disableAutocorrection(true)
                    .autocapitalization(.sentences)
                    
                Toggle("Sms Notification", isOn: $smsNotification)
                    .font(.system(size: 14))
                
                TextField("Sms Message", text: $smsMessage)
                    .font(.system(size: 14))
                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.vertical, 5)
                    .padding(.horizontal, 10.0)
                    .disableAutocorrection(true)
                    .autocapitalization(.sentences)
                
                // Add new notification Button
                Button(action: {
                    addNotification()
                }, label: {
                    ZStack
                    {
                        RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                            .stroke(Color.MyBlue, lineWidth: 2)
//                            .foregroundColor(.MyBlue)
                        
                        Text("ADD NOTIFICATION")
                            .fontWeight(.semibold)
                            .foregroundColor(.MyBlue)
                            .font(.system(size: 15))
                    }
                })
                .padding(.trailing, 10.0)
                .frame(width: 150.0, height: 40.0)
            } //: VStack
            .padding(.bottom, 20)
          
            Spacer()
            
        } //: VStack
        .padding(.bottom, 1)
        .onAppear(perform: {
            account.infoPage = -1
        })
        .alert(isPresented: $isUpdated) {
                   Alert(
                       title: Text("Successfully added!")
                   )
               }.padding()
        
    } //: body
    
    func Back() {
        currentPage = 14
    }
    
    func addNotification() {
        print("DEBUG: addNotification is called..")
        
        let newType = typeItemsDic[type] ?? "1"
        let newEmail: String = emailNotification ? "1" : "0"
        let newHTML: String = htmlEmails ? "1" : "0"
        let newSendSMS: String = smsNotification ? "1" : "0"
        let newEmailSubject = emailSubject
        let newEmailContent = emailMessage
        let newSmsContent = smsMessage
        let newDelayNum = deliveryTimeNumber
        let newDelayDir = deliveryTimeOrder == "After" ? "1" : "-1"
        let newDelayScale = deliveryTimePeriod.lowercased()
        
        let params: [String: String] = [
            "action": "edit-notifications",
            "session":account.SessionToken,
            "delay_dir": newDelayDir,
            "delay_scale": newDelayScale,
            "email": newEmailContent,
            "notification": newType,
            "sendEmail": newEmail,
            "sendSMS": newSendSMS,
            "delay_num": newDelayNum,
            "subject": newEmailSubject,
            "sms": newSmsContent,
            "store": String(storeAccount.id)
//            "isHTML": newHTML,
//            "sms": newSmsContent,
        ]
        
        print("DEBUG: params = \(params)")
        
        APIRequest().Post(withParameters: params)
        {data in
            DispatchQueue.main.async {
                if(data != "" && data != "nosession" && data != "failed")
                {
                    print("DEBUG: Notification is added..")
                    isUpdated = true
                    errorText = ""
                }
                else
                {
                    print("DEBUG: addNotification return type is different then expected..")
                    isUpdated = false
                    errorText = "Something went wrong!"
                }
            }
        }
    }
    
    
    
}

//struct AddNotificationView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditNotificationView()
//    }
//}
