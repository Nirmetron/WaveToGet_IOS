//
//  StoreSearchView.swift
//  ReferralAndRewards
//
//  Created by Ismail Gok on 2022-08-22.
//

import SwiftUI

struct StoreSearchView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var account:Account
    @EnvironmentObject var custAccount:CustomerAccount
    @EnvironmentObject var storeAccount:StoreAccount
    @EnvironmentObject var sizing:Sizing
    
    @Binding public var page:Int
    @Binding public var selectedAccount: acc
    
    @State private var accountList: [acc] = []
//    @State private var selectedAccount: acc = acc()
    @State var searchText = ""
    @State var searching = false
    @State private var errorText = ""
    
    var body: some View {
        
        VStack {
            
            ZStack
            {
                Button(action: { Back() }, label: {
                    ZStack
                    {
                        Image("back6")
                            .resizable()
                            .frame(width: 35.0, height: 35.0)
                            .scaledToFit()
                            .frame(alignment: .top)
                            .colorMultiply(.MyBlue)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                })
                Text("SEARCH A STORE TO REGISTER")
                    .font(.system(size: 17))
                    .padding(.top, 5.0)
            } //: ZStack
            
            // Search bar
//            SearchBar2(searchText: $searchText, searching: $searching)
            SearchBar(text: $searchText, isEditing: $searching)
                .padding()
            
            if searchText.count > 2 {
                List {
                    
                    ForEach(accountList.filter({ (tmpAccount: acc) -> Bool in
                        return tmpAccount.name?.lowercased().contains(searchText.lowercased()) ?? false || searchText == ""
                    }), id: \.self) { singleAccount in
                        
                        VStack {
                            HStack {
                                Text(singleAccount.name ?? "unnamed")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.system(size: 15))
                                
//                                Spacer()
                                
                            } //: HStack
                            .frame(maxWidth: .infinity)
                           
                        } //: VStack
                        .contentShape(Rectangle())
                        .onTapGesture {
                            page = 5
                            selectedAccount = singleAccount
                        }
                        
                    }
                    
                    if accountList.filter({ (tmpAccount: acc) -> Bool in
                        return tmpAccount.name?.lowercased().contains(searchText.lowercased()) ?? false || searchText == ""
                    }).count == 0 {
                        Text("Store cannot found!")
                            .font(.system(size: 20))
                            .foregroundColor(.MyRed)
                    }
                    
                } //: List
                .listStyle(GroupedListStyle())
                .gesture(DragGesture()
                    .onChanged({ _ in
                        UIApplication.shared.dismissKeyboard()
                    })
                )
                
                
            }
            else {
                Text("Enter at least 3 characters to search")
                    .font(.system(size: 20))
                    .italic()
            }
            
            Spacer()
            
        } //: VStack
        .onAppear {
            GetAccStore()
            account.infoPage = 3
        }
        
        
    } //: body
    
    func Back() -> Void{
        page = 0
    }
    
    func GetAccStore() -> Void {

            APIRequest().Post(withParameters: ["action":"get-all-stores"])
            {data in
                DispatchQueue.main.async {
                    print("------------")
                    print(data)
                    print("------------")
                    if(data != "false" && data != "" && data != "nosession" && data != "[]")
                    {
                        let jsonData = data.data(using: .utf8)!
                        let test: [acc] = try! JSONDecoder().decode([acc].self, from: jsonData)
                        //print(test)
//                        var newAcc = acc()
//                        newAcc.id = 0
//                        newAcc.name = "Select a store"
//                        accountList.append(newAcc)
                        accountList += test
                        if(accountList.count > 0)
                        {
                            selectedAccount = accountList[0]
                        }
                        errorText = ""
                        //                        for accs in accountList {
                        //                            print(accs.store_displayname)
                        //                        }
                    }
                    else
                    {
                        accountList.removeAll()
                        selectedAccount = acc()
                    }
                }
            }
    }
    
//    struct acc: Decodable, Hashable {
//        var id: Int?
//        var name: String?
//    }
    
}

//struct StoreSearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        StoreSearchView(page: .constant(20))
//    }
//}

struct SearchBar2: View {
    
    @Binding var searchText: String
    @Binding var searching: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color("LightGray"))
            
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search ..", text: $searchText) { startedEditing in
                    if startedEditing {
                        withAnimation {
                            searching = true
                        }
                    }
                } onCommit: {
                    withAnimation {
                        searching = false
                    }
                }
                
            } //: HStack
            .foregroundColor(.gray)
            .padding(.leading, 13)
            .font(.system(size: 15))
            
        } //: ZStack
        .frame(height: 40)
        .cornerRadius(13)
        .padding()
    }
}
