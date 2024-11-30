//
//  NewNotification.swift
//  ReferralAndRewards
//
//  Created by Ismail Gok on 2022-05-16.
//

import Foundation

struct NewNotification: Decodable {
    let id: Int?
    var name: String?
    var description: String?
    var variable: String?
    var delay_num: Int = 0
//    var delay_dir: String = "After"
    var delay_dir: Int? = 0
    var delay_scale: String = "Days"
    var sendEmail = 0
    var isHTML = 0
    var subject: String?
    var email: String?
    var sendSMS = 0
    var sms: String?
    var notification: Int?
}

//enum DeliveryTimePeriod: String {
//    case Days = "Days"
//    case Months = "Months"
//}
//
//enum DeliveryTimeOrder: String {
//    case Before = "Before"
//    case After = "After"
//}
