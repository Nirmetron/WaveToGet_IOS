//
//  ContentView.swift
//  wavetoget
//
//  Created by Jesse Lugassy on 2021-01-14.
//

import SwiftUI

struct ContentView: View {
    @State var scene = 0;
    var account = Account()
    var custAccount = CustomerAccount()
    var storeAccount = StoreAccount()
    var body: some View {
        VStack{
            Header()
            NavigationView{
                ZStack
                {
//                    Color.MyGrey
//                    .edgesIgnoringSafeArea(.all)
                    Login()
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
        }
    }
}
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
public func testFunc() -> Int{
    return 1
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
