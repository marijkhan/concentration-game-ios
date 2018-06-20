//
//  Card.swift
//  Concentration
//
//  Created by Marij on 13/05/2018.
//  Copyright © 2018 Marij. All rights reserved.
//

import Foundation

struct Card
{
    var isMatched = false
    var isFaceUp = false
    var identifier: Int
    
    static var IdentifierFactory = 0
    
    static func GetUniqueIdentifier() -> Int
    {
        IdentifierFactory += 1
        return IdentifierFactory
    }
    
    init()
    {
        self.identifier = Card.GetUniqueIdentifier()
    }
}


