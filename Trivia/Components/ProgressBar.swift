//
//  ProgressBar.swift
//  Trivia
//
//  Created by Jasper on 21.04.24.
//

import SwiftUI

struct ProgressBar: View {
    var progress:  CGFloat
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .frame(maxWidth: 350, maxHeight: 10)
                .foregroundStyle(.tertiary)
                .cornerRadius(10)
            
            Rectangle()
                .frame(width: progress * 350, height: 10)
                .foregroundStyle(Color("AccentColor"))
                .cornerRadius(10)
        }
    }
}

#Preview {
    ProgressBar(progress: 0.1)
}
