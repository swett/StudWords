//
//  AppData.swift
//  StudWords
//
//  Created by Vitaliy Griza on 28.09.2022.
//

import UIKit


protocol AppDataProtocol{
    func getWord(completion: @escaping (_ words: [OldStyleWord]?,_ error: String?) -> Void)
}


class AppData: NSObject {
    
    static let shared = AppData()
    var word = OldStyleWord()
    var words: [OldStyleWord] = []
}

extension AppData: AppDataProtocol {
    func getWord(completion: @escaping ([OldStyleWord]?, String?) -> Void) {
        
            
        
        do {
            let words = try self.loadJson()
            self.words = words
            completion(words,nil)
        }
        catch {
            print(error)
        }
    }
}



extension AppData {
    func loadJson() throws -> [OldStyleWord] {
        guard let fileLocation = Bundle.main.url(forResource: "Data", withExtension: "json") else {
            assertionFailure("Missing json data")
            return []
        }

        let data = try Data(contentsOf: fileLocation)
        let words = try JSONDecoder().decode([OldStyleWord].self, from: data)

        return words
    }
}

extension AppData: StorageProtocol {
    
    func addWord(text: OldStyleWord){
//        var word = OldStyleWord()
        word.word = text.word
        word.synonym = text.synonym
        word.meaning = text.meaning
//        let mapped = WordMapper.map(oldStyleWord: word)
        
        words.append(word)
    }
    
    
    func getWords(completion: @escaping ([Word]?, String?) -> Void) {
        getWord { words, error in
            let mapped = words?.map { word in
                WordMapper.map(oldStyleWord: word)}
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                completion(mapped,error)
            }
            
        }
    }
    
    
}

