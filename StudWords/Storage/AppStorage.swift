//
//  WordsStorage.swift
//  StudWords
//
//  Created by Vitaliy Griza on 03.10.2022.
//

import Foundation


protocol LanguageServiceProtocol {
    var languages: [Language] { get }
    var selectedLanguage: Language { get }
    func setLanguage(_ language: Language)
}

protocol StorageProtocol {
    func getWords(completion: @escaping ([Word]?, String?) -> Void)
    func addWord(word: Word, completion: @escaping (Word, String?) -> Void)
    func removeWord(word: Word, completion: @escaping (String?) -> Void)
}

enum StorageError: Error {
    case somethingWentWrong
}

class AppStorage {
    static let shared = AppStorage()
    private var words: [Word] = []
    private var language: Language?

    private init() {
        loadWords()
        tryLoadLanguage()
    }
}

// MARK: - Private
private extension AppStorage {
    func loadWords() {
        guard let fileLocation = Bundle.main.url(forResource: "Data", withExtension: "json") else {
            assertionFailure("Missing json data")
            return
        }

        do {
            let data = try Data(contentsOf: fileLocation)
            words = try JSONDecoder().decode([Word].self, from: data)
        } catch {
            fatalError("Missing json data")
        }
    }

    func tryLoadLanguage() {
        // TODO: load language from user defaults
    }

    func addWord(_ word: Word) {
        words.append(word)
    }

    func removeWord(_ word: Word) throws {
        guard let index = words.firstIndex(where: { $0.id == word.id }) else {
            throw StorageError.somethingWentWrong
        }

        words.remove(at: index)
    }
}

//MARK: - LanguageProtocol
extension AppStorage: LanguageServiceProtocol {
    var languages: [Language] {
        [.ua, .en]
    }

    var selectedLanguage: Language {
        guard let language = language else {
            fatalError("Missing selected language")
        }

        return language
    }

    func setLanguage(_ language: Language) {
        self.language = language
        // TODO: save to user defaults
    }
}

//MARK: - StorageProtocol
extension AppStorage: StorageProtocol {
    func getWords(completion: @escaping ([Word]?, String?) -> Void) {
        completion(words, nil)
    }

    func addWord(word: Word, completion: @escaping (Word, String?) -> Void) {
        addWord(word)
        completion(word, nil)
    }

    func removeWord(word: Word, completion: @escaping (String?) -> Void) {
        do {
            try removeWord(word)
            completion(nil)
        } catch {
            completion("Can't find word")
        }
    }
}

