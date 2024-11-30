//
//  NewStampsheetViewModel.swift
//  ReferralAndRewards
//
//  Created by Ismail Gok on 2022-05-16.
//

import SwiftUI

class NewStampsheetViewModel: ObservableObject {
    @Published var newStampsheet = NewStampsheet()
    
    init() {
        self.fetchShapes()
    }
    
    func fetchShapes() {
        // TODO: call api here
    }
}
