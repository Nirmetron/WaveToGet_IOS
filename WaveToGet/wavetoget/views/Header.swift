//
//  Header.swift
//  wavetoget
//
//  Created by Jesse Lugassy on 2021-01-15.
//

import SwiftUI

struct Header: View {
    var body: some View {
        ZStack{
            Color.white
                .ignoresSafeArea()
            Image("logo")
                .resizable()
                .padding(.horizontal, 35.0)
                .scaledToFit()
                .frame(alignment: .top)
        }
        .frame(height: 60.0)
    }
}

struct Header_Preview: PreviewProvider {
    static var previews: some View {
        Header()
    }
}
