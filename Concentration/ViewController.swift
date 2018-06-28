//
//  ViewController.swift
//  Concentration
//
//  Created by Marij on 29/04/2018.
//  Copyright © 2018 Marij. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var Game = Concentration(NumberOfCardPairs: (CardButtons.count + 1) / 2)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
    }
   
    @IBOutlet weak var Flips: UILabel!
    
    var FlipCount = 0 {
        didSet {
            Flips.text = "Flips: \(FlipCount)"
        }
    }
    
    @IBOutlet var CardButtons: [UIButton]!

    @IBAction func touchNewGame(_ sender: UIButton) {
        startNewGame()
    }
    
    @IBAction func TouchCard(_ sender: UIButton) {
        let CardNumber = CardButtons.index(of: sender)!
        Game.PickCard(at: CardNumber)
        UpdateViewFromModel()
        FlipCount += 1
    }
    
    func startNewGame() {
        Game = Concentration(NumberOfCardPairs: (CardButtons.count + 1) / 2)
        FlipCount = 0
        setTheme()
        UpdateViewFromModel()
    }
    
    func UpdateViewFromModel()
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
    }
    
    func setTheme() {
        let keysForEmojis = Array(typesOfEmojis.keys)
        let randomIndex = Int(arc4random_uniform(uint(keysForEmojis.count)))
        EmojiChoices = typesOfEmojis[keysForEmojis[randomIndex]]!
    }
    
    
    let typesOfEmojis = [
        "faceEmojis" : ["😚", "😘", "😀", "😍", "😃", "😄","😂","🤣","☺️","😊","😇","🙂","🙃","😉","😌"],
        "animalEmojis" : ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊","🐻","🐼","🐨","🐯","🦁","🐮","🐷","🐵","🐸"],
        "sportEmojis" : ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐","🏉","🎱","🏓","🏸","🥅","🏒","🏑","🏏","🥊"],
        "foodEmojis" : ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌","🍉","🍇","🍓","🍈","🍒","🍑","🍍","🥥","🥝"],
        "flagEmojis" : ["🏳️", "🏴", "🏁", "🚩", "🏳️‍🌈", "🇦🇫","🇦🇽","🇦🇱","🇩🇿","🇦🇸","🇦🇩","🇦🇴","🇦🇮","🇦🇶","🇦🇬"],
        "vehicleEmojis" : ["🚗", "🚕", "🚙", "🚌", "🚎", "🚘","🚖","🚔","🚑","🚓","🏎","🏍","🚛","🚚","🚒"]
        ]
    
    
    var EmojiChoices = ["😚", "😘", "😀", "😍", "😃", "😄","😂","🤣","☺️","😊","😇","🙂","🙃","😉","😌"]
    
    var emoji = [Int:String]();
    
    
    func emoji(for card: Card) -> String
    {
        if (emoji[card.identifier] == nil), (EmojiChoices.count > 0) {
            let randomIndex = Int(arc4random_uniform(uint(EmojiChoices.count)))
            emoji[card.identifier] = EmojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }

    
    

}

