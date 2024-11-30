//
//  ReportsView.swift
//  ReferralAndRewards
//
//  Created by Ismail Gok on 2022-06-18.
//

import SwiftUI

struct ReportsView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var custAccount:CustomerAccount
    @EnvironmentObject var storeAccount:StoreAccount
    @EnvironmentObject var account:Account
    @EnvironmentObject var sizing:Sizing
    
    @Binding var currentPage:Int
    
    @State private var reportList: [Report] = []
    @State var selectedPeriod = 1
    @State var errorText = ""
    
    let defaultLocalizer = AMPLocalizeUtils.defaultLocalizer
    
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
                
                Text(defaultLocalizer.stringForKey(key: "REPORTS"))
                    .font(.system(size: 17))
                    .padding(.top, 5.0)
                    .padding(.leading, -35)
                
                Spacer()
                
            } //: HStack
            
            Divider()
            
            // Period selection
            HStack{
                
                //                Text("Period: ")
                //                    .font(.system(size: 16, weight: .semibold))
                
                Picker(selection: $selectedPeriod, label: Text("\(defaultLocalizer.stringForKey(key: "Period")):")) {
                    Text("1 \(defaultLocalizer.stringForKey(key: "Day"))").tag(1)
                    Text("7 \(defaultLocalizer.stringForKey(key: "Days"))").tag(2)
                    Text("30 \(defaultLocalizer.stringForKey(key: "Days"))").tag(3)
                }
                .pickerStyle(.wheel)
                
            } //: HStack
            .frame(height: 150, alignment: .center)
            
            // Filter selection
            
            
            // View Report Button
            Button(action: {
                viewReports()
            }, label: {
                ZStack
                {
                    RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                        .stroke(Color.MyBlue, lineWidth: 2)
                    //                                        .foregroundColor(.MyBlue)
                    
                    Text(defaultLocalizer.stringForKey(key: "View Report"))
                        .fontWeight(.semibold)
                        .foregroundColor(.MyBlue)
                        .font(.system(size: 17))
                }
            })
            .frame(width: 100, height: 50, alignment: .center)
            
            // Fetched Visits
            
//            HStack(spacing: 0) {
//                Text("Cardholder ID")
//                    .font(.system(size: 16))
//                    .fontWeight(.semibold)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//
//                Text("Name")
//                    .font(.system(size: 16))
//                    .fontWeight(.semibold)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//
//                Text("Date")
//                    .font(.system(size: 16))
//                    .fontWeight(.semibold)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//
//
//            }
//            .padding(.top, 20)
            
            // Error message
            Text(errorText)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundColor(.red)
                .font(.system(size: 20))
            
            ScrollView
            {
                ForEach(0..<reportList.count, id: \.self)
                { i in
                    Rectangle()
                        .foregroundColor(.MyGrey)
                        .frame(height:1)
                        .padding(.horizontal,20)
                    
                    VStack(alignment: .leading, spacing: 10)
                    {
                        HStack {
                            
                            Text("\(defaultLocalizer.stringForKey(key: "Cardholder ID")): ")
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                            
                            Text(reportList[i].cardholder ?? "")
                                .fontWeight(.regular)
                                .font(.system(size: 14))
                                .fixedSize(horizontal: false, vertical: true)
                            
                            Spacer()
                            
                        } //: HStack
                        
                        HStack {
                            
                            Text("\(defaultLocalizer.stringForKey(key: "Name")): ")
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                            
                            Text("\(reportList[i].lastname ?? "") , \(reportList[i].firstname ?? "")")
                                .fontWeight(.regular)
                                .font(.system(size: 14))
                                .fixedSize(horizontal: false, vertical: true)
                            
                            Spacer()
                        } //: HStack
                        
                        HStack {
                            
                            Text("\(defaultLocalizer.stringForKey(key: "Date")): ")
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                            
                            Text(reportList[i].metatime ?? "")
                                .fontWeight(.regular)
                                .font(.system(size: 14))
                                .fixedSize(horizontal: false, vertical: true)
                            
                            Spacer()
                        } //: HStack
                        
                    } //: VStack
                    .padding(.horizontal, 10.0)
                }
                Rectangle()
                    .foregroundColor(.MyGrey)
                    .frame(height:1)
                    .padding(.horizontal,20)
                
            } //: ScrollView
            
            
        } //: VStack
        .onAppear {
            account.infoPage = -1
        }
        
    } //: body
    
    func Back() -> Void{
        currentPage = 0
    }
    
    func viewReports() {
        print("DEBUG: viewReports is called..")
        
        var newPeriod = "1"
        
        if selectedPeriod == 2 {
            newPeriod = "7"
        }
        else if selectedPeriod == 3 {
            newPeriod = "30"
        }
        
        let params: [String: String] = [
            "action": "get-report",
            "session":account.SessionToken,
            "store": String(storeAccount.id),
            "period": newPeriod
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
                        reportList = try JSONDecoder().decode([Report].self, from: jsonData)
                        
                        if reportList.isEmpty {
                            errorText = "\(defaultLocalizer.stringForKey(key: "No Data Found"))!"
                        }
                        else {
                            errorText = ""
                        }
                    }
                    catch {
                        print("Failed to fetch the reports: \(error)")
                        errorText = "\(defaultLocalizer.stringForKey(key: "Something went wrong"))!"
                    }
                    
                }
                else
                {
                    print("DEBUG: viewReports return type is different then expected..")
                    errorText = "\(defaultLocalizer.stringForKey(key: "Something went wrong"))!"
                }
            }
        }
    }
}

//struct ReportsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReportsView()
//    }
//}
