//
//  QrReader.swift
//  wavetoget
//
//  Created by Jesse Lugassy on 2021-01-19.
//

import SwiftUI

struct QrReader: View {
    @State private var cardId = ""
    var body: some View {
        ZStack{
            Color.MyGrey
                .edgesIgnoringSafeArea(.all)
            ZStack
            {
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Corner Radius@*/28.0/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color.white)
                VStack(alignment: .leading)
                {
                    Text("Scan Card")
                        .font(.largeTitle)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 40)
                    Spacer()
                    TextField("Card ID...", text: $cardId)
                        .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.black, lineWidth: 1))
                        .padding(.horizontal, 20)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.vertical, 5)
                        .disableAutocorrection(true)
                        .keyboardType(.numberPad)
                    Spacer()
                    ZStack
                    {
                        Text("")
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 82, maxHeight: 82)
                            .background(RoundedCorners(color: .MyGrey, tl: 0, tr: 0, bl: 28, br: 28))
                        Button(action: {}, label: {
                            Text("Scan QR Code")
                                .foregroundColor(.blue)
                                .font(.largeTitle)
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 80, maxHeight: 80)
                                .background(RoundedCorners(color: .white, tl: 0, tr: 0, bl: 28, br: 28))})
                        
                    }
                }
            }
            .padding(.horizontal,25)
            .padding(.vertical,250)
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct QrReader_Preview: PreviewProvider {
    static var previews: some View {
        QrReader()
    }
}
