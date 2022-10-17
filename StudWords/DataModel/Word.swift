//
//  Word.swift
//  StudWords
//
//  Created by Vitaliy Griza on 29.09.2022.
//

import UIKit



struct Word: Codable {
    let id: String
    let text: String
    let synonym: [String]
    let meaning: String
}

extension Word {
    static var mockedWord: Word {
        .init(
            id: UUID().uuidString,
            text: "Mocked Word",
            synonym: [],
            meaning: ""
        )
    }
}

