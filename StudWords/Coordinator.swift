//
//  Coordinator.swift
//  StudWords
//
//  Created by Vitaliy Griza on 17.10.2022.
//

import Foundation
import UIKit

protocol CoordinatorProtocol {
    var rootViewController: UIViewController? { get }

    func start()
    func showMainScreen()

    func showAddWordScreen()
    func didAddWord()
    
    func showFullWordScreen(word: FullWordModel)
}

final class Coordinator {
    private let navigationController: UINavigationController
    private var tabController: TabViewController?

    init(navigationController: NavigationVC) {
        self.navigationController = navigationController
    }
}

extension Coordinator: CoordinatorProtocol {
    var rootViewController: UIViewController? {
        navigationController
    }

    func start() {
//        let storage = AppStorage.shared
//        lang = storage.selectedLanguage

//        if lang
        showChooseLanguage()
    }

    func showMainScreen() {
        
        let tabController = TabViewController(coordinator: self)

        let viewModel = AllWordsViewModel(storage: AppStorage.shared)
        let allWordsController = AllWordsVC(viewModel: viewModel, coordinator: self)

        let repeatWordsController = RepeatWordsVC()
        let centerController = UIViewController()

        tabController.setViewControllers(
            [repeatWordsController, centerController, allWordsController],
            animated: true
        )

        self.tabController = tabController

        navigationController.setViewControllers([tabController], animated: true)
    }

    func showAddWordScreen() {
        
        let viewModel = AddWordViewModel(storage: AppStorage.shared)
        let addWordVC = AddWordVC(viewModel: viewModel)
        addWordVC.modalPresentationStyle = .overFullScreen

        tabController?.present(addWordVC, animated: false)
    }

    func didAddWord() {
        tabController?.presentedViewController?.dismiss(animated: true)
    }
    
    func showFullWordScreen(word: FullWordModel) {
        let viewModel = DetailWordViewModel(word: word)
        let fullWordVC = DetailWordVC(viewModel: viewModel, coordinator: self)
        navigationController.pushViewController(fullWordVC, animated: true)
    }
}

private extension Coordinator {
    func showChooseLanguage() {
        let viewModel = ChooseLanguageViewModel(languageService: AppStorage.shared)

        let controller = ChooseLanguageViewController(
            viewModel: viewModel,
            coordinator: self
        )

        navigationController.setViewControllers([controller], animated: true)
    }
}
