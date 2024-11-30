//
//  EditNoteView.swift
//  ReferralAndRewards
//
//  Created by Ismail Gok on 2022-06-12.
//

import SwiftUI

struct EditNoteView: View {
    
    @EnvironmentObject var custAccount:CustomerAccount
    @EnvironmentObject var account:Account
    @EnvironmentObject var storeAcc:StoreAccount
    @EnvironmentObject var sizing:Sizing
    
    @Binding var noteObj: NoteObj?
    
    @State var note: String = ""
    @State var errorText = ""
    
    var body: some View {
        VStack {
            
            HStack {
                
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
                    .padding([.top, .trailing], 10.0)
                })
                
                Spacer()
                
                Text("EDIT NOTE")
                    .font(.system(size: 17))
                    .padding(.top, 5.0)
                
                Spacer()
                
            } //: HStack
            
            Text(errorText)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundColor(.red)
            
            VStack(alignment: .center, spacing: 20)
            {
                // Code field
                
                Text("Enter Note:")
                    .font(.system(size: 14, weight: .semibold))
                    .padding()
                                
                TextField(noteObj?.text ?? "Note", text: $note)
                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .frame(width: 250)
                    .font(.system(size: 15))
                
                
                // Update Button
                Button(action: {updateNote()}, label: {
                    ZStack
                    {
                        RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                            .stroke(Color.MyBlue, lineWidth: 2)
                        //                            .foregroundColor(.MyBlue)
                        
                        Text("UPDATE")
                            .fontWeight(.semibold)
                            .foregroundColor(.MyBlue)
                            .font(.system(size: 15))
                    }
                })
                .padding(.trailing, 10.0)
                .frame(width: 100.0, height: 50.0)
                
                
                
                Spacer()
                
            } //: VStack
        }

    }//: body
    
    func Back() {
        account.currentPage = 6
    }
    
    func updateNote() {
        print("DEBUG: updateNote is called..")
    }
    
}

struct EditNoteView_Previews: PreviewProvider {
    static var previews: some View {
        EditNoteView(noteObj: .constant(nil))
    }
}
