//
//  WordManager.swift
//  Compass Test
//
//  Created by Martin De Simone on 31/05/2024.
//

import Foundation
protocol WordManager {
    func fetchWordCounter() async -> [String: Int]
    func fetchEvery10Character() async -> [String.Element]
}

public class AppWordManager: WordManager {
    let wordRepository: WordRepository
    
    init(wordRepository: WordRepository){
        self.wordRepository = wordRepository
    }
    
    func fetchEvery10Character() async -> [String.Element]{
        guard let words = await fetchWords() else {
            return []
        }
        
        var characters = [String.Element]()
        for (index, char) in words.enumerated() {
            if index % 10 == 0 {
                characters.append(char)
            }
        }
        
        return characters
    }
    
    func fetchWordCounter() async -> [String: Int]{
        guard let words = await fetchWords() else {
            return [:]
        }
        
        let individualWords = words.components(separatedBy: " ").filter{ $0 != " " }
        
        var wordDictionary = [String: Int]()
        for word in individualWords {
            if wordDictionary[word] == nil {
                wordDictionary[word] = 1
            } else {
                wordDictionary[word] = (wordDictionary[word] ?? 0) + 1
            }
        }
        
        return wordDictionary
    }
    
    func fetchWords() async -> String? {
        return await wordRepository.fetchWords()
    }
}

class MockSuccessWordManager: WordManager {
    func fetchWordCounter() async -> [String : Int] {
        return ["Test": 10, "Juan": 15]
    }
    
    func fetchEvery10Character() async -> [String.Element] {
        return ["s", "f", "k"]
    }
}

class MockFailureWordManager: WordManager {
    func fetchWordCounter() async -> [String : Int] {
        return [:]
    }
    
    func fetchEvery10Character() async -> [String.Element] {
        return []
    }
}
