//
//  Transaction.swift
//  ReferralAndRewards
//
//  Created by Ismail Gok on 2022-06-13.
//

import Foundation

struct Transaction: Decodable {
    var id: Int?
    var cardholder: Int?
    var firstname: String?
    var lastname: String?
    var transactor: Int?
    var transactor_displayname: String?
    var description: String?
    var points: Int?
//    var dateString: String?
    var created: String?
//    var newPoints: Int?
    var new_points: Int?
    var dollars: String?
//    var newDollars: Double?
    var new_dollars: String?
//    var pinUsed: String?
    var is_pinverified: Int?
}
