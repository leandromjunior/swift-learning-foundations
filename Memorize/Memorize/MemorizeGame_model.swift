//
//  MemorizeGame_model.swift
//  Memorize
//
//  Created by Leandro Motta Junior on 22/06/25.
//

import Foundation

struct MemoryGame_model<CardContent> {
    var cards: Array<Card>
    
    func choose(card: Card) {
        
    }
    
    struct Card {
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
    }
    
}
