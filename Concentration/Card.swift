//
//  Card.swift
//  Concentration
//
//  Created by Marij on 13/05/2018.
//  Copyright © 2018 Marij. All rights reserved.
//

import Foundation

struct Card: Hashable
{
    var hashValue: Int {
        return identifier
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isMatched = false
    var isFaceUp = false
    private var identifier: Int
    var wasSeen = false
    
    private static var IdentifierFactory = 0
    
    private static func GetUniqueIdentifier() -> Int
    {
        IdentifierFactory += 1
        return IdentifierFactory
    }
    
    init()
    {
        self.identifier = Card.GetUniqueIdentifier()
    }
}


