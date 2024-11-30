//
//  Notes.swift
//  wavetoget
//
//  Created by Jesse Lugassy on 2021-03-09.
//
import Foundation
import SwiftUI

struct Notes: View {
    @State var note:String = ""
    @EnvironmentObject var custAccount:CustomerAccount
    @EnvironmentObject var account:Account
    @EnvironmentObject var storeAcc:StoreAccount
    @EnvironmentObject var sizing:Sizing
    
    @State private var notesList: [NoteObj] = []
    @State private var hide = false
    @State var error:String = ""
    @State var errorBool:Bool = false
    
    @Binding var noteObj: NoteObj?
    
    var body: some View {
        ZStack
        {
//            RoundedRectangle(cornerRadius: 2).stroke(Color.MyGrey, lineWidth: 2)
            VStack
            {
                HStack
                {
                    if(!account.isCust)
                    {
                    Button(action: {account.currentPage = 5}, label: {
                        ZStack
                        {
                            Image("back6")
                                .resizable()
                                .frame(width: 35.0, height: 35.0)
                                .scaledToFit()
                                .frame(alignment: .top)
                                .colorMultiply(.MyBlue)
                        }
                        .frame(alignment: .leading)
                        .padding([.top, .leading,.bottom], 10.0)
                    })
                    }
                    
                    Spacer()
                    
                    Text("NOTES")
                        .font(.system(size: 17))
                        .padding(.top, 5.0)
                        .padding(.bottom, 10.0)
                        .padding(.leading, -35)
                    
                    Spacer()
                    
                } //: HStack
                ScrollView
                {
                    ForEach(0..<notesList.count, id: \.self)
                    { i in
                        Rectangle()
                            .foregroundColor(.MyGrey)
                            .frame(height:1)
                            .padding(.horizontal,20)
                        VStack(spacing:0)
                        {
                            HStack
                            {
                                Image(notesList[i].metanum ?? 1 == 1 ? "eyeno" : "eye")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30.0, height: 30.0)
                                    .colorMultiply(.gray)
                                Text(notesList[i].text ?? "")
                                    .fontWeight(.semibold)
                                    .font(.system(size: 20))
                                    .fixedSize(horizontal: false, vertical: true)
                            }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, alignment: .leading)
                            HStack
                            {
                                Text("Published by: " + notesList[i].creator_displayname!)
                                    .font(.system(size: 17))
                                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, alignment: .leading)
                                    .padding(.trailing)
                                Text(GetDate(notesList[i].metatime ?? ""))
                                    .font(.system(size: 15, weight: .light))
                                
                                Spacer()
                                
                                // Edit Button
                                Button(action: { EditNote(i) }, label: {
                                        ZStack
                                        {
                                            RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                                .stroke(Color.MyBlue, lineWidth: 2)
        //                                        .foregroundColor(.MyBlue)

                                            Text("EDIT")
                                                .fontWeight(.semibold)
                                                .foregroundColor(.MyBlue)
                                                .font(.system(size: 14))
                                        }
                                    })
                                    .frame(height: 35.0)
                                    .frame(maxWidth: 200)
                            }
                        }
                        .padding(.horizontal, 10.0)
                    }
                    Rectangle()
                        .foregroundColor(.MyGrey)
                        .frame(height:1)
                        .padding(.horizontal,20)
                }
                Spacer()
                HStack(spacing:0)
                {
                    Button(action: {hide = !hide}, label: {
                        ZStack
                        {
                            RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                .stroke(Color.MyBlue, lineWidth: 2)
//                                .foregroundColor(.MyBlue)
                            
                            Image(hide ? "eyeno" : "eye")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30.0, height: 30.0)
                                .colorMultiply(.MyBlue)
                        }
                    })
                    .frame(width: 40.0, height: 40.0)
                    TextField("Enter notes...", text: $note)
                        .font(.system(size: 15))
                        .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.leading, 10)
                        .disableAutocorrection(true)
                    Button(action: {AddNote()}, label: {
                        ZStack
                        {
                            RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                .stroke(Color.MyBlue, lineWidth: 2)
//                                .foregroundColor(.MyBlue)
                            
                            Text("ADD")
                                .fontWeight(.semibold)
                                .foregroundColor(.MyBlue)
                                .font(.system(size: 15))
                        }
                    })
                    .padding(.leading, 10.0)
                    .frame(width: 120.0, height: 40.0)
                }
                .padding(.horizontal, 10.0)
            }
            .padding(.bottom, 10.0)
            .alert(isPresented: $errorBool) {

                Alert(
                    title: Text(error)
                )
            }.padding()
            
        }
        .onAppear(perform: GetNotes)
        .onAppear {
            account.infoPage = 23
        }
    }
    func GetDate(_ dateTime:String) -> String{
        var dateString = ""
        if(dateTime != "")
        {
            if(dateTime == "Now")
            {
                return "Now"
            }
            var datesplit = dateTime.components(separatedBy: " ")
            var timesplit = datesplit[1].components(separatedBy: ":")
            
            var hour = Int(timesplit[0]) ?? 0
            var ampm = "am"
            
            if(hour == 0)
            {
                hour = 12
            }
            else if(hour > 11)
            {
                if(hour != 12)
                {
                    hour -= 12
                }
                ampm = "pm"
            }
            
            dateString = datesplit[0] + " at " + String(hour) + ":" + timesplit[1] + " " + ampm
        }
        return dateString
    }
    func AddNote() -> Void{
        let date1 = Date()
        let timeInt = Int(date1.timeIntervalSince1970)
        var metanum = hide ? "1" : "0"
        APIRequest().Post(withParameters: ["action":"add-record","permissiontype":"","text":note,"recordtype":"5","title":"Note","metanum":metanum,"metavar":"","metatime":String(timeInt),"cardholder":String(custAccount.id),"session":account.SessionToken])
        {data in
            print(data)
            DispatchQueue.main.async {
                if(data == "success")
                {
                    print("test")
                    var newnote = NoteObj()
                    newnote.text = note
                    newnote.metatime = "Now"
                    newnote.metanum = Int(metanum)
                    newnote.creator_displayname = account.Username
                    notesList.insert(newnote, at: 0)
                    note = ""
                    error = "Note added!"
                    errorBool = true
                }
                else
                {
                    error = "Failed to add note..."
                    errorBool = true
                }
            }
        }
    }
    func GetNotes() -> Void{
        notesList.removeAll()
        APIRequest().Post(withParameters: ["action":"get-records","record_format":"5","cardholder":String(custAccount.id),"session":account.SessionToken])
        {data in
            print(data)
            DispatchQueue.main.async {
                if(data != "failed" && data != "nosession" && data != "")
                {
                    let jsonData = data.data(using: .utf8)!
                    let test: [NoteObj] = try! JSONDecoder().decode([NoteObj].self, from: jsonData)
                    //print(test)
                    notesList = test
                }
                else
                {
                }
            }
        }
    }
    func EditNote(_ id:Int)
    {
        account.currentPage = 7
        noteObj = notesList[id]
    }
//    struct NoteObj: Decodable {
//        var id: Int?
//        var cardholder: Int?
//        var location: Int?
//        var permission_group: Int?
//        var record_format: Int?
//        var title: String?
//        var text: String?
//        var metanum: Int?
//        var metavar: String?
//        var metatime: String?
//        var created: String?
//        var creator: Int?
//        var updater: Int?
//        var precedent: Int?
//        var isSuperseded: Int?
//        var firstname: String?
//        var lastname: String?
//        var location_displayname: String?
//        var creator_displayname: String?
//    }
}

//struct Notes_Preview: PreviewProvider {
//    static var previews: some View {
//        var acc = Account()
//        var cust = CustomerAccount()
//        Notes().environmentObject(cust).environmentObject(acc)
//    }
//}
