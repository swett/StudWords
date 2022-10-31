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
}

struct Answer {
    let text: String
    let correct: Bool
}

extension Answer {
    static var mock1 = Answer(text: "Лох", correct: true)
    static var mock2 = Answer(text: "Идиот", correct: false)
    static var mock3 = Answer(text: "Конченный", correct: false)
    static var mock4 = Answer(text: "Пивас", correct: false)
    static var mock5 = Answer(text: "Кура", correct: false)
}
