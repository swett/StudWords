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
    
    static func map (oldStyleWord: OldStyleWord) -> Word {
        Word(
            text: oldStyleWord.word
        )
    }
}
