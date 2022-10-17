//
//  ChooseLanguageViewModel.swift
//  StudWords
//
//  Created by Vitaliy Griza on 17.10.2022.
//

import Foundation

final class ChooseLanguageViewModel {
    var languages: [Language] {
        languageService.languages
    }

    weak var view: ChooseLanguageView?

    private let languageService: LanguageServiceProtocol

    init(languageService: LanguageServiceProtocol) {
        self.languageService = languageService
    }
}

extension ChooseLanguageViewModel {
    func setLanguage(_ language: Language) {
        languageService.setLanguage(language)
        view?.showMainScreen()
    }
}
