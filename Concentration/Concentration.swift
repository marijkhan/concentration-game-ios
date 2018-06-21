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
    
    var indexOfOneAndOnlyCard : Int?
    
    init(NumberOfCardPairs: Int)
    {
        for _ in 1...NumberOfCardPairs
        {
            let card = Card()
            Cards += [card, card]
        }
        
    }
    func PickCard(at index: Int)
    {
        if !Cards[index].isMatched {
            if let matchedIndex = indexOfOneAndOnlyCard, index != matchedIndex {
                if Cards[matchedIndex].identifier == Cards[index].identifier {
                    Cards[matchedIndex].isMatched = true
                    Cards[index].isMatched = true
                }
                Cards[index].isFaceUp = true
                indexOfOneAndOnlyCard = nil
            }
            else {
                for flipIndex in Cards.indices {
                    Cards[flipIndex].isFaceUp = false
                }
                Cards[index].isFaceUp = true
                indexOfOneAndOnlyCard = index
            }
        }
    }
    
}
