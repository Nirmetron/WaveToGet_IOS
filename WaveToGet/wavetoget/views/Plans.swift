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
    @State private var currentPage = 0
    var body: some View {
        ZStack
        {
            RoundedRectangle(cornerRadius: 2).stroke(Color.MyGrey, lineWidth: 2)
            VStack(alignment: .leading)
            {
//                Text("Plans")
//                    .font(.largeTitle)
//                    .frame(maxWidth: .infinity, alignment: .center)
                //PagerView(pageCount: storeAccount.plans.count, currentIndex: $currentPage) {
                    ForEach(0..<storeAccount.plans.count) { i in
                        ZStack
                        {
//                            Color.white
//                                .edgesIgnoringSafeArea(.all)
                            //RoundedRectangle(cornerRadius: 2).stroke(Color.MyGrey, lineWidth: 2)
                            VStack{
                                Text(storeAccount.plans[i].name)
                                    .font(.system(size: 20))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 20.0)
                                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                                Text(storeAccount.plans[i].details)
                                    .font(.system(size: 30))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.bottom, 10.0)
                                    .padding(.leading, 20.0)
                                if(!account.isCust)
                                {
                                    Button(action: {AddPlan(i: i)}, label: {
                                            Text("Assign")
                                                .foregroundColor(.white)
                                                .font(.largeTitle)
                                                .frame(minWidth: 50, maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                                                .background(RoundedRectangle(cornerRadius: 30).foregroundColor(.MyBlue))})
                                        .padding(.horizontal, 20.0)
                                        .padding(.vertical, 10.0)
                                }
                                if(i != storeAccount.plans.count - 1)
                                {
                                    Rectangle()
                                        .frame(height: 2.0)
                                        .foregroundColor(.MyGrey)
                                }
                            }
                        }
                    }
                //}
            }
        }
        .padding(.horizontal,25)
        //.frame(height: 300.0)
    }
    func AddPlan(i:Int) -> Void{
//        if(custAccount.planName != storeAccount.plans[i].name)
//        {
            APIRequest().Post(withParameters: ["action":"add-plan","session":account.SessionToken, "plan":String(storeAccount.plans[i].id),"cardholder": String(custAccount.id)])
            {data in
                DispatchQueue.main.async {
                    print("\n-----------test----------\n" + data + "\n-----------test----------")
                    if(data == "success")
                    {
                        GetPlanDetails()
                        custAccount.benefits.removeAll()
                        UpdateBenefits()
                    }
                    else
                    {
                        //failed to add dollars
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
        Plans().environmentObject(store).environmentObject(cust).environmentObject(account)
    }
}
