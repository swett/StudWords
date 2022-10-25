//
//  RepeatWordsViewModel.swift
//  StudWords
//
//  Created by Vitaliy Griza on 25.10.2022.
//

import Foundation


protocol RepeatWordsModelProtocol {
    func numberOfRows(in section: Int)-> Int
}



class RepeatWordsModel {
    
    private var words: [Word] = []
    private let storage: StorageProtocol!
    
    init(storage: StorageProtocol){
        self.storage = storage
    }
}

extension RepeatWordsModel: RepeatWordsModelProtocol {
    func numberOfRows(in section: Int) -> Int {
        words.count
    }
    
    
}
