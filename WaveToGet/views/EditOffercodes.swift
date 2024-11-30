//
//  EditOffercodes.swift
//  wavetoget
//
//  Created by Jesse Lugassy on 2021-04-08.
//

import SwiftUI

struct EditOffercodes: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var custAccount:CustomerAccount
    @EnvironmentObject var storeAccount:StoreAccount
    @EnvironmentObject var account:Account
    @EnvironmentObject var sizing:Sizing
    @Binding var currentPage: Int
    @Binding var selectedPlan: Int
    @State var code = ""
    @State var amount = ""
    @State var type = "points"
    @State var errorText = ""
    @State var end = Date()
    @State var isDeleted = false
    @State private var OffercodeList: [Offercode] = []
    @Binding var offerCode: OfferCode?
    
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
                
                Text(defaultLocalizer.stringForKey(key: "EDIT OFFER CODES"))
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
                TextField(defaultLocalizer.stringForKey(key: "Code"), text: $code)
                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.vertical, 5)
                    .padding(.horizontal, 10.0)
                    .disableAutocorrection(true)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .font(.system(size: 15))
                
                TextField(defaultLocalizer.stringForKey(key: "Amount"), text: $amount)
                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.vertical, 5)
                    .padding(.trailing, 10.0)
                    .disableAutocorrection(true)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .keyboardType(.numberPad)
                    .font(.system(size: 15))
                
                Menu {
                        Button { type = "points"
                        } label: {
                            Text(defaultLocalizer.stringForKey(key: "points"))
                                .font(.system(size: 15))
                        }
                    Button { type = "dollars"
                    } label: {
                        Text(defaultLocalizer.stringForKey(key: "dollars"))
                            .font(.system(size: 15))
                    }
                } label: {
                    Text(type)
                        .font(.system(size: 15))
                }
                .padding(.trailing, 10.0)
            }
            HStack
            {
                Text("\(defaultLocalizer.stringForKey(key: "Good until")):")
                    .font(.system(size: 17))
                
            DatePicker("", selection: $end, in: Date()..., displayedComponents: .date)
                .labelsHidden()
                .font(.system(size: 15))
                
                Button(action: {
                    CreateOffercode()
                }, label: {
                    ZStack
                    {
                        RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                            .stroke(Color.MyBlue, lineWidth: 2)
//                            .foregroundColor(.MyBlue)
                        
                        Text(defaultLocalizer.stringForKey(key: "ADD CODE"))
                            .fontWeight(.semibold)
                            .foregroundColor(.MyBlue)
                            .font(.system(size: 15))
                    }
                })
                .padding(.trailing, 10.0)
                .frame(width: 120.0, height: 40.0)
            }
            .padding(.bottom, 10.0)
            ScrollView
            {
                ForEach(0..<OffercodeList.count, id: \.self) { i in
                    Rectangle()
                        .foregroundColor(.MyGrey)
                        .frame(height:1)
                        .padding(.horizontal,20)
                    VStack
                    {
                    HStack
                    {

                        Text(OffercodeList[i].code ?? "")
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        Text(OffercodeList[i].amount ?? "")
                                .font(.system(size: 16))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        Text(OffercodeList[i].type ?? "")
                                .font(.system(size: 16))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        Button(action: { EditOffercode(i) }, label: {
                                ZStack
                                {
                                    RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                        .stroke(Color.MyBlue, lineWidth: 2)
//                                        .foregroundColor(.MyBlue)

                                    Text(defaultLocalizer.stringForKey(key: "EDIT"))
                                        .fontWeight(.semibold)
                                        .foregroundColor(.MyBlue)
                                        .font(.system(size: 14))
                                }
                            })
                            .frame(height: 35.0)
                        
                        Button(action: {RemoveOffercode(OffercodeList[i].id ?? 0)}, label: {
                                ZStack
                                {
                                    RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                        .stroke(Color.MyBlue, lineWidth: 2)
//                                        .foregroundColor(.MyBlue)

                                    Text(defaultLocalizer.stringForKey(key: "REMOVE"))
                                        .fontWeight(.semibold)
                                        .foregroundColor(.MyBlue)
                                        .font(.system(size: 14))
                                }
                            })
                            .frame(height: 35.0)
                    }
                        Text("\(defaultLocalizer.stringForKey(key: "Good until")) " + (OffercodeList[i].end ?? ""))
                                .font(.system(size: 16))
                                .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal, 20.0)
                }
            }
        }
        .alert(isPresented: $isDeleted) {
                   Alert(
                    title: Text("\(defaultLocalizer.stringForKey(key: "Successfully deleted"))!")
                   )
               }
        .onAppear(perform: {
            account.infoPage = 13
            GetOffercodes()
        })
        .padding(.bottom, 1)
        //.padding([.leading, .bottom, .trailing], 20.0)
    }
    func GetOffercodes()
    {
        APIRequest().Post(withParameters: ["action":"get-offercodes","session":account.SessionToken,"store":String(storeAccount.id)])
        {data in
            print(data + " ---- TestJsonParse() ----")
            DispatchQueue.main.async {
                if(data != "nosession" && data != "")
                {
                    let jsonData = data.data(using: .utf8)!
                    let test: [Offercode] = try! JSONDecoder().decode([Offercode].self, from: jsonData)

                    OffercodeList = test
                }
            }
        }
    }
    func RemoveOffercode(_ id:Int)
    {
        APIRequest().Post(withParameters: ["action":"remove-offercode","session":account.SessionToken,"id":String(id)])
        {data in
            print(data + " ---- TestJsonParse() ----")
            DispatchQueue.main.async {
                if(data != "nosession" && data != "" && data == "1")
                {
                    var i = 0
                    for offercode in OffercodeList {
                        if(offercode.id == id)
                        {
                            isDeleted = true
                            OffercodeList.remove(at: i)
                        }

                        i += 1

                    }
                }
            }
        }
    }
    
    func EditOffercode(_ id:Int)
    {
        currentPage = 8
        var selectedOfferCode = OffercodeList[id]
        offerCode = OfferCode(id: selectedOfferCode.id,
                              store: selectedOfferCode.store,
                              name: selectedOfferCode.name,
                              code: selectedOfferCode.code,
                              amount: selectedOfferCode.amount,
                              type: selectedOfferCode.type,
                              start: selectedOfferCode.start,
                              end: selectedOfferCode.end,
                              uses: selectedOfferCode.uses,
                              used: selectedOfferCode.used,
                              active: selectedOfferCode.active,
                              created: selectedOfferCode.created)
        print("DEBUG: OfferCode = \(offerCode)")
//        selectedPlan = id
    }

    func CreateOffercode()
    {
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
        let enddate = formatter1.string(from: end)
        APIRequest().Post(withParameters: ["action":"add-offercode","session":account.SessionToken,"store":String(storeAccount.id),"code":code,"amount":amount, "type":type, "start":startdate, "end":enddate])
        {data in
            print(data + " ---- TestJsonParse() ----")
            DispatchQueue.main.async {
                if(data != "nosession" && data != "")
                {
                    var newOffercode = Offercode()
                    newOffercode.id = Int(data) ?? 0
                    newOffercode.code = code
                    newOffercode.amount = amount
                    newOffercode.end = enddate
                    newOffercode.start = startdate
                    newOffercode.type = type
                    newOffercode.uses = 0
                    newOffercode.used = 0
                    OffercodeList.append(newOffercode)
                    code = ""
                    amount = ""
                    //Back()
                }
            }
        }
    }
    struct Offercode: Decodable {
        var id: Int?
        var store: Int?
        var name: String?
        var code: String?
        var amount: String?
        var type: String?
        var start: String?
        var end: String?
        var uses: Int?
        var used: Int?
        var active: Int?
        var created: String?
    }
    func Back() -> Void{
        currentPage = 0
    }
}
