//
//  EditAnOfferView.swift
//  ReferralAndRewards
//
//  Created by Ismail Gok on 2022-06-12.
//

import SwiftUI

struct EditAnOfferView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var custAccount:CustomerAccount
    @EnvironmentObject var storeAccount:StoreAccount
    @EnvironmentObject var account:Account
    @EnvironmentObject var sizing:Sizing
    
    @Binding var currentPage: Int
    @Binding var offerCode: OfferCode?
    
    @State var errorText = ""
    @State var isUpdated = false
    @State var type = "points"
    @State var endDate = Date()
    @State var code = ""
    @State var amount = ""
    
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
                
                Text("EDIT OFFER")
                    .font(.system(size: 17))
                    .padding(.top, 5.0)
                    .padding(.leading, -35)
                
                Spacer()
            } //: HStack
                
               
                
                Text(errorText)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(.red)
                
                VStack(alignment: .leading, spacing: 10)
                {
                    // Code field
                    HStack {
                        Text("Code: ")
                            .font(.system(size: 12, weight: .semibold))
                            .padding()
                        
                        Spacer()
                        
                        TextField(offerCode?.code ?? "Code", text: $code)
                            .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disableAutocorrection(true)
                            .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
//                            .frame(width: 250)
                            .frame(maxWidth: .infinity)
                            .font(.system(size: 15))
                        
                    } //: HStack
                    .padding(.horizontal, 10)
                    
                    // Amount field
                    HStack {
                        Text("Amount: ")
                            .font(.system(size: 12, weight: .semibold))
                            .padding()
                        
                        Spacer()
                                                
                        TextField(offerCode?.amount ?? "Amount", text: $amount)
                            .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disableAutocorrection(true)
                            .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                            .keyboardType(.decimalPad)
//                            .frame(width: 250)
                            .frame(maxWidth: .infinity)
                            .font(.system(size: 15))
                        
                    } //: HStack
                    .padding(.horizontal, 10)
                    
                    // Type selection
                    HStack {
                        Menu {
                                Button { type = "points"
                                } label: {
                                    Text("points")
                                        .font(.system(size: 15))
                                }
                            Button { type = "dollars"
                            } label: {
                                Text("dollars")
                                    .font(.system(size: 15))
                            }
                        } label: {
                            Text(type)
                                .font(.system(size: 15))
                        }
                        .padding(.trailing, 10.0)
                        
                    }
                    .padding(.horizontal, 20)
                    
                    
                    // Good Until Field
                    HStack {
                        Text("Good until:")
                            .font(.system(size: 15))
                        
                        DatePicker("", selection: $endDate, in: Date()..., displayedComponents: .date)
                        .labelsHidden()
                        .font(.system(size: 15))
                    }
                    .padding(.horizontal, 20)
                    
                    // Expiry Time Field
//                    Text("Start time:")
//                    DatePicker("", selection: $end, in: Date()..., displayedComponents: .date)
//                    .labelsHidden()
                    
                    // Update Button
                    HStack {
                        Spacer()
                        
                        Button(action: {updateOffer()}, label: {
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
                    } //: HStack
                    .padding(.top, 30)
                    
                } //: HStack
                .padding(.bottom, 20)
                
            Spacer()
            
        } //: VStack
        .onAppear(perform: {
            account.infoPage = -1
            setInitialValues()
        })
        .alert(isPresented: $isUpdated) {
                   Alert(
                       title: Text("Successfully updated!")
                   )
               }.padding()
        
    }
    
    func Back() -> Void{
        currentPage = 4
    }
    
    private func setInitialValues() {
        code = offerCode?.code ?? ""
        amount = offerCode?.amount ?? ""
    }
    
    func updateOffer() {
        print("DEBUG: updateOffer is called..")
        
        if(code == "")
        {
            errorText = "Please add a code to the offer code..."
            return
        }
        if(amount == "")
        {
            errorText = "Please add an amount to the offer code..."
            return
        }
        let date1 = Date()
        
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter1.timeZone = NSTimeZone(name: "EST") as TimeZone?
        let startdate = formatter1.string(from: date1)
        let enddate = formatter1.string(from: endDate)
        let newCode = code
        let newAmount = amount
        let newType = type
        let params: [String: String] = [
            "action": "edit-offercode",
            "session": account.SessionToken,
            "id": "\(offerCode!.id ?? 0)",
            "store":String(storeAccount.id),
            "code": newCode,
            "amount": newAmount,
            "type": newType,
            "start":startdate,
            "end":enddate
        ]
        print("DEBUG: params = \(params)")
        APIRequest().Post(withParameters: params)
        {data in
            DispatchQueue.main.async {
                if(data != "failed" || data != "nosession")
                {
                   isUpdated = true
                    errorText = ""
                }
                else {
                    errorText = "Something went wrong!"
                }
            }
        }
    }
}

//struct EditAnOfferView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditAnOfferView(currentPage: .constant(8), offerCode: .constant(nil))
//    }
//}


