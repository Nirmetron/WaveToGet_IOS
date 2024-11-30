//
//  CheckboxFieldView.swift
//  wavetoget
//
//  Created by Jesse Lugassy on 2021-01-18.
//
import SwiftUI
struct CheckboxFieldView : View {

    @Binding var checkState:Bool

    var body: some View {

         Button(action:
            {
                //1. Save state
                self.checkState = !self.checkState
                print("State : \(self.checkState)")


        }) {
                        //2. Will update according to state
                ZStack{
                    Rectangle()
                             .fill(Color.MyBlue)
                             .frame(width:24, height:24)
                             .cornerRadius(5)
                   Rectangle()
                            .fill(self.checkState ? Color.MyBlue : Color.white)
                            .frame(width:20, height:20)
                            .cornerRadius(5)
                }

         }

    }

}

//struct CheckboxField_Preview: PreviewProvider {
//    static var previews: some View {
//        CheckboxFieldView()
//    }
//}
