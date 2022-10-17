//
//  AddWordViewModel.swift
//  StudWords
//
//  Created by Vitaliy Griza on 17.10.2022.
//

import Foundation

final class AddWordViewModel {
    weak var view: AddWordView?

    private let storage: StorageProtocol

    init(storage: StorageProtocol) {
        self.storage = storage
    }
}

extension AddWordViewModel {
    func validateWord(text: String?, description: String?, synonim: String?) {
        let isValid = text?.isEmpty != true
            && description?.isEmpty != true
            && synonim?.isEmpty != true

        view?.updateValidationState(isValid: isValid)
    }

    func addWord(text: String, description: String, synonim: String) {
        let word = Word(
            id: UUID().uuidString,
            text: text,
            synonym: [synonim],
            meaning: description
        )

        storage.addWord(word: word) { [weak self] _, error in
            if let error = error {
                self?.view?.showError(message: error)
            } else {
                self?.view?.didAddWord()
            }
        }
    }
}
