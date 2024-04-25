//
//  AnswerRow.swift
//  Trivia
//
//  Created by Jasper on 21.04.24.
//

import SwiftUI

struct AnswerItem: View {
    var answer: Answer
    @State private var isSelected = false
    @EnvironmentObject var triviaManager: TriviaManager
    
//    private var answerColor: Color {
//        if isSelected && answer.isCorrect {
//            return .green
//        } 
//    }
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: "circle.fill")
                .font(.caption)
            
            Text(answer.text)
                .bold()
            
            if isSelected {
                Spacer()
                
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .foregroundStyle(.primary)
        .background(isSelected ? (answer.isCorrect ? .green : .red) : (triviaManager.answerSelected ? (answer.isCorrect ? .green : Color(.secondarySystemGroupedBackground)) : Color(.secondarySystemGroupedBackground)))
        .cornerRadius(30)
        .shadow(color: isSelected ? (answer.isCorrect ? .green : .red) : .secondary, radius: 5, x: 0.5, y: 0.5)
        .onTapGesture {
            if !triviaManager.answerSelected {
                isSelected = true
                triviaManager.selectAnswer(answer: answer)
            }
        }
    }
}

#Preview {
    AnswerItem(answer: Answer(text: "single", isCorrect: false))
        .environmentObject(TriviaManager())
}
