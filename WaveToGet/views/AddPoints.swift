//
//  AddPoints.swift
//  wavetoget
//
//  Created by Jesse Lugassy on 2021-02-17.
//


import SwiftUI
struct AddPoints: View {
    @EnvironmentObject var custAccount:CustomerAccount
    @EnvironmentObject var account:Account
    @EnvironmentObject var storeAccount:StoreAccount
    @EnvironmentObject var sizing:Sizing
    @State var dollars:String = ""
    @State var error:String = ""
    @State var errorBool:Bool = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding public var page:Int
    var body: some View {
        ZStack
        {
            VStack(alignment: .leading)
            {
                Spacer()
                TextField("Amount in dollars to add to points", text: $dollars)
                    .font(.system(size: 15))
                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                    .padding(.horizontal, 20)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom, 5)
                    .disableAutocorrection(true)
                    .keyboardType(.decimalPad)
                HStack
                {
                    Button(action: {Back()}, label: {
                        ZStack
                        {
                            RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                .stroke(Color.MyBlue, lineWidth: 2)
//                                .foregroundColor(.MyBlue)
                            
                            Text("CANCEL")
                                .fontWeight(.semibold)
                                .foregroundColor(.MyBlue)
                                .font(.system(size: 15))
                        }
                    })
                    Button(action: {AddPointsFunc()}, label: {
                        ZStack
                        {
                            RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                .stroke(Color.MyBlue, lineWidth: 2)
//                                .foregroundColor(.MyBlue)
                            
                            Text("ADD POINTS")
                                .fontWeight(.semibold)
                                .foregroundColor(.MyBlue)
                                .font(.system(size: 15))
                        }
                    })
                }
                .padding(.horizontal, 10.0)
                .frame(height: 60.0)
                .alert(isPresented: $errorBool) {

                    Alert(
                        title: Text(error),
                        dismissButton: .default(Text("OK"), action: {
                            Back()
                        })
                    )
                }.padding()
                
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
    func Back() -> Void{
        page = 0
    }
    func AddPointsFunc() -> Void{
        if((Float(dollars) ?? 0) > 0)
        {
            APIRequest().Post(withParameters: ["action":"transact","carduid":account.CardUId,"session":account.SessionToken, "purchase":dollars,"pin":custAccount.pin,"cardholder":String(custAccount.id)])
            {data in
                DispatchQueue.main.async {
                    print("\n-----------test----------\n" + data + "\n-----------test----------")
                    if(data == "success")
                    {
                        //custAccount.dollars += Float(dollars) ?? 0
                        print(Float(dollars))
                        print(((Float(dollars) ?? 0) * storeAccount.point_expand))
                        custAccount.points += Int(((Float(dollars) ?? 0) * storeAccount.point_expand))
                        error = String(Int(((Float(dollars) ?? 0) * storeAccount.point_expand))) + " points added to account!"
                        errorBool = true
                        dollars = ""
                    }
                    else
                    {
                            error = "Failed to add points"
                            errorBool = true
                        //failed to add dollars
                    }
                }
            }
        }
    }
}

//struct AddPoints_Preview: PreviewProvider {
//    static var previews: some View {
//        var account = Account()
//        var custAccount = CustomerAccount()//for preview testing
//        AddPoints().environmentObject(custAccount).environmentObject(account)
//    }
//}
