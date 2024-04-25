//
//  QuestionView.swift
//  Trivia
//
//  Created by Jasper on 21.04.24.
//

import SwiftUI

struct QuestionView: View {
    @EnvironmentObject var triviaManager: TriviaManager
    
    var body: some View {
        VStack(spacing: 40) {
            
            HStack {
                Text("Trivia Game")
                    .accentTitle()
                Spacer()
                Text("\(triviaManager.questionIndex + 1) out of \(triviaManager.numQuestions)")
                    .foregroundStyle(Color("AccentColor"))
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
            }
            
            ProgressBar(progress: triviaManager.progress)
            
                        
            VStack(alignment: .leading, spacing: 20) {
                Text(triviaManager.question)
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .foregroundStyle(.primary)
                
                Spacer()

                ForEach(triviaManager.answerChoices, id: \.id) { answer in
                    AnswerItem(answer: answer)
                        .environmentObject(triviaManager)
                }
            }
            
            if triviaManager.answerSelected {
                Button {
                    triviaManager.goToNextQuestion()
                } label: {
                    PillButton(text: "Next", background: Color("AccentColor"))
                }
                .disabled(!triviaManager.answerSelected)
                .frame(width: 200, height: 50)
            } else {
                Color.clear.frame(width: 200, height: 50)
            }
                        
            Spacer()
 
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .toolbar(.hidden)
        .background(Color(.systemGroupedBackground))
    }
}

#Preview {
    QuestionView()
        .environmentObject(TriviaManager())
}
