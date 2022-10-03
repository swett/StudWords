//
//  MainViewModel.swift
//  StudWords
//
//  Created by Vitaliy Griza on 03.10.2022.
//

import Foundation

protocol MainViewDelegate: AnyObject {
    func didChangeLoadingState(isLoading: Bool)
    func didEndLoading()
}


protocol StorageProtocol {
    func getWords(completion: @escaping ([Word]?, String?) -> Void)
}

protocol MainViewModelProtocol {
    var delegate: MainViewDelegate? {get set}
    
    func viewDidAppear()
    func numberOfRows(in section: Int) -> Int
    func model(at indexPath: IndexPath) -> WordViewModel
    
    func didSelectRow(at indexPath: IndexPath)
}


class MainViewModel {
    private var words: [Word] = []
    private let storage: StorageProtocol!
    
    weak var delegate: MainViewDelegate?
    
    
    init(storage: StorageProtocol){
        self.storage = storage
    }
    
    
    func setup() {
        delegate?.didChangeLoadingState(isLoading: true)
        storage.getWords { [weak self] words, error in
            guard let words = words else {
                assertionFailure(error ?? "LOH")
                return
            }
            self?.words = words
            self?.delegate?.didChangeLoadingState(isLoading: false)
            self?.delegate?.didEndLoading()
        }
    }
}


extension MainViewModel: MainViewModelProtocol {
    
    
    func viewDidAppear() {
        setup()
    }
    
    func numberOfRows(in section: Int) -> Int {
        words.count
    }
    
    func model(at indexPath: IndexPath) -> WordViewModel {
        let model = words[indexPath.row]
        
        return WordMapper.map(word: model)
        
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        let model = words[indexPath.row]
    }
    
}
