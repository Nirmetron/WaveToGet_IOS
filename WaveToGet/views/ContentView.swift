//
//  ContentView.swift
//  wavetoget
//
//  Created by Jesse Lugassy on 2021-01-14.
//
import Foundation
import SwiftUI
import StoreKit

struct ContentView: View {
    //@State var scene = 0;
    var version:Float = 1.2;
    @ObservedObject var monitor = NetworkMonitor()
    @State private var showAlertSheet = false
    @State var settings = false
    @State var CorrectVersion = true
    @State var versionMessage = "Loading..."
    
    var account = Account()
    var custAccount = CustomerAccount()
    var storeAccount = StoreAccount()
    var sizing = Sizing()
    
//    @StateObject var storeManager = StoreManager()
//
//    let productIDs = [
//        "rr_storeowner_1m"
//    ]
    
//    @StateObject var inAppPurchaseViewModel = InAppPurhaseViewModel()
    var inAppPurchaseViewModel: InAppPurhaseViewModel

    init() {
        inAppPurchaseViewModel = InAppPurhaseViewModel(account: account)
    }
    
    var body: some View {
        
        VStack(spacing: 0){
            Header().environmentObject(account)
            ZStack(alignment: .top)
            {

                NavigationView{
                    ZStack
                    {
                        if(CorrectVersion)
                        {
                            Login()
                        }
                        else
                        {
                            Spacer()
                            Text(versionMessage)
                                .font(.title)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 20.0)
                            Spacer()
                        }
                    }
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                }
                .onTapGesture {
                    UIApplication.shared.endEditing()
                }
                .navigationViewStyle(StackNavigationViewStyle())
                .environmentObject(account)
                .environmentObject(custAccount)
                .environmentObject(storeAccount)
                .environmentObject(sizing)
                .environmentObject(inAppPurchaseViewModel)
//                .environmentObject(storeManager)
                            Text(monitor.isConnected ? "" : "No connection")
                                .font(.title2)
                                .fontWeight(.bold)
                                //.padding(.top, 50.0)
                                .foregroundColor(.red)
            
                        }
//            .onAppear() {
//                SKPaymentQueue.default().add(storeManager)
//                storeManager.getProducts(productIDs: productIDs)
//            }
            
            // TODO: Add this version info to Help View when implemented
//            Text("Ver: \(Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "unkown")")
//                .font(.system(size: 10, weight: .thin))
            
        } //: VStack
    }
    func imageWithImage (sourceImage:UIImage, scaledToHeight: CGFloat) -> UIImage {
        let oldHeight = sourceImage.size.height
        let scaleFactor = scaledToHeight / oldHeight

        let newWidth = sourceImage.size.width * scaleFactor
        let newHeight = oldHeight * scaleFactor

        UIGraphicsBeginImageContext(CGSize(width:newWidth, height:newHeight))
        sourceImage.draw(in: CGRect(x:0, y:0, width:newWidth, height:newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
//    func VersionChecker()
//    {
//        APIRequest().Post(withParameters: ["action":"get-version"])
//        {data in
//            print(data + " ---- TestJsonParse() ----")
//            DispatchQueue.main.async {
//                var ver = Float(data) ?? 0
//                if(ver > version + 0.1)
//                {
//                    versionMessage = "Please update the app in the app store..."
//                    if let url = URL(string: "https://apps.apple.com/us/app/wavetoget/id1556479711") {
//                        UIApplication.shared.open(url)
//                    }
//                }
//                else
//                {
//                    CorrectVersion = true
//                }
//            }
//        }
//    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(viewModel: <#ViewModel#>)
//    }
//}
