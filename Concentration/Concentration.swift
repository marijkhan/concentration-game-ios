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
            if indexOfOneAndOnlyCard != nil {
                if Cards[indexOfOneAndOnlyCard!].identifier == Cards[index].identifier {
                    Cards[indexOfOneAndOnlyCard!].isMatched = true;
                    Cards[index].isMatched = true;
                } else {
                    indexOfOneAndOnlyCard = nil
                }
            } else {
                for Index in Cards.indices {
                    Cards[Index].isFaceUp = false
                }
                indexOfOneAndOnlyCard = index
                Cards[index].isFaceUp = true
            }
        }
    }
    
}
