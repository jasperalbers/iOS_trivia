//
//  TriviaView.swift
//  Trivia
//
//  Created by Jasper on 21.04.24.
//

import SwiftUI

struct TriviaView: View {
    @Binding var difficulty: String
    @Binding var category: String
    @Binding var amount: Int
    @EnvironmentObject var triviaManager: TriviaManager
    @Environment(\.presentationMode) var presentationMode
    
    var resultColor: Color {
        switch (Double(triviaManager.score) / Double(triviaManager.numQuestions)) {
        case 0.0:
            return .secondary
        case 0.1..<0.41:
            return .red
        case 0.41..<0.61:
            return .orange
        case 0.61..<0.99:
            return .green
        case 0.99..<1.1:
            return Color("AccentColor")
        default:
            return .red
        }
    }
    
    var body: some View {
        if triviaManager.reachedEnd {
            VStack(spacing: 60) {
                Text("Your result:")
                    .accentTitle(color: resultColor)
                
                ProgressRing(resultColor: resultColor)
                    .environmentObject(triviaManager)
                
                HStack(spacing: 20) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        PillButton(text: "Back", background: Color(.secondarySystemGroupedBackground), foreground: .primary)
                    }
                    
                    
                    Button {
                        Task.init {
                            await triviaManager.fetchTrivia(difficulty: difficulty, category: category, amount: amount)
                        }
                    } label: {
                        PillButton(text: "Play again", background: resultColor)
                    }
                }

            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .foregroundStyle(resultColor)
            .toolbar(.hidden)
            .background(Color(.systemGroupedBackground))
            .onDisappear {
                triviaManager.reachedEnd = false
            }
            
        } else {
            QuestionView()
                .environmentObject(triviaManager)
        }
    }
}


struct TriviaView_Previews: PreviewProvider {
    @State static var difficulty: String = "any"
    @State static var category: String = "Any"
    @State static var amount: Int = 10

    static var previews: some View {
        TriviaView(difficulty: $difficulty, category: $category, amount: $amount)
            .environmentObject(TriviaManager())
    }
}
