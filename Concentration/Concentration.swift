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
    private(set) var Cards = [Card]()
    
    private(set) var Score = 0
    private(set) var flipCount = 0
    
    private var indexOfOneAndOnlyCard : Int? {
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
    
    
    init(NumberOfCardPairs: Int)
    {
        assert(NumberOfCardPairs > 0, "Concentration.init(NumberOfCardPairs: \(NumberOfCardPairs): There must be at least one card pair")
        for _ in 1...NumberOfCardPairs
        {
            let card = Card()
            Cards += [card, card]
        }
        shuffleCards()
    }

    private func shuffleCards() {
        for index in Cards.indices {
            let randomIndex = Int(arc4random_uniform(uint(Cards.count)))
            let swapCard = Cards[index]
            Cards[index] = Cards[randomIndex]
            Cards[randomIndex] = swapCard
        }
    }
    
    func PickCard(at index: Int)
    {
        assert(Cards.indices.contains(index), "Concentration.PickCard(at: \(index): Chosen index not in the cards")
        if !Cards[index].isMatched {
            if let matchedIndex = indexOfOneAndOnlyCard {
                if index != matchedIndex {
                    if Cards[matchedIndex].identifier == Cards[index].identifier {
                        Cards[matchedIndex].isMatched = true
                        Cards[index].isMatched = true
                        Score += 2
                    }
                    else {
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
                    flipCount -= 1
                }
            }
            else {
                indexOfOneAndOnlyCard = index
            }
            flipCount += 1
        }
    }
    

    private func matchingCardWasSeen(of cardIndex: Int) -> Bool! {
        for index in Cards.indices {
            if Cards[index].identifier == Cards[cardIndex].identifier, cardIndex != index  {
                return Cards[index].wasSeen
            }
        }
        return nil
    }
    
}
