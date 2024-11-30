//
//  EditPlans.swift
//  wavetoget
//
//  Created by Jesse Lugassy on 2021-04-06.
//
import SwiftUI

struct EditPlans: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var custAccount:CustomerAccount
    @EnvironmentObject var storeAccount:StoreAccount
    @EnvironmentObject var account:Account
    @EnvironmentObject var sizing:Sizing
    @Binding var currentPage:Int
    @Binding var selectedPlan:Int
    @State var name = ""
    @State var duration = ""
    @State var errorText = ""
    @State var isUpdated = false
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
                    .padding([.top, .trailing], 10.0)
                })
                
                Spacer()
                
                Text(defaultLocalizer.stringForKey(key: "EDIT PLANS"))
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
                
                TextField(defaultLocalizer.stringForKey(key: "Duration"), text: $duration)
                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.vertical, 5)
                    .padding(.trailing, 10.0)
                    .disableAutocorrection(true)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .keyboardType(.numberPad)
                    .font(.system(size: 15))
                
                Button(action: {CreatePlan()}, label: {
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
                ForEach(0..<storeAccount.plans.count, id: \.self) { i in
                    Rectangle()
                        .foregroundColor(.MyGrey)
                        .frame(height:1)
                        .padding(.horizontal,20)
                    HStack
                    {
                        VStack
                        {
                            HStack {
                                
                                Text("\(defaultLocalizer.stringForKey(key: "Name")): ")
                                    .font(.system(size: 18, weight: .semibold))
                                
                                Text(storeAccount.plans[i].name)
                                    .font(.system(size: 16))
                                    .fontWeight(.regular)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            } //: HStack
                            
                            HStack {
                                Text("\(defaultLocalizer.stringForKey(key: "Duration")): ")
                                    .font(.system(size: 18, weight: .semibold))
                                
                                Text(String("\(storeAccount.plans[i].term_months)"))
                                    .font(.system(size: 16))
                                    .frame(maxWidth: .infinity, alignment: .leading)
    //                                .padding(.bottom, 10.0)
                            } //: HStack
                            
                            
                        }
                        .frame(maxWidth:.infinity, alignment:.leading)
                        Button(action: {Edit(storeAccount.plans[i].id)}, label: {
                                ZStack
                                {
                                    RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                        .stroke(Color.MyBlue, lineWidth: 2)
//                                        .foregroundColor(.MyBlue)
                                    
                                    Text(defaultLocalizer.stringForKey(key: "Edit"))
                                        .fontWeight(.semibold)
                                        .foregroundColor(.MyBlue)
                                        .font(.system(size: 17))
                                }
                            })
                        .frame(width:60,height: 44.0)
                        Button(action: {RemovePlan(storeAccount.plans[i].id)}, label: {
                            ZStack
                            {
                                RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                    .stroke(Color.MyBlue, lineWidth: 2)
//                                    .foregroundColor(.MyBlue)
                                
                                Text(defaultLocalizer.stringForKey(key: "Remove"))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.MyBlue)
                                    .font(.system(size: 17))
                            }
                            })
                        .frame(width:80,height: 44.0)
                    }
                }
            }
        }
        .onAppear{
            account.infoPage = 17
        }
        .padding(.bottom, 1)
        .padding(.horizontal, 10)
//        .padding([.leading, .bottom, .trailing], 20.0)
        .alert(isPresented: $isUpdated) {
                   Alert(
                    title: Text("\(defaultLocalizer.stringForKey(key: "Successfully added"))!")
                   )
               }
            .alert(isPresented: $isDeleted) {
                       Alert(
                        title: Text("\(defaultLocalizer.stringForKey(key: "Successfully deleted"))!")
                       )
                   }
    }
    func Edit(_ id:Int) -> Void{
        currentPage = 3
        selectedPlan = id
    }
    func RemovePlan(_ id:Int)
    {
        APIRequest().Post(withParameters: ["action":"remove-plan","session":account.SessionToken,"id":String(id)])
        {data in
            print(data + " ---- TestJsonParse() ----")
            DispatchQueue.main.async {
                if(data != "nosession" && data != "" && data == "1")
                {
                    var i = 0
                    for plan in storeAccount.plans {
                        if(plan.id == id)
                        {
                            storeAccount.plans.remove(at: i)
                            isDeleted = true
                        }
                        
                        i += 1
                        
                    }
                }
            }
        }
    }
    func CreatePlan()
    {
        if(name == "")
        {
            errorText = "\(defaultLocalizer.stringForKey(key: "Please name the plan"))..."
            return
        }
        if(duration == "")
        {
            errorText = "\(defaultLocalizer.stringForKey(key: "Please add a duration to the plan"))..."
            return
        }
        APIRequest().Post(withParameters: ["action":"create-plan","session":account.SessionToken,"store":String(storeAccount.id),"name":name, "months":duration])
        {data in
            print(data + " ---- TestJsonParse() ----")
            errorText = ""
            DispatchQueue.main.async {
                if(data != "nosession" && data != "")
                {
                    storeAccount.plans.append(AssignPlan(withParameters: Int(data) ?? 0, store: storeAccount.id, name: name, term_months: Int(duration) ?? 0, details: "", fallback_plan: 0, created: "", updated: ""))
                    name = ""
                    duration = ""
                    isUpdated = true
                }
            }
        }
    }
    struct Plan: Decodable {
        var id: Int?
        var store: Int?
        var name: String?
        var term_months: Int?
        var details: String?
        var fallback_plan: Int?
        var created: String?
        var updated: String?
    }
    func Back() -> Void{
        currentPage = 0
    }
}
