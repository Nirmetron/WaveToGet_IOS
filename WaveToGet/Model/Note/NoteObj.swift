//
//  NoteObj.swift
//  ReferralAndRewards
//
//  Created by Ismail Gok on 2022-06-12.
//

import Foundation

struct NoteObj: Decodable {
    var id: Int?
    var cardholder: Int?
    var location: Int?
    var permission_group: Int?
    var record_format: Int?
    var title: String?
    var text: String?
    var metanum: Int?
    var metavar: String?
    var metatime: String?
    var created: String?
    var creator: Int?
    var updater: Int?
    var precedent: Int?
    var isSuperseded: Int?
    var firstname: String?
    var lastname: String?
    var location_displayname: String?
    var creator_displayname: String?
}
