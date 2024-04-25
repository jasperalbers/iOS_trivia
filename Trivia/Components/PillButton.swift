//
//  PrimaryButton.swift
//  Trivia
//
//  Created by Jasper on 21.04.24.
//

import SwiftUI

struct PillButton: View {
    var text: String
    var background: Color = Color("AccentColor")
    var foreground: Color = Color(.white)
    var shadowRadius: CGFloat = 10.0
    
    var body: some View {
        Text(text)
            .foregroundColor(foreground)
            .padding()
            .padding(.horizontal)
            .background(background)
            .cornerRadius(30)
            .shadow(radius: shadowRadius)
            .font(.system(size: 18, design: .rounded))
            }
}

#Preview {
    PillButton(text: "Next")
}
