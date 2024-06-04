//
//  ViewController.swift
//  Compass Test
//
//  Created by Martin De Simone on 31/05/2024.
//

import UIKit

class MainViewController: UIViewController {

    let requestButton = UIButton()
    let charactersTableView = UITableView()
    let wordsTableView = UITableView()
    
    let viewModel = MainViewModel(wordsManager: AppWordManager(wordRepository: AppWordRepository()))
    
    struct Constants {
        static let wordCellReuseIdentifier = "wordCell"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
                
        setupUI()
    }
    
    func setupUI(){
        setupRequestButton()
        setupTableViews()
    }
    
    func setupRequestButton() {
        requestButton.translatesAutoresizingMaskIntoConstraints = false
        requestButton.addTarget(self, action: #selector(requestTapped), for: .touchUpInside)
        requestButton.setTitle("Request", for: .normal)
        requestButton.layer.cornerRadius = 6
        requestButton.backgroundColor = .brown
        view.addSubview(requestButton)
        
        requestButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        requestButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        requestButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        requestButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
    }
    
    func setupTableViews(){
        charactersTableView.translatesAutoresizingMaskIntoConstraints = false
        wordsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(charactersTableView)
        view.addSubview(wordsTableView)
        
        wordsTableView.dataSource = self
        charactersTableView.dataSource = self
        
        wordsTableView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        charactersTableView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        wordsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        wordsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        
        charactersTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        charactersTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        
        wordsTableView.topAnchor.constraint(equalTo: requestButton.bottomAnchor, constant: 10).isActive = true
        charactersTableView.topAnchor.constraint(equalTo: wordsTableView.bottomAnchor, constant: 10).isActive = true
        
        wordsTableView.register(WordCell.self, forCellReuseIdentifier: Constants.wordCellReuseIdentifier)
        charactersTableView.register(WordCell.self, forCellReuseIdentifier: Constants.wordCellReuseIdentifier)
    }

    @objc
    func requestTapped(){
        Task {
            await viewModel.fetchData()
            
            wordsTableView.reloadData()
            charactersTableView.reloadData()
        }
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let wordCell = tableView.dequeueReusableCell(withIdentifier: Constants.wordCellReuseIdentifier, for: indexPath) as? WordCell else {
            return UITableViewCell()
        }
        if(tableView == wordsTableView) {            
            let word = viewModel.wordList[indexPath.row]
            wordCell.setup(word: word, wordCount: viewModel.wordCount[word] ?? 0)
        } else if(tableView == charactersTableView){
            wordCell.setup(character: viewModel.characterList[indexPath.row])
        }
        return wordCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == wordsTableView {
            return viewModel.wordList.count
        } else if tableView == charactersTableView {
            return viewModel.characterList.count
        }
        
        return 0
    }
}
