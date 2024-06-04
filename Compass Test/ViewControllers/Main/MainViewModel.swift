//
//  MainViewModel.swift
//  Compass Test
//
//  Created by Martin De Simone on 31/05/2024.
//

import Foundation

class MainViewModel {
    let wordsManager: WordManager
    
    var wordCount = [String: Int]()
    var wordList = [String]()
    var characterList = [String.Element]()
    
    init(wordsManager: WordManager){
        self.wordsManager = wordsManager
    }
    
    func fetchData() async {
        async let wordTask = wordsManager.fetchWordCounter()
        async let characterTask = wordsManager.fetchEvery10Character()
        
        self.characterList = await characterTask
        self.wordCount = await wordTask
        
        self.wordList = Array(wordCount.keys)
    }
    
}
