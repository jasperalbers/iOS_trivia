//
//  Answer.swift
//  Trivia
//
//  Created by Jasper on 21.04.24.
//

import Foundation

struct Answer: Identifiable {
    var id = UUID()
    var text: AttributedString
    var isCorrect: Bool
}
