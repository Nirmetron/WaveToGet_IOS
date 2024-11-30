//
//  InputAlertView.swift
//  ReferralAndRewards
//
//  Created by Ismail Gok on 2022-08-04.
//

import SwiftUI

struct InputAlertView: View {
    
    let screenSize = UIScreen.main.bounds
        var title: String = ""
        @Binding var isShown: Bool
        @Binding var text1: String
        @Binding var text2: String
        var onDone: (String, String) -> Void = { (_ , _ ) in }
        var onCancel: () -> Void = { }
    
    var body: some View {
        VStack(spacing: 20) {
                    Text(title)
                        .font(.headline)
                    Text("Enter your FIRST and LAST NAME you have used to write the review!")
                    TextField("Firstname", text: $text1)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Lastname", text: $text2)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    HStack(spacing: 20) {
                        Button("Done") {
                            self.isShown = false
                            self.onDone(self.text1, self.text2)
                        }
                        Button("Cancel") {
                            self.isShown = false
                            self.onCancel()
                        }
                    }
                }
                .padding()
                .frame(width: screenSize.width * 0.8, height: screenSize.height * 0.3)
                .background(Color(#colorLiteral(red: 0.9268686175, green: 0.9416290522, blue: 0.9456014037, alpha: 1)))
                .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
                .offset(y: isShown ? 0 : screenSize.height)
                .animation(.spring())
                .shadow(color: Color(#colorLiteral(red: 0.8596749902, green: 0.854565084, blue: 0.8636032343, alpha: 1)), radius: 6, x: -9, y: -9)
    }
}

//struct InputAlertView_Previews: PreviewProvider {
//    static var previews: some View {
//        InputAlertView()
//    }
//}
