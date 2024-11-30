//
//  RemoveRedeemable.swift
//  wavetoget
//
//  Created by Jesse Lugassy on 2021-04-01.
//

import SwiftUI

struct EditRedeemable: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var custAccount:CustomerAccount
    @EnvironmentObject var storeAccount:StoreAccount
    @EnvironmentObject var account:Account
    @EnvironmentObject var sizing:Sizing
    @Binding var currentPage:Int
    @Binding var selectedPlan: Int
    @State var name = ""
    @State var price = ""
    @State var errorText = ""
    @State var isDeleted = false
    
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
                
                Text(defaultLocalizer.stringForKey(key: "EDIT REDEEMABLES"))
                    .font(.system(size: 17))
                    .padding(.top, 5.0)
                    .padding(.leading, -35)
                
                Spacer()
                
            } //: HStack
            Text(errorText)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundColor(.red)
            HStack(spacing: 0)
            {
                TextField(defaultLocalizer.stringForKey(key: "Name"), text: $name)
                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.vertical, 5)
                    .padding(.horizontal, 10.0)
                    .disableAutocorrection(true)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .font(.system(size: 15))
                
                TextField(defaultLocalizer.stringForKey(key: "Cost"), text: $price)
                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.vertical, 5)
                    .padding(.trailing, 10.0)
                    .disableAutocorrection(true)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .keyboardType(.numberPad)
                    .font(.system(size: 15))
                
                Button(action: {AddRedeemable()}, label: {
                    ZStack
                    {
                        RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                            .stroke(Color.MyBlue, lineWidth: 2)
//                            .foregroundColor(.MyBlue)
                        
                        Text(defaultLocalizer.stringForKey(key: "ADD"))
                            .fontWeight(.semibold)
                            .foregroundColor(.MyBlue)
                            .font(.system(size: 15))
                    }
                })
                .padding(.trailing, 10.0)
                .frame(width: 70.0, height: 40.0)
            }
            .padding(.bottom, 20)
            ScrollView
            {
                ForEach(0..<storeAccount.redeemables.count, id: \.self) { i in
                    Rectangle()
                        .foregroundColor(.MyGrey)
                        .frame(height:1)
                        .padding(.horizontal,20)
                    HStack
                    {
                        VStack
                        {
                            Text(storeAccount.redeemables[i].name)
                                .font(.system(size: 17))
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(String(storeAccount.redeemables[i].points))
                                .font(.system(size: 16))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.bottom, 10.0)
                        }
                        .padding(.leading, 20.0)
                        .frame(maxWidth: .infinity, alignment: .leading)

                        Button(action: {
                            editRedeemable(i)
                        }, label: {
                                ZStack
                                {
                                    RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                        .stroke(Color.MyBlue, lineWidth: 2)
//                                        .foregroundColor(.MyBlue)
                                    
                                    Text(defaultLocalizer.stringForKey(key: "EDIT"))
                                        .fontWeight(.semibold)
                                        .foregroundColor(.MyBlue)
                                        .font(.system(size: 17))
                                }
                            })
//                            .padding(.horizontal, 20.0)
                        .frame(width: 75, height: 44.0)
                        
                        Button(action: {RemoveRedeemable(storeAccount.redeemables[i].id)}, label: {
                                ZStack
                                {
                                    RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                        .stroke(Color.MyBlue, lineWidth: 2)
//                                        .foregroundColor(.MyBlue)
                                    
                                    Text(defaultLocalizer.stringForKey(key: "REMOVE"))
                                        .fontWeight(.semibold)
                                        .foregroundColor(.MyBlue)
                                        .font(.system(size: 17))
                                }
                            })
                        .frame(width: 100, height: 44.0)
                    }
                }
            }
        }
        .padding(.bottom, 1)
        .alert(isPresented: $isDeleted) {
                   Alert(
                    title: Text("\(defaultLocalizer.stringForKey(key: "Successfully deleted"))!")
                   )
               }
        .onAppear {
            account.infoPage = 16
            GetRedeemables()
        }
    }
    
    func GetRedeemables() {
        
        APIRequest().Post(withParameters: ["action":"get-store-redeemables","session":account.SessionToken,"store":String(storeAccount.id)])
        {data in
            DispatchQueue.main.async {
                if(data != "" && data != "nosession")
                {
                    print(data)
                    //load account
                    let jsonData = data.data(using: .utf8)!
                    let test: [Redeemable] = try! JSONDecoder().decode([Redeemable].self, from: jsonData)
                    assignRedeemable(cc: test)
                }
                else
                {
                    //add card to store
                }
            }
        }
    }
    
    func assignRedeemable(cc: [Redeemable])
    {
        storeAccount.redeemables.removeAll()
        for Redeemables in cc {
            storeAccount.redeemables.append(AssignRedeemable(withParameters: Redeemables.id ?? 0, name: Redeemables.name ?? "", description: Redeemables.description ?? "", image: Redeemables.image ?? "", points: Redeemables.points ?? 0))
        }
    }
    
    func RemoveRedeemable(_ id:Int)
    {
        APIRequest().Post(withParameters: ["action":"remove-store-redeemable","session":account.SessionToken,"id":String(id)])
        {data in
            print(data + " ---- TestJsonParse() ----")
            DispatchQueue.main.async {
                if(data != "nosession" && data != "" && data == "1")
                {
                    var i = 0
                    for redeemable in storeAccount.redeemables {
                        if(redeemable.id == id)
                        {
                            isDeleted = true
                            storeAccount.redeemables.remove(at: i)
                        }
                        
                        i += 1
                        
                    }
                }
            }
        }
    }
    func AddRedeemable()
    {
        if(name == "")
        {
            errorText = "\(defaultLocalizer.stringForKey(key: "Please name the redeemable"))..."
            return
        }
        if(price == "")
        {
            errorText = "\(defaultLocalizer.stringForKey(key: "Please add a price to the redeemable"))..."
            return
        }
        APIRequest().Post(withParameters: ["action":"add-store-redeemable","session":account.SessionToken,"store":String(storeAccount.id),"name":name, "points":price])
        {data in
            print(data + " ---- TestJsonParse() ----")
            DispatchQueue.main.async {
                if(data != "nosession" && data != "")
                {
                    storeAccount.redeemables.append(AssignRedeemable(withParameters: Int(data) ?? 0, name: name, description: "", image: "", points: Int(price) ?? 0))
                    name = ""
                    price = ""
//                    Back()
                }
            }
        }
    }
    
    func editRedeemable(_ index: Int) {
        currentPage = 11
        selectedPlan = index
    }
    
//    struct Redeemable: Decodable {
//        var id: Int?
//        var name: String?
//        var description: String?
//        var image: String?
//        var points: Int?
//    }
    func Back() -> Void{
        currentPage = 0
    }
}
