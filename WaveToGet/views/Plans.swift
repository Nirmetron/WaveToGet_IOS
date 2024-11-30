//
//  Plans.swift
//  wavetoget
//
//  Created by Jesse Lugassy on 2021-02-02.
//

import SwiftUI

struct Plans: View {
    @EnvironmentObject var custAccount:CustomerAccount
    @EnvironmentObject var account:Account
    @EnvironmentObject var storeAccount:StoreAccount
    @EnvironmentObject var sizing:Sizing
    @Binding var currentPage:Int
    @State private var alertMessage = ""
    @State private var isShowingAlert = false
    var body: some View {
        ZStack
        {
//            RoundedRectangle(cornerRadius: 2).stroke(Color.MyGrey, lineWidth: 2)
            VStack
            {
                HStack
                {
                    Button(action: {currentPage = 5}, label: {
                        ZStack
                        {
                            Image("back6")
                                .resizable()
                                .frame(width: 35.0, height: 35.0)
                                .scaledToFit()
                                .frame(alignment: .top)
                                .colorMultiply(.MyBlue)
                        }
                        .frame(alignment: .leading)
                        .padding([.top, .leading,.bottom], 10.0)
                    })
                    
                    Spacer()
                    
                Text("AVAILABLE PLANS")
                    .font(.system(size: 17))
                    .padding(.top, 5.0)
                    .padding(.leading, -35)
                    
                    Spacer()
                    
                } //: HStack
                ScrollView
                {
                    VStack(alignment: .leading)
                    {
                        ForEach(0..<storeAccount.plans.count) { i in
                            Rectangle()
                                .foregroundColor(.MyGrey)
                                .frame(height:1)
                                .padding(.horizontal,20)
                            HStack
                            {
                                VStack{
                                    Text(storeAccount.plans[i].name)
                                        .font(.system(size: 17))
                                        .fontWeight(.semibold)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Text("Duration: " + SetDuration(a: String(storeAccount.plans[i].term_months)))
                                        .font(.system(size: 16))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.bottom, 10.0)
                                }
                                .padding(.leading, 20.0)
                                .frame(maxWidth:.infinity, alignment: .leading)
                                if(!account.isCust)
                                {
                                    Button(action: {AddPlan(i: i)}, label: {
                                        ZStack
                                        {
                                            RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                                .stroke(Color.MyBlue, lineWidth: 2)
//                                                .foregroundColor(.MyBlue)
                                            
                                            Text("Enroll")
                                                .fontWeight(.semibold)
                                                .foregroundColor(.MyBlue)
                                                .font(.system(size: 17))
                                        }
                                    })
                                    .padding(.horizontal, 10.0)
                                    .frame(width: sizing.buttonWidth , height: 44.0)
                                    .alert(isPresented: $isShowingAlert) {
                                        Alert(
                                            title: Text(alertMessage)
                                        )
                                    }
                                    .padding()
                                }
                            }
                        }
                    }
                }
            }
            .onAppear {
                account.infoPage = 24
            }
        }
        //.frame(height: 300.0)
    }
    func SetDuration(a:String) -> String{
        var temp = a
        if(a == "0")
        {
            temp = "Unlimited"
        }
        return temp
    }
    func AddPlan(i:Int) -> Void{
        //        if(custAccount.planName != storeAccount.plans[i].name)
        //        {
        APIRequest().Post(withParameters: ["action":"add-plan","session":account.SessionToken, "plan":String(storeAccount.plans[i].id),"cardholder": String(custAccount.id),"store": String(storeAccount.id)])
        {data in
            DispatchQueue.main.async {
                print("\n-----------test----------\n" + data + "\n-----------test----------")
                if(data == "success")
                {
                    GetPlanDetails()
                    custAccount.benefits.removeAll()
                    UpdateBenefits()
                    alertMessage = "Succesfully enrolled to the \(storeAccount.plans[i].name)."
                    isShowingAlert = true
                }
                else
                {
                    //failed to add dollars
                    alertMessage = "Enrolling to the \(storeAccount.plans[i].name) is failed!"
                    isShowingAlert = true
                }
            }
        }
        //}
    }
    func UpdateBenefits() -> Void{
        APIRequest().Post(withParameters: ["action":"get-cardholder-benefits","session":account.SessionToken,"cardholder": String(custAccount.id)])
        {data in
            DispatchQueue.main.async {
                print("\n-----------test----------\n" + data + "\n-----------test----------")
                if(data != "" && data != "nosession" && data != "failed")
                {
                    print(data)
                    let jsonData = data.data(using: .utf8)!
                    let test: [Benefits] = try! JSONDecoder().decode([Benefits].self, from: jsonData)
                    assignBenefit(withParameters: test)
                }
                else
                {
                    
                    //failed to add dollars
                }
            }
        }
    }
    func GetPlanDetails(){
        
        APIRequest().Post(withParameters: ["action":"get-cardholder-plan","session":account.SessionToken, "cardholder":String(custAccount.id)])
        {data in
            DispatchQueue.main.async {
                if(data != "nosession" && data != "")
                {
                    print(data)
                    let jsonData = data.data(using: .utf8)!
                    let test: PlanDetails = try! JSONDecoder().decode(PlanDetails.self, from: jsonData)
                    assignPlanDetails(withParameters: test)
                }
                else
                {
                }
            }
        }
    }
    func assignPlanDetails(withParameters sa: PlanDetails)
    {
        custAccount.planDetails = sa.details ?? ""
        custAccount.planName = sa.name ?? ""
        custAccount.planExpiry = sa.expirydate ?? ""
    }
    struct PlanDetails: Decodable {
        var name: String?
        var details: String?
        var startdate: String?
        var expirydate: String?
        var plan: Int?
        var id: Int?
    }
    struct Benefits: Decodable {
        var id: Int?
        var benefit: Int?
        var quantity: Int?
        var startdate: String?
        var expirydate: String?
        var description: String?
    }
    func assignBenefit(withParameters sb: [Benefits])
    {
        for Benefits in sb {
            custAccount.benefits.append(AssignBenefit(withParameters: Benefits.id!, benefit: Benefits.benefit!, quantity: Benefits.quantity!, startdate: Benefits.startdate!, expirydate: Benefits.expirydate ?? "", description: Benefits.description!))
        }
    }
}
struct Plans_Preview: PreviewProvider {
    static var previews: some View {
        var account = Account()
        var store = StoreAccount()//for preview testing
        var cust = CustomerAccount()
        Plans(currentPage:.constant(0)).environmentObject(store).environmentObject(cust).environmentObject(account)
    }
}
