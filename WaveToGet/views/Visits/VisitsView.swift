//
//  VisitsView.swift
//  ReferralAndRewards
//
//  Created by Ismail Gok on 2022-06-12.
//

import SwiftUI

struct VisitsView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var custAccount:CustomerAccount
    @EnvironmentObject var storeAccount:StoreAccount
    @EnvironmentObject var account:Account
    @EnvironmentObject var sizing:Sizing
    
    @Binding var currentPage:Int
    
    @State private var visitList: [Visit] = []
    @State var selectedPeriod = 1
    
    var body: some View {
        VStack()
        {
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
                
                Text("VISIT RECORDS")
                    .font(.system(size: 17))
                    .padding(.top, 5.0)
                    .padding(.leading, -35)
                
                Spacer()
                
            } //: HStack
            
            // Fetched Visits
            
            ScrollView {
                ForEach(0 ..< visitList.count, id: \.self) { i in
                    Rectangle()
                        .foregroundColor(.MyGrey)
                        .frame(height:1)
                        .padding(.horizontal,20)
                                            
                        VStack(alignment: .leading) {
                            
                            // Cardholder column
                            HStack {
                                
                                Text("Cardholder: ")
                                    .font(.system(size: 14))
                                    .fontWeight(.semibold)
                                    .frame(width: 100)
    //                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                                
                                Text("\(visitList[i].cardholder ?? 0)")
                                    .font(.system(size: 12))
                                    .fontWeight(.regular)
//                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                            } //: HStack
                            
                            // Creator column
                            HStack {
                                
                                Text("Creator: ")
                                    .font(.system(size: 14))
                                    .fontWeight(.semibold)
                                    .frame(width: 100)
    //                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                                
                                Text(visitList[i].creator_displayname ?? "")
                                    .font(.system(size: 12))
                                    .fontWeight(.regular)
//                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                            } //: HStack
                            
                            // Details column
                            HStack {
                                
                                Text("Details: ")
                                    .font(.system(size: 14))
                                    .fontWeight(.semibold)
                                    .frame(width: 100)
    //                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                                
                                Text(visitList[i].details ?? "")
                                    .font(.system(size: 12))
                                    .fontWeight(.regular)
//                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                            } //: HStack
                            
                            // Time column
                            HStack {
                                
                                Text("Time: ")
                                    .font(.system(size: 14))
                                    .fontWeight(.semibold)
                                    .frame(width: 100)
    //                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                                
                                Text(visitList[i].metatime ?? "")
                                    .font(.system(size: 12))
                                    .fontWeight(.regular)
//                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                            } //: HStack
                            
                        } //: VStack
                        
                  
                    
                   
                    
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
        .onAppear(perform: {
            account.infoPage = -1
            getVisits()
        })
        .padding(.bottom, 1)
    } //: body
    
    func Back() -> Void{
        currentPage = 0
    }
    
    func getVisits() {
        
        print("DEBUG: getVisits is called..")
        
        let params: [String: String] = [
            "action": "get-records",
            "session":account.SessionToken,
            "store": String(storeAccount.id),
            "record_format": "4"
        ]
        
        print("DEBUG: \(params)")
        
        APIRequest().Post(withParameters: params)
        {data in
            DispatchQueue.main.async {
                if(data != "" && data != "nosession")
                {
//                    print(data)
                    //load transactions
                    let jsonData = data.data(using: .utf8)!
                    do {
                        visitList = try JSONDecoder().decode([Visit].self, from: jsonData)
                    }
                    catch {
                        print("Failed to fetch the visits: \(error)")
                    }
                    
                }
                else
                {
                    print("DEBUG: getVisits return type is different then expected..")
                }
            }
        }
    }
    
}

//struct VisitsView_Previews: PreviewProvider {
//    static var previews: some View {
//        VisitsView()
//    }
//}
