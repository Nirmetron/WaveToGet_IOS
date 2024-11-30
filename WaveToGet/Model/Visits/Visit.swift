//
//  Visit.swift
//  ReferralAndRewards
//
//  Created by Ismail Gok on 2022-06-12.
//

import Foundation

struct Visit: Decodable {
    var id: Int?
    var cardholder: Int?
    // var cardholder_displayname: String?
    var creator: Int?
    var creator_displayname: String?
    var details: String?
    var metatime: String?
}
