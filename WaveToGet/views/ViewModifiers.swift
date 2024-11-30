//
//  ViewModifiers.swift
//  ReferralAndRewards
//
//  Created by Ismail Gok on 2022-10-28.
//

import SwiftUI

struct TextInputModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 15))
    }
}

extension Text {
    func textInputFont() -> some View {
        modifier(TextInputModifier())
    }
}

extension View {
    func textInputFont() -> some View {
        modifier(TextInputModifier())
    }
}
