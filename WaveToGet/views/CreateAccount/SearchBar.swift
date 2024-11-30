//
//  SearchBar.swift
//  ReferralAndRewards
//
//  Created by Ismail Gok on 2022-08-22.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var text: String
    @Binding var isEditing: Bool
    
    var body: some View {
        HStack {
            TextField("Search...", text: $text)
                .font(.system(size: 15))
                .padding(8)
                .padding(.horizontal, 24)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .disableAutocorrection(true)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                    }
                        .font(.system(size: 15))
                )
                .onTapGesture {
                    isEditing = true
                }
            
            if isEditing {
                Button {
                    isEditing = false
                    text = ""
                    UIApplication.shared.endEditing()
                } label: {
                    Text("Cancel")
                        .foregroundColor(.MyBlue)
                        .font(.system(size: 15))
                }
                .padding(.trailing, 8)
                .transition(.move(edge: .trailing))
                .animation(.default)

            }
            
        } //:HStack
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant("Search..."), isEditing: .constant(true))
    }
}
