//
//  EditStoreItems.swift
//  wavetoget
//
//  Created by Jesse Lugassy on 2021-05-11.
//

import SwiftUI

struct EditStoreItems: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var custAccount:CustomerAccount
    @EnvironmentObject var storeAccount:StoreAccount
    @EnvironmentObject var account:Account
    @EnvironmentObject var sizing:Sizing
    @Binding var currentPage:Int
    @State var code = ""
    @State var amount = ""
    @State var quantity = ""
    @State var type = "points"
    
    @State var editcode = ""
    @State var editamount = ""
    @State var editquantity = ""
    @State var edittype = "points"
    
    @State var errorText = ""
    @State private var ItemList: [Item] = []
    @State var currentEdit: Int = 0
    @State var isSaved = false
    @State var isDeleted = false
    let filter = CIFilter.qrCodeGenerator()
    let context = CIContext()
    
    @State var showingShareMenu = false
    @State var shareSheetItems: [Any] = []
    
    let defaultLocalizer = AMPLocalizeUtils.defaultLocalizer
    
    class ImageSaver: NSObject {
        func writeToPhotoAlbum(image: UIImage) {
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
        }

        @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
            print("DEBUG: Saving error: \(error?.localizedDescription)")
        }
    }
    
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
                
                Text(defaultLocalizer.stringForKey(key: "EDIT STORE PRODUCTS"))
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
                TextField(defaultLocalizer.stringForKey(key: "Name"), text: $code)
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
                
                TextField(defaultLocalizer.stringForKey(key: "Quantity"), text: $quantity)
                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.vertical, 5)
                    .padding(.trailing, 10.0)
                    .disableAutocorrection(true)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .keyboardType(.numberPad)
                    .font(.system(size: 15))
            }
            HStack
            {
                Button(action: {CreateItem()}, label: {
                    ZStack
                    {
                        RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                            .stroke(Color.MyBlue, lineWidth: 2)
//                            .foregroundColor(.MyBlue)
                        
                        Text(defaultLocalizer.stringForKey(key: "ADD PRODUCT"))
                            .fontWeight(.semibold)
                            .foregroundColor(.MyBlue)
                            .font(.system(size: 15))
                    }
                })
                .padding(.horizontal, 10.0)
                .frame(height: 50.0)
            }
            .padding(.bottom, 10.0)
            ScrollView
            {
                ForEach(0..<ItemList.count, id: \.self) { i in
                    Rectangle()
                        .foregroundColor(.MyGrey)
                        .frame(height:1)
                        .padding(.horizontal,20)
                    VStack
                    {
                        HStack
                        {
                            if(!ItemList[i].edit)
                            {
                                Text(ItemList[i].code ?? "")
                                    .font(.system(size: 16))
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text(ItemList[i].amount ?? "")
                                    .font(.system(size: 16))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text(ItemList[i].type ?? "")
                                    .font(.system(size: 16))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text(String(ItemList[i].quantity ?? 0))
                                    .font(.system(size: 16))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            else
                            {
                                Text(ItemList[i].code ?? "")
                                    .font(.system(size: 16))
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                TextField(defaultLocalizer.stringForKey(key: "Amount"), text: $editamount)
                                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding(.vertical, 5)
                                    .padding(.trailing, 10.0)
                                    .disableAutocorrection(true)
                                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                    .keyboardType(.numberPad)
                                    .font(.system(size: 15))
                                
                                Menu {
                                    Button { edittype = "points"
                                    } label: {
                                        Text(defaultLocalizer.stringForKey(key: "points"))
                                            .font(.system(size: 15))
                                    }
                                    Button { edittype = "dollars"
                                    } label: {
                                        Text(defaultLocalizer.stringForKey(key: "dollars"))
                                            .font(.system(size: 15))
                                    }
                                } label: {
                                    Text(edittype)
                                        .font(.system(size: 15))
                                }
                                .padding(.trailing, 10.0)
                                
                                TextField(defaultLocalizer.stringForKey(key: "Quantity"), text: $editquantity)
                                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding(.vertical, 5)
                                    .padding(.trailing, 10.0)
                                    .disableAutocorrection(true)
                                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                    .keyboardType(.numberPad)
                                    .font(.system(size: 15))
                            }
                        }
                        HStack
                        {
                            if(!ItemList[i].edit)
                            {
                            Button(action: {
//                                    var qrString = (ItemList[i].code ?? "") + "`"
//                                    qrString += (ItemList[i].amount ?? "") + "`" + (ItemList[i].type ?? "")
                                    let qr = GenerateQRCodeImage(String(ItemList[i].id ?? 0))
                                    let imageSaver = ImageSaver()
                                    imageSaver.writeToPhotoAlbum(image:qr)}, label: {
                                ZStack
                                {
                                    RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                        .foregroundColor(.MyBlue)
                                    Text(defaultLocalizer.stringForKey(key: "Save image"))
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                        .font(.system(size: 15))
                                }
                            })
                            .frame(height: 35.0)
                            Button(action: {
//                                var qrString = (ItemList[i].code ?? "") + "`"
//                                qrString += (ItemList[i].amount ?? "") + "`" + (ItemList[i].type ?? "")
                                let qr = GenerateQRCodeImage(String(ItemList[i].id ?? 0))
                                shareSheetItems = [qr]
                                showingShareMenu = true
                            }, label: {
                                ZStack
                                {
                                    RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                        .foregroundColor(.MyBlue)

                                    Text(defaultLocalizer.stringForKey(key: "Share"))
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                        .font(.system(size: 15))
                                }
                            })
                            .frame(height: 35.0)
                            .sheet(isPresented: $showingShareMenu, content: {ActivityViewController(activityItems: self.$shareSheetItems)})
                                Button(action: {
                                        var j = 0
                                        for item in ItemList {
                                            if(item.id == currentEdit)
                                            {
                                                ItemList[j].edit = false
                                            }
                                            
                                            j += 1
                                            
                                        }
                                        currentEdit = ItemList[i].id ?? 0
                                        edittype = ItemList[i].type ?? ""
                                        editamount = ItemList[i].amount ?? ""
                                        editquantity = String(ItemList[i].quantity ?? 0)
                                        ItemList[i].edit = true}, label: {
                                    ZStack
                                    {
                                        RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                            .foregroundColor(.MyYellow)
                                        
                                        Text(defaultLocalizer.stringForKey(key: "EDIT"))
                                            .fontWeight(.semibold)
                                            .foregroundColor(.white)
                                            .font(.system(size: 14))
                                    }
                                })
                                .frame(height: 35.0)
                            Button(action: {RemoveItem(ItemList[i].id ?? 0)}, label: {
                                ZStack
                                {
                                    RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                        .foregroundColor(.MyRed)
                                    
                                    Text(defaultLocalizer.stringForKey(key: "REMOVE"))
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                        .font(.system(size: 14))
                                }
                            })
                            .frame(height: 35.0)
                            }
                            else
                            {
                                Button(action: {
                                        ItemList[i].edit = false}, label: {
                                    ZStack
                                    {
                                        RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                            .foregroundColor(.MyRed)
                                        
                                        Text(defaultLocalizer.stringForKey(key: "CANCEL"))
                                            .fontWeight(.semibold)
                                            .foregroundColor(.white)
                                            .font(.system(size: 14))
                                    }
                                })
                                .frame(height: 35.0)
                                Button(action: {
                                        if(editamount == ItemList[i].amount && edittype == ItemList[i].type &&  Int(editquantity) == ItemList[i].quantity)
                                        {
                                            ItemList[i].edit = false
                                            return
                                        }
                                        EditItem(ItemList[i].id ?? 0, ItemList[i].code ?? "", editamount, edittype, editquantity)}, label: {
                                    ZStack
                                    {
                                        RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                            .foregroundColor(.MyGreen)
                                        
                                        Text(defaultLocalizer.stringForKey(key: "CONFIRM"))
                                            .fontWeight(.semibold)
                                            .foregroundColor(.white)
                                            .font(.system(size: 14))
                                    }
                                })
                                .frame(height: 35.0)
                            }
                        }
                    }
                    .padding(.horizontal, 20.0)
                }
            }
        }
        .alert(isPresented: $isDeleted) {
                   Alert(
                    title: Text("\(defaultLocalizer.stringForKey(key: "Successfully deleted"))!")
                   )
               }.padding()
        .onAppear(perform: {
            account.infoPage = 15
            GetStoreItems()
        })
        .padding(.bottom, 1)
        //.padding([.leading, .bottom, .trailing], 20.0)
    }
    func GetStoreItems()
    {
        APIRequest().Post(withParameters: ["action":"get-storeitems","session":account.SessionToken,"store":String(storeAccount.id)])
        {data in
            print(data + " ---- TestJsonParse() ----")
            DispatchQueue.main.async {
                if(data != "nosession" && data != "")
                {
                    let jsonData = data.data(using: .utf8)!
                    let test: [ItemDecodable] = try! JSONDecoder().decode([ItemDecodable].self, from: jsonData)
                    
                    for item_ in test {
                        var newItem = Item()
                        newItem.id = item_.id
                        newItem.code = item_.code
                        newItem.amount = item_.amount
                        newItem.quantity = Int(item_.quantity ?? 0)
                        newItem.type = item_.type
                        ItemList.append(newItem)
                    }
                    //ItemList = test
                }
            }
        }
    }
    func RemoveItem(_ id:Int)
    {
        APIRequest().Post(withParameters: ["action":"remove-storeitem","session":account.SessionToken,"id":String(id)])
        {data in
            print(data + " ---- TestJsonParse() ----")
            DispatchQueue.main.async {
                if(data != "nosession" && data != "" && data == "1")
                {
                    var i = 0
                    for item in ItemList {
                        if(item.id == id)
                        {
                            isDeleted = true
                            errorText = ""
                            ItemList.remove(at: i)
                        }
                        
                        i += 1
                        
                    }
                }
                else {
                    errorText = "\(defaultLocalizer.stringForKey(key: "Something went wrong"))!"
                }
            }
        }
    }
    func EditItem(_ id:Int,_ name_:String, _ amount_:String, _ type_:String, _ quantity_:String)
    {
        APIRequest().Post(withParameters: ["action":"edit-storeitem","session":account.SessionToken,"id":String(id), "amount":amount_, "type":type_,"quantity":quantity_, "code": name_])
        {data in
            print(data + " ---- TestJsonParse() ----")
            DispatchQueue.main.async {
                if(data != "nosession" && data != "" && data == "1")
                {
                    var i = 0
                    for item in ItemList {
                        if(item.id == id)
                        {
                            //ItemList.remove(at: i)
                            ItemList[i].edit = false
                            if(amount_ != "")
                            {
                                ItemList[i].amount = amount_
                            }
                            if(type_ != "")
                            {
                                ItemList[i].type = type_
                            }
                            if(quantity_ != "")
                            {
                                ItemList[i].quantity = Int(quantity_)
                            }
                            
                        }
                        
                        i += 1
                        
                    }
                    editcode = ""
                    editamount = ""
                    editquantity = ""
                    edittype = "points"
                }
            }
        }
    }
    
    func CreateItem()
    {
        if(code == "")
        {
            errorText = "Please add a name to the product..."
            return
        }
        if(amount == "")
        {
            errorText = "Please add an amount to the product..."
            return
        }
        if(quantity == "")
        {
            errorText = "Please add a quantity to the product..."
            return
        }
        APIRequest().Post(withParameters: ["action":"add-storeitem","session":account.SessionToken,"store":String(storeAccount.id),"code":code,"amount":amount, "type":type,"quantity":quantity])
        {data in
            print(data + " ---- TestJsonParse() ----")
            DispatchQueue.main.async {
                if(data != "nosession" && data != "")
                {
                    var newItem = Item()
                    newItem.id = Int(data) ?? 0
                    newItem.code = code
                    newItem.amount = amount
                    newItem.quantity = Int(quantity)
                    newItem.type = type
                    ItemList.append(newItem)
                    code = ""
                    amount = ""
                    quantity = ""
                    //Back()
                }
            }
        }
    }
    struct ItemDecodable: Decodable {
        var id: Int?
        var store: Int?
        var code: String?
        var amount: String?
        var type: String?
        var quantity: Int?
        var active: Int?
        var created: String?
    }
    struct Item: Decodable {
        var id: Int?
        var store: Int?
        var code: String?
        var amount: String?
        var type: String?
        var quantity: Int?
        var active: Int?
        var created: String?
        var edit: Bool = false
    }
    func Back() -> Void{
        currentPage = 0
    }
    func GenerateQRCodeImage(_ url:String) -> UIImage
    {
        let data = Data(url.utf8)
        filter.setValue(data, forKey: "inputMessage")
        let transform = CGAffineTransform(scaleX: 100, y: 100)
        if let qrCodeImage = filter.outputImage?.transformed(by: transform)
        {
            if let qrCodeCGImage = context.createCGImage(qrCodeImage, from: qrCodeImage.extent)
            {
                return UIImage(cgImage: qrCodeCGImage)
            }
        }
        return UIImage(systemName: "xmark") ?? UIImage()
    }
}
