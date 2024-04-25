//
//  TriviaManager.swift
//  Trivia
//
//  Created by Jasper on 21.04.24.
//

import Foundation

class TriviaManager: ObservableObject {
    private(set) var trivia: [Trivia.Result] = []
    @Published private(set) var numQuestions = 0
    @Published private(set) var questionIndex = 0
    @Published private(set) var reachedEnd = false
    @Published private(set) var answerSelected = false
    @Published private(set) var question: AttributedString = ""
    @Published private(set) var answerChoices: [Answer] = []
    @Published private(set) var progress: CGFloat = 0.0
    @Published private(set) var score = 0
    
    init() {
        DispatchQueue.main.async {
            self.questionIndex = 0
            self.score = 0
            self.progress = 0.0
            self.reachedEnd = false
        }
    }
    
    func fetchTrivia(difficulty: String = "any", category: String = "Any", amount: Int = 10) async {
        
        var url_string = "https://opentdb.com/api.php?amount=\(amount)"
        if category != "Any" {
            url_string += "&category=\(categories[category] ?? 9)"
        }
        if difficulty != "any" {
            url_string += "&difficulty=\(difficulty)"
        }
        
        guard let url = URL(string: url_string) else { fatalError("Missing URl") }
        
        let urlRequest = URLRequest(url: url)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try decoder.decode(Trivia.self, from: data)
            
            DispatchQueue.main.async {
                self.questionIndex = 0
                self.score = 0
                self.progress = 0.0
                self.reachedEnd = false
                
                self.trivia = decodedData.results
                self.numQuestions = self.trivia.count
                self.setQuestion()
            }
            
        } catch {
            print("Error fetching trivia: \(error)")
        }
    }
    
    func goToNextQuestion() {
        if questionIndex + 1 < numQuestions {
            questionIndex += 1
            setQuestion()
        } else {
            reachedEnd = true
        }
    }
    
    func setQuestion() {
        answerSelected = false
        progress = CGFloat(Double(questionIndex + 1) / Double(numQuestions))
        
        if questionIndex < numQuestions {
            let currentTriviaQuestion = trivia[questionIndex]
            question = currentTriviaQuestion.formattedQuestion
            answerChoices = currentTriviaQuestion.answers
        }
    }
    
    func selectAnswer(answer: Answer) {
        answerSelected = true
        if answer.isCorrect {
            score += 1
        }
    }
}
