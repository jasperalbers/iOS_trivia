//
//  Extensions.swift
//  Trivia
//
//  Created by Jasper on 21.04.24.
//

import Foundation
import SwiftUI

extension Text {
    func accentTitle(color: Color = Color("AccentColor")) -> some View {
        self.font(.system(size: 40, weight: .heavy, design: .rounded))
            .foregroundStyle(color)
    }
}
