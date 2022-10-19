//
//  MainViewModel.swift
//  StudWords
//
//  Created by Vitaliy Griza on 03.10.2022.
//

import Foundation

protocol AllWordsView: AnyObject {
    func didChangeLoadingState(isLoading: Bool)
    func didEndLoading()
}

protocol AllWordsModelProtocol {
    var delegate: AllWordsView? {get set}
    
    func viewDidAppear()
    func numberOfRows(in section: Int) -> Int
    func model(at indexPath: IndexPath) -> WordViewModel
    func didSelectRow(at indexPath: IndexPath) -> FullWordModel
}


class AllWordsViewModel {
    private var words: [Word] = []
    private let storage: StorageProtocol!
    
    weak var delegate: AllWordsView?
    
    
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


extension AllWordsViewModel: AllWordsModelProtocol {
    
    
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
    
    func didSelectRow(at indexPath: IndexPath)-> FullWordModel {
        let model = words[indexPath.row]
        
        return WordMapper.mapToFullWord(word: model)
    }
    
    
}
