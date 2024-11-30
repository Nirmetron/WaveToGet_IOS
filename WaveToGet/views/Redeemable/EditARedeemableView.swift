//
//  EditRedeemableView.swift
//  ReferralAndRewards
//
//  Created by Ismail Gok on 2022-06-13.
//

import SwiftUI

struct EditARedeemableView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var custAccount:CustomerAccount
    @EnvironmentObject var storeAccount:StoreAccount
    @EnvironmentObject var account:Account
    @EnvironmentObject var sizing:Sizing
    
    @Binding var currentPage: Int
    @Binding var selectedPlan: Int
//    @Binding var offerCode: OfferCode?
    
    @State var errorText = ""
    @State var redeemableName = ""
    @State var redeemablePoint = ""
    @State var isUpdated = false
    
    var body: some View {
        VStack {
            
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
                    .padding([.top, .trailing], 10.0)
                })
                
                Spacer()
                
                Text("EDIT A REDEEMABLE")
                    .font(.system(size: 17))
                    .padding(.top, 5.0)
                    .padding(.leading, -35)
                
                Spacer()
                
            } //: HStack
            
            Text(errorText)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundColor(.red)
            
            VStack(alignment: .center, spacing: 20)
            {
                // Code field
                
                HStack {
                    Text("Name: ")
                        .font(.system(size: 14, weight: .semibold))
                        .padding()
                                    
                    TextField("Name", text: $redeemableName)
                        .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                        .frame(width: 250)
                        .font(.system(size: 15))
                    
                } //: HStack
//                .padding()
               
                HStack {
                    Text("Points: ")
                        .font(.system(size: 14, weight: .semibold))
                        .padding()
                                    
                    TextField("Points", text: $redeemablePoint)
                        .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                        .frame(width: 250)
                        .font(.system(size: 15))
                    
                } //: HStack
//                .padding()
                
                // Update Button
                Button(action: {
                    updateRedeemable()
                }, label: {
                    ZStack
                    {
                        RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                            .stroke(Color.MyBlue, lineWidth: 2)
                        //                            .foregroundColor(.MyBlue)
                        
                        Text("UPDATE")
                            .fontWeight(.semibold)
                            .foregroundColor(.MyBlue)
                            .font(.system(size: 15))
                    }
                })
                .padding(.trailing, 10.0)
                .frame(width: 100.0, height: 50.0)
                
                Spacer()
                
            } //: VStack
        } //: VStack
        .onAppear(perform: {
            account.infoPage = -1
            getInitialValues()
        })
        .alert(isPresented: $isUpdated) {
                   Alert(
                       title: Text("Successfully updated!")
                   )
               }.padding()
        
        
    } //: body
    
    func Back() {
        currentPage = 1  // EditRedeemable does not fetch the data onAppear
//        currentPage = 0
    }
    
    func getInitialValues() {
        redeemableName = storeAccount.redeemables[selectedPlan].name
        redeemablePoint = "\(storeAccount.redeemables[selectedPlan].points)"
    }
    
    func updateRedeemable() {
        print("DEBUG: updateRedeemable is called..")
        
        if(redeemableName == "")
        {
            errorText = "Please add a name to the redeemable..."
            return
        }
        if(redeemablePoint == "")
        {
            errorText = "Please add points to the redeemable..."
            return
        }
        let newName = redeemableName
        let newPoints = redeemablePoint
        
        let params: [String: String] = [
            "action": "edit-store-redeemable",
            "session": account.SessionToken,
            "id": "\(storeAccount.redeemables[selectedPlan].id)",
            "store":String(storeAccount.id),
            "name": newName,
            "points": newPoints
        ]
        print("DEBUG: params = \(params)")
        APIRequest().Post(withParameters: params)
        {data in
            DispatchQueue.main.async {
                errorText = ""
                if(data != "failed" && data != "nosession")
                {
                   isUpdated = true
//                    Back()
                }
            }
        }
    }
}

//struct EditARedeemableView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditRedeemableView()
//    }
//}
