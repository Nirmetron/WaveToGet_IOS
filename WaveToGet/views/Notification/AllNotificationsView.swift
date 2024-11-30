//
//  AllNotificationsView.swift
//  ReferralAndRewards
//
//  Created by Ismail Gok on 2022-06-17.
//

import SwiftUI

struct AllNotificationsView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var custAccount:CustomerAccount
    @EnvironmentObject var storeAccount:StoreAccount
    @EnvironmentObject var account:Account
    @EnvironmentObject var sizing:Sizing
    @Binding var currentPage:Int
//    @Binding var selectedPlan: Int
    @Binding var notification: NewNotification?
    
    @State var notificationList = [NewNotification]()
    @State var type = ""
    @State var description = ""
    @State var send = ""
    @State var isDeleted = false
    
    let defaultLocalizer = AMPLocalizeUtils.defaultLocalizer
    
    var body: some View {
        
        VStack {
            
            // Back button
            ZStack
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
                        .padding([.top, .leading, .trailing], 10.0)
                    })
                    
                    Spacer()
                    
                    // Add Button
                    Button(action: {
                        goToAddNotification()
                    }, label: {
                            ZStack
                            {
                                RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                    .stroke(Color.MyBlue, lineWidth: 2)
//                                        .foregroundColor(.MyBlue)
                                
                                Text(defaultLocalizer.stringForKey(key: "ADD"))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.MyBlue)
                                    .font(.system(size: 15))
                            }
                        })
//                            .padding(.horizontal, 20.0)
                    .frame(width: 80, height: 40)
                    .padding([.top, .leading, .trailing], 10.0)
                    
                } //: HStack
                
                HStack {
                    Spacer()
                    
                    Text(defaultLocalizer.stringForKey(key: "NOTIFICATIONS"))
                        .font(.system(size: 17))
                        .padding(.top, 5.0)
                        .padding(.leading, -35)
                    
                    Spacer()
                }
               
            } //: ZStack
            
            // Table Headers
//            HStack(alignment: .center) {
//                Text("Type")
//                    .font(.system(size: 10))
//                    .fontWeight(.semibold)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//
//                Spacer()
//
//                Text("Description")
//                    .font(.system(size: 10))
//                    .fontWeight(.semibold)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//
//                Spacer()
//
//                Text("Send")
//                    .font(.system(size: 10))
//                    .fontWeight(.semibold)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//
//                Spacer()
//
//                Text("Edit")
//                    .font(.system(size: 10))
//                    .fontWeight(.semibold)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//            }
//            .padding(.top, 20)
//            .padding(.horizontal)
            
            ScrollView {
                ForEach(0 ..< notificationList.count, id: \.self) { i in
                    Rectangle()
                        .foregroundColor(.MyGrey)
                        .frame(height:1)
                        .padding(.horizontal,20)
                    
                    HStack {
                        
                        VStack(alignment: .leading) {
                            
                            // Type column
                            HStack {
                                
                                Text("\(defaultLocalizer.stringForKey(key: "Type")): ")
                                    .font(.system(size: 14))
                                    .fontWeight(.semibold)
                                    .frame(width: 100)
    //                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                                
                                Text(notificationList[i].name ?? "")
                                    .font(.system(size: 12))
                                    .fontWeight(.regular)
//                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                            } //: HStack
                            
                            // Description column
                            HStack {
                                
                                Text("\(defaultLocalizer.stringForKey(key: "Description")): ")
                                    .font(.system(size: 14))
                                    .fontWeight(.semibold)
                                    .frame(width: 100)
    //                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                                
                                Text(notificationList[i].description ?? "")
                                    .font(.system(size: 12))
                                    .fontWeight(.regular)
//                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                            } //: HStack
                            
                            // Send column
                            HStack {
                                
                                Text("\(defaultLocalizer.stringForKey(key: "Send")): ")
                                    .font(.system(size: 14))
                                    .fontWeight(.semibold)
                                    .frame(width: 100)
    //                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                                
                                Text("\(abs(notificationList[i].delay_num)) \(notificationList[i].delay_scale) \(notificationList[i].delay_num > 0 ? defaultLocalizer.stringForKey(key: "After") : defaultLocalizer.stringForKey(key: "Before"))")
                                    .font(.system(size: 12))
                                    .fontWeight(.regular)
//                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                            } //: HStack
                            
                        } //: VStack
                        
                        Spacer()
                        
                        // Action Buttons
                        VStack(alignment: .center) {
                            
                            // Edit Button
                            Button(action: {
                                goToEditNotification(index: i)
                            }, label: {
                                ZStack
                                {
                                    RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                        .stroke(Color.MyBlue, lineWidth: 2)
                                    
                                    Text(defaultLocalizer.stringForKey(key: "EDIT"))
                                        .fontWeight(.semibold)
                                        .foregroundColor(.MyBlue)
                                        .font(.system(size: 17))
                                }
                            })
                            //                            .padding(.horizontal, 20.0)
                            .frame(width: 75, height: 30.0)
                            
                            // Remove Button
                            Button(action: {
                                deleteNotification(notificationList[i].id ?? 0)
                            }, label: {
                                ZStack
                                {
                                    RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                        .stroke(Color.MyBlue, lineWidth: 2)
                                    
                                    Text(defaultLocalizer.stringForKey(key: "REMOVE"))
                                        .fontWeight(.semibold)
                                        .foregroundColor(.MyBlue)
                                        .font(.system(size: 17))
                                }
                            })
                            .frame(width: 75, height: 30.0)
                            
                        } //: VStack
                        
                    } //: HStack
                    .padding(.horizontal, 5)
                   
                    
//                    HStack {
//                        // Type column
//                        Text(notificationList[i].name ?? "")
//                            .font(.system(size: 17))
//                            .fontWeight(.semibold)
//                            .frame(maxWidth: .infinity, alignment: .leading)
//
//                        // Description column
//                        Text(notificationList[i].description ?? "")
//                            .font(.system(size: 17))
//                            .fontWeight(.semibold)
//                            .frame(maxWidth: .infinity, alignment: .leading)
//
//                        // Send column
//                        Text("\(notificationList[i].delay_num) \(notificationList[i].delay_scale) \(notificationList[i].delay_dir ?? 0)")
//                            .font(.system(size: 17))
//                            .fontWeight(.semibold)
//                            .frame(maxWidth: .infinity, alignment: .leading)
//
//                        // Edit Button
//                        Button(action: {
//                            goToEditNotification(index: i)
//                        }, label: {
//                                ZStack
//                                {
//                                    RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
//                                        .stroke(Color.MyBlue, lineWidth: 2)
////                                        .foregroundColor(.MyBlue)
//
//                                    Text("EDIT")
//                                        .fontWeight(.semibold)
//                                        .foregroundColor(.MyBlue)
//                                        .font(.system(size: 17))
//                                }
//                            })
////                            .padding(.horizontal, 20.0)
//                        .frame(width: 75, height: 44.0)
//
//                        // Remove Button
//                        Button(action: {
//                            deleteNotification(notificationList[i].id ?? 0)
//                        }, label: {
//                                ZStack
//                                {
//                                    RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
//                                        .stroke(Color.MyBlue, lineWidth: 2)
////                                        .foregroundColor(.MyBlue)
//
//                                    Text("REMOVE")
//                                        .fontWeight(.semibold)
//                                        .foregroundColor(.MyBlue)
//                                        .font(.system(size: 17))
//                                }
//                            })
//                        .frame(width: 100, height: 44.0)
//
//                    } //: HStack
                    
                } //: ForEach
                
            } //: ScrollView
            
        } //: VStack
        .alert(isPresented: $isDeleted) {
                   Alert(
                    title: Text("\(defaultLocalizer.stringForKey(key: "Successfully deleted"))!")
                   )
               }.padding()
        .onAppear {
            account.infoPage = -1
            getNotifications()
        }
        
    } //: body
    
    func Back() {
        currentPage = 0
    }
    
    func getNotifications() {
        print("DEBUG: getNotifications is called..")
        
        let params: [String: String] = [
            "action": "get-notifications",
            "session":account.SessionToken,
            "id": String(storeAccount.id)
        ]
        
        print("DEBUG: \(params)")
        
        APIRequest().Post(withParameters: params)
        {data in
            DispatchQueue.main.async {
                if(data != "" && data != "nosession")
                {
                    print(data)
                    //load transactions
                    let jsonData = data.data(using: .utf8)!
                    do {
                        notificationList = try JSONDecoder().decode([NewNotification].self, from: jsonData)
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
    
    func goToEditNotification(index: Int) {
        print("DEBUG: goToEditNotification is called..")
        currentPage = 16
        notification = notificationList[index]
    }
    
    func goToAddNotification() {
        print("DEBUG: goToAddNotification is called..")
        currentPage = 15
    }
    
    func deleteNotification(_ id: Int) {
        print("DEBUG: deleteNotification is called..")
        
        let params: [String: String] = [
            "action": "delete-notifications",
            "session":account.SessionToken,
            "id": "\(id)"
        ]
        
        APIRequest().Post(withParameters: params)
        {data in
            DispatchQueue.main.async {
                if(data != "" && data != "nosession" && data != "failed")
                {
                    print("DEBUG: Notification is deleted..")
                    getNotifications()
                    isDeleted = true
                }
                else
                {
                    print("DEBUG: getAllStampsheets return type is different then expected..")
                }
            }
        }
    }
    
}

//struct AllNotificationsView_Previews: PreviewProvider {
//    static var previews: some View {
//        AllNotificationsView()
//    }
//}
