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
   
    @IBOutlet weak var Flips: UILabel!
    
    var FlipCount = 0 {
        didSet {
            Flips.text = "Flips: \(FlipCount)"
        }
    }
    
    @IBOutlet var CardButtons: [UIButton]!

    
    @IBAction func TouchCard(_ sender: UIButton) {
        let CardNumber = CardButtons.index(of: sender)!
        Game.PickCard(at: CardNumber)
        UpdateViewFromModel()
        FlipCount += 1
    }
    
    func UpdateViewFromModel()
    {
        for index in CardButtons.indices {
            let Button = CardButtons[index]
            let card = Game.Cards[index]
            if card.isFaceUp {
                Button.setTitle(emoji(for: card), for: UIControlState.normal)
                Button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                //print(emoji(for: card))
            }
            else {
                Button.setTitle("", for: UIControlState.normal)
                Button.backgroundColor = card.isMatched ? #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 0) : #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
            }
        }
    }
    
    var EmojiChoices = ["😚", "😘", "😀", "😍", "😃", "😄"]
    var emoji = [Int:String]();
    
    
    func emoji(for card: Card) -> String
    {
        //let chosenEmoji = emoji[card.identifier]
        if (emoji[card.identifier] == nil), (EmojiChoices.count > 0) {
            let randomIndex = Int(arc4random_uniform(uint(EmojiChoices.count)))
            emoji[card.identifier] = EmojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }

    
    

}

