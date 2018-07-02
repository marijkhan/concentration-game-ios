//
//  Concentration.swift
//  Concentration
//
//  Created by Marij on 13/05/2018.
//  Copyright © 2018 Marij. All rights reserved.
//

import Foundation

class Concentration
{
    var Cards = [Card]()
    
    var indexOfOneAndOnlyCard : Int? {
        get {
            var foundIndex: Int?
            for index in Cards.indices {
                if Cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in Cards.indices {
                Cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    var Score = 0
    
    init(NumberOfCardPairs: Int)
    {
        for _ in 1...NumberOfCardPairs
        {
            let card = Card()
            Cards += [card, card]
        }
        shuffleCards()
    }

    func shuffleCards() {
        for index in Cards.indices {
            let randomIndex = Int(arc4random_uniform(uint(Cards.count)))
            let swapCard = Cards[index]
            Cards[index] = Cards[randomIndex]
            Cards[randomIndex] = swapCard
        }
    }
    
    func PickCard(at index: Int)
    {
        if !Cards[index].isMatched {
            if let matchedIndex = indexOfOneAndOnlyCard, index != matchedIndex {
                if Cards[matchedIndex].identifier == Cards[index].identifier {
                    Cards[matchedIndex].isMatched = true
                    Cards[index].isMatched = true
                    Score += 2
                } else {
                    if (Cards[index].wasSeen) {
                        Score -= 1
                    }
                    else {
                        Cards[index].wasSeen = true;
                    }
                    if (matchingCardWasSeen(of: indexOfOneAndOnlyCard!)) {
                        Score -= 1
                    }
                    if (Cards[indexOfOneAndOnlyCard!].wasSeen) {
                        Score -= 1
                    }
                    else {
                        Cards[indexOfOneAndOnlyCard!].wasSeen = true;
                    }
                }
                Cards[index].isFaceUp = true
                
            }
            else {
                indexOfOneAndOnlyCard = index
            }
        }
    }
    

    func matchingCardWasSeen(of cardIndex: Int) -> Bool! {
        for index in Cards.indices {
            if Cards[index].identifier == Cards[cardIndex].identifier, cardIndex != index  {
                return Cards[index].wasSeen
            }
        }
        return nil
    }
    
}
