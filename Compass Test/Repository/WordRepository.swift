//
//  WordRepository.swift
//  Compass Test
//
//  Created by Martin De Simone on 31/05/2024.
//

import Foundation
protocol WordRepository {
    func fetchWords() async -> String?
}

class AppWordRepository: WordRepository {
    let wordsFile = "wordsFile.txt"

    func fetchWords() async -> String? {
        do {
            if let localCache = fetchWordsLocally() {
                return localCache
            }

            let (data, response) = try await URLSession.shared.data(from: URL(string: Constants.wordRepositoryBaseUrl)!)
            let words = String(decoding: data, as: UTF8.self)
            saveWordsLocally(words: words)
            return words
        } catch {
            return nil
        }
    }
    
    func saveWordsLocally(words: String){
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(wordsFile)
            do {
                try words.write(to: fileURL, atomically: false, encoding: .utf8)
            }
            catch {
                
            }
        }
    }
    
    func fetchWordsLocally() -> String?{
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(wordsFile)
            do {
                return try String(contentsOf: fileURL, encoding: .utf8)
            }
            catch {
                return nil
            }
        }
        
        return nil
    }
}

class MockWordSuccessRepository: WordRepository {
    func fetchWords() async -> String? {
        return "test test 1 1 test hi testing 123 tester"
    }
}

class MockWordFailureRepository: WordRepository {
    func fetchWords() async -> String? {
        return nil
    }
}
