//
//  Account.swift
//  wavetoget
//
//  Created by Jesse Lugassy on 2021-01-15.
//
import Combine

final class Account:ObservableObject {
    @Published var id:Int = 0
    @Published var Username: String = ""
    @Published var Email: String = ""
    @Published var AccountType: String = ""
    @Published var SessionToken:String = ""
    @Published var CardUId:String = ""
    @Published var isCust: Bool = true
}

//struct Account: Decodable {
//    var id: String = ""
//    var displayname: String = ""
//    var type: String = ""
//    var lastactive: String
//}
