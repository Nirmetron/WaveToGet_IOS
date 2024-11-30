//
//  CreateAccountBridge.swift
//  wavetoget
//
//  Created by Jesse Lugassy on 2021-10-08.
//

import SwiftUI


struct CreateAccountBridge: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var custAccount:CustomerAccount
    @EnvironmentObject var storeAccount:StoreAccount
    @EnvironmentObject var account:Account
    @EnvironmentObject var sizing:Sizing
    @State var page = 0
    @State var selectedAccount: acc = acc()
    var body: some View {
        ZStack
        {
            switch(page)
            {
            case 0:
                CreateAccountPrompt(page: $page)
            case 1:
//                CreateAccountEmailVerification(page: $page)
                CreateStoreAccount(page: $page)
            case 2:
//                CreateCustomerAccount(page: $page)
                StoreSearchView(page: $page, selectedAccount: $selectedAccount)
            case 3:
                CreateAccountCodeVerification(page: $page)
            case 4:
                CreateStoreAccount(page: $page)
            case 5:
                CreateCustomerAccount(page: $page, selectedAccountFromSearch: selectedAccount)
            default:
                CreateAccountPrompt(page: $page)
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
//        .overlay(//fixed visual bug when putting it in first ZStack
//            RoundedRectangle(cornerRadius: 2)
//                .stroke(Color.MyGrey, lineWidth: 2)
//        )
        .padding(10)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
