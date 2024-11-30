//
//  LoginSettings.swift
//  wavetoget
//
//  Created by Jesse Lugassy on 2021-01-18.
//

import SwiftUI

struct LoginSettings: View {
    @State private var apiAddress = "api2.wavetoget.com"
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
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
                Text("Settings")
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 40)
                Spacer()
                Text("Please API address here")
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity, alignment: .center)
                TextField("API", text: $apiAddress)
                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.black, lineWidth: 1))
                    .padding(.horizontal, 20)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.vertical, 5)
                    .disableAutocorrection(true)
                Spacer()
                ZStack
                {
                    Text("")
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 82, maxHeight: 82)
                        .background(RoundedCorners(color: .MyGrey, tl: 0, tr: 0, bl: 28, br: 28))
                    Button(action: {Okay()}, label: {
                        Text("Okay")
                            .foregroundColor(.blue)
                            .font(.largeTitle)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 80, maxHeight: 80)
                            .background(RoundedCorners(color: .white, tl: 0, tr: 0, bl: 28, br: 28))})
                    
                }
            }
        }
        .padding(.horizontal,25)
        .padding(.top,40)
    }
    .navigationBarTitle("")
    .navigationBarHidden(true)
}
    func Okay() -> Void{
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct LoginSettings_Preview: PreviewProvider {
    static var previews: some View {
        LoginSettings()
    }
}
