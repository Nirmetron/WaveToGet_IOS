//
//  StampsheetsViewModel.swift
//  ReferralAndRewards
//
//  Created by Ismail Gok on 2022-05-16.
//

import SwiftUI

class StampsheetsViewModel: ObservableObject {
    @Published var stampsheets = [Stampsheet]()
    
    init() {
        fetchStampsheets()
    }
    
    func fetchStampsheets() {
        // TODO: Call Api here
    }
}
