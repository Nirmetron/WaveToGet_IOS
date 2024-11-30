//
//  Sizing.swift
//  wavetoget
//
//  Created by Jesse Lugassy on 2021-04-13.
//

import SwiftUI
//@EnvironmentObject var account:Account
class Sizing:ObservableObject  {
    @Published var mainFrameWidth:CGFloat = UIScreen.main.bounds.width * 0.9
    
    @Published var buttonWidth:CGFloat = UIScreen.main.bounds.width * 0.3
    @Published var buttonHeight:CGFloat = UIScreen.main.bounds.height * 0.15
    
    @Published var smallButtonWidth:CGFloat = UIScreen.main.bounds.width * 0.2
    @Published var wideButtonWidth:CGFloat = 200
    @Published var smallButtonHeight:CGFloat = UIScreen.main.bounds.height * 0.075
    
    @Published var starSize:CGFloat = UIScreen.main.bounds.width * 0.06
    
    @Published var ipadStarSize:CGFloat = UIScreen.main.bounds.height * 0.03
    
    @Published var QRSize:CGFloat = UIScreen.main.bounds.height * 0.4
    
    @Published var smallTextSize:CGFloat = UIScreen.main.bounds.width * 0.03
    @Published var mediumTextSize:CGFloat = UIScreen.main.bounds.width * 0.04
    @Published var largeTextSize:CGFloat = UIScreen.main.bounds.width * 0.045
    
    @Published var verticalFormSpacing:CGFloat = UIScreen.main.bounds.height * 0.015
    @Published var horizontalInputForForm:CGFloat = UIScreen.main.bounds.width * 0.3
    @Published var ipadHorizontalInputForForm:CGFloat = UIScreen.main.bounds.width * 0.15
    
    @Published var largeCornerRadius:CGFloat = 10
    @Published var mediumCornerRadius:CGFloat = 5
    @Published var smallCornerRadius:CGFloat = 2
}
