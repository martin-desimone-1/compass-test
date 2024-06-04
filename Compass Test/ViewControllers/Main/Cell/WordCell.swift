//
//  WordCell.swift
//  Compass Test
//
//  Created by Martin De Simone on 31/05/2024.
//

import UIKit
class WordCell: UITableViewCell {
    let textView = UITextView()

    func setup(character: String.Element){
        setupTextView()
        
        textView.text = "Character: " + String(character)
    }
    
    func setup(word: String, wordCount: Int){
        setupTextView()
        
        textView.text = word + " Repeated: " + String(wordCount)
        
    }
    
    func setupTextView(){
        textView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textView)
        
        textView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        textView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10).isActive = true
        textView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10).isActive = true
        textView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
    }
}
