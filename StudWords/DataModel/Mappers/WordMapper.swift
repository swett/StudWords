//
//  WordMapper.swift
//  StudWords
//
//  Created by Vitaliy Griza on 03.10.2022.
//

import Foundation

enum WordMapper {
    static func map(word: Word) -> WordViewModel {
        WordViewModel(
            text: word.text,
            translation: ""
        )
    }
    
    static func mapToFullWord(word:Word) -> FullWordModel {
        FullWordModel(
            text: word.text,
            synonym: word.synonym,
            meaning: word.meaning)
    }
    
    static func mapToFlashCardModel(word:Word) -> Question {
        var answers: [String] = ["some", "any" , "new"]
        answers.append(word.meaning)
        
        var mappedAnswer: [Answer] = []
        
        for answer in answers {
            mappedAnswer.append(Answer(text: answer, correct: word.meaning == answer ? true : false))
        }
    
        mappedAnswer.shuffle()
        
        return Question(id: word.id, text: word.text, answers: mappedAnswer)
    }
}
