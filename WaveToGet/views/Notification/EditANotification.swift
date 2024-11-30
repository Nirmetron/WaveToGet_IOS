//
//  EditANotification.swift
//  ReferralAndRewards
//
//  Created by Ismail Gok on 2022-06-17.
//

import SwiftUI

struct EditANotification: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var custAccount:CustomerAccount
    @EnvironmentObject var storeAccount:StoreAccount
    @EnvironmentObject var account:Account
    @EnvironmentObject var sizing:Sizing
    
    @Binding var currentPage:Int
//    @Binding var selectedPlan: Int
    @Binding var notification: NewNotification?
    
    @State var isUpdated = false
    
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
    @State var deliveryTimeNumber = ""
    @State var deliveryTimePeriod = "Days"
    @State var deliveryTimeOrder = "After"
    @State var notificationList = [NewNotification]()
    
    let typeItems = ["Pre-Registration", "Registration", "Visit", "Transaction", "Birthday", "Interest", "Rewarded", "Expired", "Benefit Used", "Plan Renewed", "Stampsheet - 1 Day", "Stampsheet - 7 Days", "Stampsheet - 14 Days"]
    
    let typeItemsDic: [Int: String] = [
        16: "Pre-Registration",
        1: "Registration",
        2: "Visit",
        3: "Transaction",
        17: "Birthday",
        4: "Interest",
        5: "Rewarded",
        10: "Expired",
        11: "Benefit Used",
        12: "Plan Renewed",
        13: "Stampsheet - 1 Day",
        14: "Stampsheet - 7 Days",
        15: "Stampsheet - 14 Days"
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
                
                Text("EDIT NOTIFICATION")
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
                    Text("Notification Type: \(typeItemsDic[(notification?.notification ?? 16)] ?? "")")
                        .font(.system(size: 14, weight: .semibold))
                    
//                    Menu(type) {
//                        ForEach(typeItems, id: \.self) { item in
//                            Button(item) {
//                                type = item
//                            }
//                        }
//                    }
                    
                    Spacer()
                    
                } //: HStack
                
                // Delivery settings
                HStack {
                    Text("Delivery Time: ")
                        .font(.system(size: 14, weight: .semibold))
                    
                    // Delivery Time
                    TextField("\(abs(notification?.delay_num ?? 0))", text: $deliveryTimeNumber)
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
//                        Text(deliveryTimePeriod)
                        Text("\(notification?.delay_scale ?? "Days")")
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
//                        Text(deliveryTimeOrder)
                        Text("\(notification?.delay_dir == 1 ? "After" : "Before")")
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
                
                
                TextField(notification?.subject ?? "Email Subject", text: $emailSubject)
                    .font(.system(size: 14))
                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.vertical, 5)
                    .padding(.horizontal, 10.0)
                    .disableAutocorrection(true)
                    .autocapitalization(.sentences)
                
                TextField(notification?.email ?? "Email Message", text: $emailMessage)
                    .font(.system(size: 14))
                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.vertical, 5)
                    .padding(.trailing, 10.0)
                    .disableAutocorrection(true)
                    .autocapitalization(.sentences)
                    
                Toggle("Sms Notification", isOn: $smsNotification)
                    .font(.system(size: 14))
                
                TextField(notification?.sms ?? "Sms Message", text: $smsMessage)
                    .font(.system(size: 14))
                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.vertical, 5)
                    .padding(.horizontal, 10.0)
                    .disableAutocorrection(true)
                    .autocapitalization(.sentences)
                
                // Add new notification Button
                Button(action: {
                    updateNotification()
                }, label: {
                    ZStack
                    {
                        RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                            .stroke(Color.MyBlue, lineWidth: 2)
//                            .foregroundColor(.MyBlue)
                        
                        Text("UPDATE NOTIFICATION")
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
            setInitialValues()
            account.infoPage = -1
        })
        .alert(isPresented: $isUpdated) {
                   Alert(
                       title: Text("Successfully updated!")
                   )
               }.padding()
        
    } //: body
    
    func Back () {
        currentPage = 14
    }
    
    private func setInitialValues() {
        deliveryTimeNumber = String(abs(notification?.delay_num ?? 0))
        emailSubject = notification?.subject ?? ""
        emailMessage = notification?.email ?? ""
        smsMessage = notification?.sms ?? ""
        
    }
    
    func updateNotification() {
        print("DEBUG: updateNotification is called..")
        
//        let newType = type
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
//            "notification": newType,
            "sendEmail": newEmail,
//            "isHTML": newHTML,
            "sendSMS": newSendSMS,
            "subject": newEmailSubject,
            "email": newEmailContent,
            "sms": newSmsContent,
            "delay_num": newDelayNum,
            "delay_dir": newDelayDir,
            "delay_scale": newDelayScale,
            "id": "\(notification!.id ?? 0)"
        ]
        
        print("DEBUG: params = \(params)")
        
        APIRequest().Post(withParameters: params)
        {data in
            DispatchQueue.main.async {
                if(data != "" && data != "nosession")
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

//struct EditANotification_Previews: PreviewProvider {
//    static var previews: some View {
//        EditANotification()
//    }
//}
