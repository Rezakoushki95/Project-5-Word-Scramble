//
//  ViewController.swift
//  Project 5 Word Scramble
//
//  Created by Reza Koushki on 06/02/2023.
//

import UIKit

class ViewController: UITableViewController {
	
	var allWords: [String] = []
	var usedWords = [String]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
		
		if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
			if let startsWords = try? String(contentsOf: startWordsURL) {
				allWords = startsWords.components(separatedBy: "\n")
			}
		}
		
		if allWords.isEmpty {
			allWords = ["silkworm"]
		}
		
		startGame()
	}
	
	func startGame() {
		title = allWords.randomElement()
		usedWords.removeAll(keepingCapacity: true)
		tableView.reloadData()
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return usedWords.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
		cell.textLabel?.text = usedWords[indexPath.row]
		return cell
	}
	
	@objc func promptForAnswer() {
		let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
		ac.addTextField()
		
		let sumbitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] _ in
			guard let answer = ac?.textFields?[0].text else {return}
			self?.submit(answer)
		}
		
		ac.addAction(sumbitAction)
		present(ac, animated: true)
	}
	
	func submit(_ answer: String) {
		
	}
}

