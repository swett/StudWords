//
//  FullWordViewModel.swift
//  StudWords
//
//  Created by Vitaliy Griza on 18.10.2022.
//

import Foundation


struct FullWordModel {
    let text: String
    let synonym: [String]
    let meaning: String
}



final class DetailWordViewModel {
    
    weak var view: DetailWordVC?
    
    
    
    var word: FullWordModel
    
    init(word: FullWordModel) {
        self.word = word
    }
}


extension DetailWordViewModel {

    func viewWillAppear() {
        view?.load(with: word)
    }
}




