//
//  ProgressRing.swift
//  Trivia
//
//  Created by Jasper on 10.04.24.
//

import SwiftUI

struct ProgressRing: View {
    var resultColor: Color = .primary
    @EnvironmentObject var triviaManager: TriviaManager
    
    var body: some View {
    
        
        var endMessage: String {
            switch (Double(triviaManager.score) / Double(triviaManager.numQuestions)) {
            case 0.0..<0.1:
                return "big oof 💀"
            case 0.1..<0.41:
                return "You may want to adjust the difficulty slider ☺️"
            case 0.41..<0.61:
                return "Solid score! You know your trivia 😊"
            case 0.61..<0.99:
                return "Amazing result! You're a trivia expert 🤓"
            case 0.99..<1.1:
                return "✨ Magical score! You are a certified trivia genius ✨"
            default:
                return ""
            }
        }
        
        VStack(alignment: .center, spacing: 40) {
            ZStack {
                // MARK: placeholder ring
                Circle()
                    .stroke(lineWidth: 20)
                    .foregroundColor(.secondary)
                    .opacity(0.1)
                
                // MARK: colored ring
                Circle()
                    .trim(from: 0.0, to: (Double(triviaManager.score) / Double(triviaManager.numQuestions)))
                    .stroke(
                        resultColor,
                        style: StrokeStyle(lineWidth: 15.0, lineCap: .round, lineJoin: .round))
                    .rotationEffect((Angle(degrees: 270)))
                
                VStack {
                    Text("\(triviaManager.score) / \(triviaManager.numQuestions)")
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                    Text("correct answers")
                }
                .foregroundStyle(resultColor)
                
            }
            .frame(width: 250, height: 250)
            .padding()
            
            Text(endMessage)
                .frame(width: 300)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    ProgressRing()
        .environmentObject(TriviaManager())
}
