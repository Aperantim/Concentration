//
//  ViewController.swift
//  SuperConcentration
//
//  Created by Виталий on 16/08/2019.
//  Copyright © 2019 Aperantim. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
    
//    var score = 0 {
//        didSet {
//            scoreLabel.text = "Score: \(score)"
//        }
//    }
    
    lazy var game: Concentration = Concentration(numberOfPairsOfCards: numberOfPairsOfCard)
    
    var numberOfPairsOfCard: Int {
        return (cardButtons.count + 1) / 2
    }
    
    var flipsCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipsCount)"
        }
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipsCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("There is no card!")
        }
    }
    

    
//    @IBOutlet weak var scoreLabel: UILabel!
//
//    @IBAction func startGameButton(_ sender: UIButton) {
//        startGame()
//    }
//
    func startGame() {
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
//        emoji = [:]
        updateViewFromModel()
        flipsCount = 0
//        score = 0
    }
    
    override func viewDidLoad() {
//        startGame()
    }

    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    func updateViewFromModel() {
        if cardButtons != nil {
            for index in cardButtons.indices {
                let card = game.cards[index]
                let button = cardButtons[index]
//                if card.isFaceUp, card.isMatched {
//                    score += 1
//                }
                if card.isFaceUp {
                    button.setTitle(emoji(for: card), for: UIControl.State.normal)
                    button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                } else {
                    button.setTitle("", for: UIControl.State.normal)
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
                }
            }
        }
    }
    
    var theme: String? {
        didSet {
            emojiChoices = theme ?? ""
            emoji = [:]
            updateViewFromModel()
        }
    }

    var emojiChoices = "🧀🍉🍟🍞🍖🥐"
    
    var emoji = [Card:String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?"
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
