//
//  Stampsheet.swift
//  ReferralAndRewards
//
//  Created by Ismail Gok on 2022-05-16.
//

import Foundation

struct Stampsheet: Identifiable, Decodable {
    let id: String
    let prize: String
    let size: Int
    let shape: String
    let autoStamp: Bool
    let autoReward: Bool
}
