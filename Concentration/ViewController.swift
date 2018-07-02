//
//  ViewController.swift
//  Concentration
//
//  Created by Marij on 29/04/2018.
//  Copyright © 2018 Marij. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private(set) lazy var Game = Concentration(NumberOfCardPairs: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (CardButtons.count + 1) / 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
    }
   
    @IBOutlet private weak var Flips: UILabel!
    
    @IBOutlet private weak var Score: UILabel!
    
    
    @IBOutlet private var CardButtons: [UIButton]!

    @IBAction private func touchNewGame(_ sender: UIButton) {
        startNewGame()
    }
    
    @IBAction private func TouchCard(_ sender: UIButton) {
        let CardNumber = CardButtons.index(of: sender)!
        Game.PickCard(at: CardNumber)
        UpdateViewFromModel()
    }
    
    private func startNewGame() {
        Game = Concentration(NumberOfCardPairs: (CardButtons.count + 1) / 2)
        setTheme()
        UpdateViewFromModel()
    }
    
    private func UpdateViewFromModel()
    {
        for index in CardButtons.indices {
            let Button = CardButtons[index]
            let card = Game.Cards[index]
            if card.isFaceUp {
                Button.setTitle(emoji(for: card), for: UIControlState.normal)
                Button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
            else {
                Button.setTitle("", for: UIControlState.normal)
                if (card.isMatched) {
                    Button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
                    Button.isEnabled = false
                } else {
                    Button.isEnabled = true
                    Button.backgroundColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
                }
            }
        }
        Score.text = "Score: \(Game.Score)"
        Flips.text = "Flips: \(Game.flipCount)"
    }
    
    private func setTheme() {
        let keysForEmojis = Array(typesOfEmojis.keys)
        let randomIndex = Int(arc4random_uniform(uint(keysForEmojis.count)))
        EmojiChoices = typesOfEmojis[keysForEmojis[randomIndex]]!
    }
    
    
    private let typesOfEmojis = [
        "faceEmojis" : ["😚", "😘", "😀", "😍", "😃", "😄","😂","🤣","☺️","😊","😇","🙂","🙃","😉","😌"],
        "animalEmojis" : ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊","🐻","🐼","🐨","🐯","🦁","🐮","🐷","🐵","🐸"],
        "sportEmojis" : ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐","🏉","🎱","🏓","🏸","🥅","🏒","🏑","🏏","🥊"],
        "foodEmojis" : ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌","🍉","🍇","🍓","🍈","🍒","🍑","🍍","🥥","🥝"],
        "flagEmojis" : ["🏳️", "🏴", "🏁", "🚩", "🏳️‍🌈", "🇦🇫","🇦🇽","🇦🇱","🇩🇿","🇦🇸","🇦🇩","🇦🇴","🇦🇮","🇦🇶","🇦🇬"],
        "vehicleEmojis" : ["🚗", "🚕", "🚙", "🚌", "🚎", "🚘","🚖","🚔","🚑","🚓","🏎","🏍","🚛","🚚","🚒"]
        ]
    
    
    private var EmojiChoices = ["😚", "😘", "😀", "😍", "😃", "😄","😂","🤣","☺️","😊","😇","🙂","🙃","😉","😌"]
    
    private var emoji = [Int:String]();
    
    
    private func emoji(for card: Card) -> String
    {
        if (emoji[card.identifier] == nil), (EmojiChoices.count > 0) {
            emoji[card.identifier] = EmojiChoices.remove(at: EmojiChoices.count.arc4random)
        }
        return emoji[card.identifier] ?? "?"
    }
}

extension Int {
    var arc4random : Int {
        if self > 0 {
            return Int(arc4random_uniform(uint(self)))
        }
        else if self < 0 {
            return -Int(arc4random_uniform(uint(abs(self))))
        }
        else {
            return 0
        }
    }
}


