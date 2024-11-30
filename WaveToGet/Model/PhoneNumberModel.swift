//
//  PhoneNumberModel.swift
//  ReferralAndRewards
//
//  Created by Ismail Gok on 2022-06-27.
//

import SwiftUI

class PhoneNumberModel: ObservableObject {
    @Published var text = "" {
        didSet {
            if text.count > characterLimit && oldValue.count <= characterLimit {
                text = oldValue
            }
        }
    }
    let characterLimit: Int

    init(limit: Int = 5){
        characterLimit = limit
    }
}
