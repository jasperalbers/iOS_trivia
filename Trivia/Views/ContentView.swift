//
//  ContentView.swift
//  Trivia
//
//  Created by Jasper on 21.04.24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var triviaManager = TriviaManager()
    @State private var selectedDifficulty = "any"
    @State private var selectedCategory = "Any"
    @State private var selectedAmount = 10

    
    var body: some View {
        NavigationView {
            VStack {
                VStack(spacing: 40) {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Trivia Game")
                            .accentTitle()
                        
                        Text("Questions from the [Open Trivia Database](https://opentdb.com)")
                            .foregroundStyle(Color("AccentColor"))
                            .font(.body)
                            .italic()
                    }
                    
                    Spacer()
              
                    VStack(spacing: 0) {
                        Text("How many questions?")
                            .foregroundStyle(.primary)
                            .font(.system(size: 18, weight: .regular, design: .rounded))
                            .padding()
                        Picker("Amount", selection: $selectedAmount) {
                            ForEach(1...50, id: \.self) { num in
                                Text("\(num)").tag(num)
                            }
                        }
                        .frame(maxWidth: 70)
                        .pickerStyle(.wheel)
                        
                    }
                    .frame(width: 330, height: 150)
                    .background()
                    .cornerRadius(25)
                    .shadow(color: .secondary, radius: 5)
                    
                    VStack(spacing: 20) {
                        Text("Which category?")
                            .foregroundStyle(.primary)
                            .font(.system(size: 18, weight: .regular, design: .rounded))
                        Picker("Category", selection: $selectedCategory) {
                            ForEach(["Any"] + Array(categories.keys).sorted(), id: \.self) { cat in
                                Text(cat).tag(cat)
                            }
                        }
                        .frame(maxWidth: 330)
                        
                    }
                    .frame(width: 330, height: 100)
                    .background()
                    .cornerRadius(25)
                    .shadow(color: .secondary, radius: 5)

                    
                    VStack(spacing: 20) {
                        Text("What difficulty?")
                            .foregroundStyle(.primary)
                            .font(.system(size: 18, weight: .regular, design: .rounded))
                        Picker("Difficulty", selection: $selectedDifficulty) {
                            ForEach(difficulties, id: \.self) { diff in
                                Text(diff).tag(diff)
                            }
                        }
                        .pickerStyle(.segmented)
                        .frame(maxWidth: 300)
                    }
                    .frame(width: 330, height: 120)
                    .background()
                    .cornerRadius(25)
                    .shadow(color: .secondary, radius: 5)
                    
                    NavigationLink {
                        TriviaView(difficulty: $selectedDifficulty, category: $selectedCategory, amount: $selectedAmount)
                            .environmentObject(triviaManager)
                            .onAppear {
                                Task {
                                    await triviaManager.fetchTrivia(difficulty: selectedDifficulty, category: selectedCategory, amount: selectedAmount)
                                }
                            }
                    } label: {
                        PillButton(text: "Let's go!")
                    }
                    
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
            }
        }
    }
}

#Preview {
    ContentView()
}
