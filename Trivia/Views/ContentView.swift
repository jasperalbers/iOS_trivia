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
                VStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Trivia Game")
                            .accentTitle()
                        
                        Text("Questions from the [Open Trivia Database](https://opentdb.com)")
                            .foregroundStyle(Color("AccentColor"))
                            .font(.body)
                            .italic()
                    }
                    
                    Spacer()
              
                    HStack(spacing: 0) {
                
                        VStack(alignment: .leading) {
                            Image(systemName: "number.circle.fill")
                                .font(.system(size: 40))
                                .padding(.leading, 15)
                                .padding(.top, 15)
                                .foregroundStyle(Color("AccentColor"))
                            
                            Spacer()
                            
                            Text("How many questions?")
                                .foregroundStyle(.secondary)
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .padding(.leading, 20)
                                .padding(.bottom, 15)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Picker("Amount", selection: $selectedAmount) {
                            ForEach(1...50, id: \.self) { num in
                                Text("\(num)").tag(num)
                            }
                        }
                        .frame(maxWidth: 70)
                        .pickerStyle(.wheel)
                        .padding(10)
                        
                    }
                    .frame(width: 330, height: 120)
                    .background(Color(.secondarySystemGroupedBackground))
                    .cornerRadius(15)
                    
                    HStack(spacing: 0) {
                        VStack(alignment: .leading) {
                            Image(systemName: "tag.circle.fill")
                                .font(.system(size: 40))
                                .padding(.leading, 15)
                                .padding(.top, 15)
                                .foregroundStyle(Color("AccentColor"))
                            
                            Spacer()
                            
                            Text("Which category?")
                                .foregroundStyle(.secondary)
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .padding(.leading, 20)
                                .padding(.bottom, 15)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Picker("Category", selection: $selectedCategory) {
                            ForEach(["Any"] + Array(categories.keys).sorted(), id: \.self) { cat in
                                Text(cat).tag(cat)
                            }
                        }
                        .frame(maxWidth: 80)
                        .padding(10)
                        
                    }
                    .frame(width: 330, height: 120)
                    .background(Color(.secondarySystemGroupedBackground))
                    .cornerRadius(15)

                    
                    VStack(spacing: 0) {
                        VStack(alignment: .leading, spacing: 20) {
                            
                            Image(systemName: "flame.circle.fill")
                                .font(.system(size: 40))
                                .padding(.leading, 15)
                                .padding(.top, 15)
                                .foregroundStyle(Color("AccentColor"))
                            
                            Text("What difficulty?")
                                .foregroundStyle(.secondary)
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .padding(.leading, 20)
                                .padding(.bottom, 15)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Spacer()
                        
                        Picker("Difficulty", selection: $selectedDifficulty) {
                            ForEach(difficulties, id: \.self) { diff in
                                Text(diff).tag(diff)
                            }
                        }
                        .pickerStyle(.segmented)
                        .frame(maxWidth: 300)
                        .padding(.bottom, 20)
                    }
                    .frame(width: 330, height: 180)
                    .background(Color(.secondarySystemGroupedBackground))
                    .cornerRadius(15)
                    
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
                .background(Color(.systemGroupedBackground))
            }
        }
    }
}

#Preview {
    ContentView()
}
