//
//  TransactionsView.swift
//  ReferralAndRewards
//
//  Created by Ismail Gok on 2022-06-13.
//

import SwiftUI

struct TransactionsView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var custAccount: CustomerAccount
    @EnvironmentObject var storeAccount: StoreAccount
    @EnvironmentObject var account: Account
    @EnvironmentObject var sizing: Sizing
    
    @Binding var currentPage: Int
    
    @State private var transactionList: [Transaction] = []
    @State var selectedPeriod = 1
    @State private var isLoading = false
    
    let defaultLocalizer = AMPLocalizeUtils.defaultLocalizer
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
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
                
                Text(defaultLocalizer.stringForKey(key: "TRANSACTION RECORDS"))
                    .font(.system(size: 16))
                    .padding(.top, 5.0)
                    .padding(.leading, -35)
                
                Spacer()
                
            } //: HStack
            
            // Transactions
            ScrollView
            {
                ForEach(0..<transactionList.count, id: \.self)
                { i in
                    // Divider
                    Rectangle()
                        .foregroundColor(.MyGrey)
                        .frame(height:1)
                        .padding(.horizontal,20)
                    
                    
                    VStack(alignment: .leading, spacing:0)
                    {
                        // Cardholder HStack
                        HStack(spacing: 10) {
                            
                            Text("\(defaultLocalizer.stringForKey(key: "Cardholder")): ")
                                .fontWeight(.semibold)
                                .font(.system(size: 16))
                            
//                            Text("\(transactionList[i].lastname), \(transactionList[i].firstname)")
                            Text("\(transactionList[i].lastname ?? ""), \(transactionList[i].firstname ?? "")")
                                .font(.system(size: 16))
//                                .fixedSize(horizontal: false, vertical: true)
                            
                            Spacer()
                            
                        } //: HStack
                        
                        // Transactor HStack
                        HStack(spacing: 10) {

                            Text("\(defaultLocalizer.stringForKey(key: "Transactor")): ")
                                .fontWeight(.semibold)
                                .font(.system(size: 16))

                            Text(transactionList[i].transactor_displayname ?? "")
                                .font(.system(size: 16))
//                                .fixedSize(horizontal: false, vertical: true)

                        } //: HStack

                        // Description HStack
                        HStack(spacing: 10) {

                            Text("\(defaultLocalizer.stringForKey(key: "Description")): ")
                                .fontWeight(.semibold)
                                .font(.system(size: 16))

                            Text(transactionList[i].description ?? "")
                                .font(.system(size: 16))
//                                .fixedSize(horizontal: false, vertical: true)

                        } //: HStack

                        // Points HStack
                        HStack(spacing: 10) {

                            Text("+/- \(defaultLocalizer.stringForKey(key: "Points")): ")
                                .fontWeight(.semibold)
                                .font(.system(size: 16))

                            Text("\(transactionList[i].points ?? 0)")
                                .font(.system(size: 16))
//                                .fixedSize(horizontal: false, vertical: true)

                        } //: HStack

                        // Date HStack
                        HStack(spacing: 10) {

                            Text("\(defaultLocalizer.stringForKey(key: "Date")): ")
                                .fontWeight(.semibold)
                                .font(.system(size: 16))

                            Text(transactionList[i].created ?? "")
                                .font(.system(size: 16))
//                                .fixedSize(horizontal: false, vertical: true)

                        } //: HStack

                        // New Points HStack
//                        HStack(spacing: 10) {
//
//                            Text("New Points: ")
//                                .fontWeight(.semibold)
//                                .font(.system(size: 20))
//
//                            Text(transactionList[i].newPoints ?? "")
//                                .font(.system(size: 20))
////                                .fixedSize(horizontal: false, vertical: true)
//
//                        } //: HStack

                        // Dollars HStack
//                        HStack(spacing: 10) {
//
//                            Text("+/- Dollars: ")
//                                .fontWeight(.semibold)
//                                .font(.system(size: 20))
//
//                            Text(transactionList[i].dollars ?? "")
//                                .font(.system(size: 20))
////                                .fixedSize(horizontal: false, vertical: true)
//
//                        } //: HStack
//
//                        // New Dollars HStack
//                        HStack(spacing: 10) {
//
//                            Text("New Dollars: ")
//                                .fontWeight(.semibold)
//                                .font(.system(size: 20))
//
//                            Text(transactionList[i].newDollars ?? "")
//                                .font(.system(size: 20))
////                                .fixedSize(horizontal: false, vertical: true)
//
//                        } //: HStack
//
//                        // Pin used HStack
//                        HStack(spacing: 10) {
//
//                            Text("Pin used?: ")
//                                .fontWeight(.semibold)
//                                .font(.system(size: 20))
//
//                            Text(transactionList[i].pinUsed ?? "")
//                                .font(.system(size: 20))
////                                .fixedSize(horizontal: false, vertical: true)
//
//                        } //: HStack
                        
                       
                    } //: VStack
                    .padding(.horizontal, 10.0)
                } //: ForEach
                
                // Divider
                Rectangle()
                    .foregroundColor(.MyGrey)
                    .frame(height:1)
                    .padding(.horizontal,20)
                
            } //: ScrollView
            
            if(isLoading)
            {
                HStack {
                    Spacer()
                    
                    GIFView(gifName: "loading")
                        .frame(width: 40.0, height: 40.0)
                        .frame(maxHeight: .infinity, alignment: .top)
                    
                    Spacer()
                }
                
            }
            
        } //: VStack
        .onAppear {
            account.infoPage = -1
            getAllTransactions()
        }
        
    } //: body
    
    func Back() {
        currentPage = 0
    }
    
    func getAllTransactions() {
        let params: [String: String] = [
            "action": "get-transactions",
            "session":account.SessionToken,
            "store": String(storeAccount.id)
        ]
        
        isLoading = true
        
        APIRequest().Post(withParameters: params)
        {data in
            DispatchQueue.main.async {
                if(data != "" && data != "nosession")
                {
                    print(data)
                    //load transactions
                    let jsonData = data.data(using: .utf8)!
                    do {
                        transactionList = try JSONDecoder().decode([Transaction].self, from: jsonData)
                    }
                    catch {
                        print("Failed to fetch the transactions: \(error)")
                    }
                    
                    isLoading = false
                }
                else
                {
                    print("DEBUG: getAllTransactions return type is different then expected..")
                    isLoading = false
                }
            }
        }
    }
}



//struct TransactionsView_Previews: PreviewProvider {
//    static var previews: some View {
//        TransactionsView()
//    }
//}
