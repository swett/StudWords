//
//  Quiz.swift
//  StudWords
//
//  Created by Vitaliy Griza on 27.10.2022.
//

import Foundation


struct Question {
    let id: String
    let text: String
    let answers: [Answer]
    let answer: String
}

struct Answer {
    let text: String
    let correct: Bool
}

extension Answer {
    static var mock1 = Answer(text: "Нерухомість", correct: true)
    static var mock2 = Answer(text: "Третя особа", correct: false)
    static var mock3 = Answer(text: "Вихідні дзвінки", correct: false)
    static var mock4 = Answer(text: "Воронка", correct: false)
    static var mock5 = Answer(text: "Союзник", correct: false)
}
