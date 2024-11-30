//
//  EditBenifits.swift
//  wavetoget
//
//  Created by Jesse Lugassy on 2021-04-06.
//

import SwiftUI

struct EditBenefits: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var custAccount:CustomerAccount
    @EnvironmentObject var storeAccount:StoreAccount
    @EnvironmentObject var account:Account
    @EnvironmentObject var sizing:Sizing
    @Binding var currentPage:Int
    @Binding var selectedPlan:Int
    @State var name = ""
    @State var duration = ""
    @State var description = ""
    @State var quantity = ""
    @State var errorText = ""
    @State var isUpdated = false
    @State var isBenefitDeleted = false
    @State private var benefitsList: [Benefit] = []
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
                
                Text("EDIT PLAN")
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
                TextField("Name", text: $name)
                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.vertical, 5)
                    .padding(.horizontal, 10.0)
                    .disableAutocorrection(true)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .font(.system(size: 15))
                
                TextField("Duration", text: $duration)
                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.vertical, 5)
                    .padding(.trailing, 10.0)
                    .disableAutocorrection(true)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .keyboardType(.numberPad)
                    .font(.system(size: 15))
                
                Button(action: {
                    UpdatePlan()
                }, label: {
                    ZStack
                    {
                        RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                            .foregroundColor(.MyBlue)
                        
                        Text("UPDATE")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .font(.system(size: 13))
                    }
                })
                .padding(.trailing, 10.0)
                .frame(width: 70.0, height: 40.0)
            } //: HStack
            .padding(.bottom, 20)
            .alert(isPresented: $isUpdated) {
                       Alert(
                           title: Text("Successfully updated!")
                       )
                   }
            
            Rectangle()
                .foregroundColor(.MyGrey)
                .frame(height:1)
                .padding(.horizontal,20)
            Text("ADD BENEFIT")
                .font(.system(size: 17))
                .padding(.top, 5.0)
            HStack(spacing: 0)
            {
                TextField("Description", text: $description)
                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.vertical, 5)
                    .padding(.horizontal, 10.0)
                    .disableAutocorrection(true)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .font(.system(size: 15))
                
                TextField("Quantity", text: $quantity)
                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.vertical, 5)
                    .padding(.trailing, 10.0)
                    .disableAutocorrection(true)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .keyboardType(.numberPad)
                    .font(.system(size: 15))
                
                Button(action: {CreateBenefit()}, label: {
                    ZStack
                    {
                        RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                            .stroke(Color.MyBlue, lineWidth: 2)
//                            .foregroundColor(.MyBlue)
                        
                        Text("ADD")
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
                ForEach(0..<benefitsList.count, id: \.self) { i in
                    Rectangle()
                        .foregroundColor(.MyGrey)
                        .frame(height:1)
                        .padding(.horizontal,20)
                    HStack
                    {
                        VStack
                        {
                            HStack {
                                
                                Text("Description: ")
                                    .font(.system(size: 18, weight: .semibold))
                                
                                Text(benefitsList[i].description ?? "")
                                    .font(.system(size: 16))
                                    .fontWeight(.regular)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            } //: HStack
                            
                            HStack {
                                Text("Quantity: ")
                                    .font(.system(size: 18, weight: .semibold))
                                
                                Text(String(benefitsList[i].quantity ?? 0))
                                    .font(.system(size: 16))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            } //: HStack
                            
                            
                        } //: VStack
                        .frame(maxWidth:.infinity, alignment:.leading)
                        
                        Button(action: {RemoveBenefit(benefitsList[i].id ?? 0)}, label: {
                                ZStack
                                {
                                    RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                        .stroke(Color.MyBlue, lineWidth: 2)
//                                        .foregroundColor(.MyBlue)
                                    
                                    Text("REMOVE")
                                        .fontWeight(.semibold)
                                        .foregroundColor(.MyBlue)
                                        .font(.system(size: 14))
                                }
                            })
                        .frame(width:sizing.buttonWidth,height: 44.0)
                       
                    }
                    .padding(.horizontal, 10)
                }
            } //: ScrollView
            .alert(isPresented: $isBenefitDeleted) {
                       Alert(
                           title: Text("Benefit is deleted successfully!")
                       )
                   }
           
        }
        .onAppear(perform: {
            account.infoPage = -1
            GetPlan()
            setInitialValues()
        })
        .padding(.bottom, 1)
        //.padding([.leading, .bottom, .trailing], 20.0)
    }
    private func setInitialValues() {
        name = storeAccount.plans.first(where: { plan in
            return plan.id == selectedPlan
        })?.name ?? ""
        
        duration = String(storeAccount.plans.first(where: { plan in
            return plan.id == selectedPlan
        })?.term_months ?? 0) == "0" ? "" : String(storeAccount.plans.first(where: { plan in return plan.id == selectedPlan })?.term_months ?? 0)
    }
//    [{"id":108,"plan":175,"description":"No Line Member ","quantity":99,"renewal":1,"created":"2018-05-15 08:52:17","updated":"2018-05-15 08:52:17","renewal_name":"None"},{"id":109,"plan":175,"description":"Money Order ","quantity":5,"renewal":1,"created":"2018-05-15 08:52:47","updated":"2018-05-15 08:52:47","renewal_name":"None"}]
    func UpdatePlan()
    {
        APIRequest().Post(withParameters: ["action":"update-plan","session":account.SessionToken,"id":String(selectedPlan), "name": name, "duration": duration])
        {data in
            print(data + " ---- TestJsonParse() ----")
            DispatchQueue.main.async {
                if(data != "nosession" && data != "" && data != "failed")
                {
                    //let jsonData = data.data(using: .utf8)!
//                    var i = 0
                    for (i, plan) in storeAccount.plans.enumerated() {
                        if (plan.id == selectedPlan) {
                            isUpdated = true
                            
                            storeAccount.plans[i].name = name
                            storeAccount.plans[i].term_months = Int(duration) ?? 0
                            
                            return
                        }
                    }
                }
            }
        }
    }
    
    func GetPlan()
    {
        APIRequest().Post(withParameters: ["action":"get-plan","session":account.SessionToken,"id":String(selectedPlan)])
        {data in
            print(data + " ---- TestJsonParse() ----")
            DispatchQueue.main.async {
                if(data != "nosession" && data != "")
                {
                    let jsonData = data.data(using: .utf8)!
                    let test: [Benefit] = try! JSONDecoder().decode([Benefit].self, from: jsonData)
                    
                    benefitsList = test
                }
            }
        }
    }
    func RemoveBenefit(_ id:Int)
    {
        APIRequest().Post(withParameters: ["action":"remove-benefit","session":account.SessionToken,"id":String(id)])
        {data in
            print(data + " ---- TestJsonParse() ----")
            DispatchQueue.main.async {
                if(data != "nosession" && data != "" && data == "1")
                {
                    var i = 0
                    for benefit in benefitsList {
                        if(benefit.id == id)
                        {
                            isBenefitDeleted = true
                            
                            benefitsList.remove(at: i)
                        }
                        
                        i += 1
                        
                    }
                }
            }
        }
    }
    func CreateBenefit()
    {
        if(description == "")
        {
            errorText = "Please add a description to the benefit..."
            return
        }
        if(quantity == "")
        {
            errorText = "Please add a quantity to the benefit..."
            return
        }//$req['plan'], $req['description'], $req['quantity'], $req['duration'])
        APIRequest().Post(withParameters: ["action":"add-benefit","session":account.SessionToken,"plan":String(selectedPlan),"description":description,"quantity":quantity, "duration":"3"])
        {data in
            print(data + " ---- TestJsonParse() ----")
            DispatchQueue.main.async {
                if(data != "nosession" && data != "")
                {
                    var newBenefit = Benefit()
                    newBenefit.id = Int(data) ?? 0
                    newBenefit.description = description
                    newBenefit.quantity = Int(quantity) ?? 0
                    benefitsList.append(newBenefit)
                    description = ""
                    quantity = ""
                    //Back()
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
    struct Benefit: Decodable {
        var id: Int?
        var benefit: Int?
        var quantity: Int?
        var startdate: String?
        var expirydate: String?
        var description: String?
    }
    func Back() -> Void{
        currentPage = 2
    }
}
