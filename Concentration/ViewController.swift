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
    private var currentTheme = Theme.randomTheme()

    var numberOfPairsOfCards: Int {
        return (CardButtons.count + 1) / 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
    }
    
    @IBOutlet private weak var Flips: UILabel!
    
    @IBOutlet private weak var Score: UILabel!
    
    @IBOutlet private weak var UIbackground: UIView!

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
        currentTheme = Theme.randomTheme()
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
                    Button.backgroundColor = currentTheme.associatedTheme.cardColor
                }
            }
        }
        Score.text = "Score: \(Game.Score)"
        Flips.text = "Flips: \(Game.flipCount)"
    }
    

    private func setTheme() {
        EmojiChoices = currentTheme.associatedTheme.emojis
        UIbackground.backgroundColor = currentTheme.associatedTheme.backGroundColor
    }
    
    private enum Theme : Int {
        case faceTheme
        case animalTheme
        case sportTheme
        case foodTheme
        case flagTheme
        case vehicleTheme
        
        var associatedTheme: (emojis: [String], backGroundColor: UIColor, cardColor: UIColor) {
            switch self {
            case .faceTheme:
                return (["😚", "😘", "😀", "😍", "😃", "😄","😂","🤣","☺️","😊","😇","🙂","🙃","😉","😌"],#colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1), #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1))
            case .animalTheme:
                return (["🐶", "🐱", "🐭", "🐹", "🐰", "🦊","🐻","🐼","🐨","🐯","🦁","🐮","🐷","🐵","🐸"],#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
            case .sportTheme:
                return (["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐","🏉","🎱","🏓","🏸","🥅","🏒","🏑","🏏","🥊"],#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1))
            case .foodTheme:
                return (["🍏", "🍎", "🍐", "🍊", "🍋", "🍌","🍉","🍇","🍓","🍈","🍒","🍑","🍍","🥥","🥝"],#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1))
            case .flagTheme:
                return (["🏳️", "🏴", "🏁", "🚩", "🏳️‍🌈", "🇦🇫","🇦🇽","🇦🇱","🇩🇿","🇦🇸","🇦🇩","🇦🇴","🇦🇮","🇦🇶","🇦🇬"],#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1), #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1))
            case .vehicleTheme:
                return (["🚗", "🚕", "🚙", "🚌", "🚎", "🚘","🚖","🚔","🚑","🚓","🏎","🏍","🚛","🚚","🚒"],#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1))
            }
        }
        private static var count : Int {
            var maxValue = 0
            while let _ = Theme(rawValue: maxValue) {
                maxValue += 1
            }
            return maxValue
        }
        
        static func randomTheme() -> Theme {
            let rand = count.arc4random
            return Theme(rawValue: rand)!
        }
    }
    
    private var EmojiChoices = ["😚", "😘", "😀", "😍", "😃", "😄","😂","🤣","☺️","😊","😇","🙂","🙃","😉","😌"]
    
    private var emoji = [Card:String]();
    
    private func emoji(for card: Card) -> String
    {
        if (emoji[card] == nil), (EmojiChoices.count > 0) {
            emoji[card] = EmojiChoices.remove(at: EmojiChoices.count.arc4random)
        }
        return emoji[card] ?? "?"
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

extension Collection {
    func oneAndOnly() -> Element? {
        return count == 1 ? first : nil
    }
}


