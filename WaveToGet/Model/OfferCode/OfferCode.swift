//
//  OfferCode.swift
//  ReferralAndRewards
//
//  Created by Ismail Gok on 2022-06-12.
//

import Foundation

struct OfferCode: Decodable {
    var id: Int?
    var store: Int?
    var name: String?
    var code: String?
    var amount: String?
    var type: String?
    var start: String?
    var end: String?
    var uses: Int?
    var used: Int?
    var active: Int?
    var created: String?
}
