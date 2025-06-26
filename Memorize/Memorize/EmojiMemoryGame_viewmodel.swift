//
//  EmojiMemoryGame_viewmodel.swift
//  Memorize
//
//  Created by Leandro Motta Junior on 22/06/25.
//

import SwiftUI

class EmojiMemoryGame {
    private var model = MemorizeGame_model(numberOfPairsOfCards: 4, cardContentFactory: { (index: Int) -> String in
        return ["⚽️", "🥅", "🏟️", "🏆", "😘", "❤️", "🎶", "🥶", "🧠", "🧤", "🥳", "🤝", "🎩"][index]
    })
    
    var cards: Array<MemorizeGame_model<String>.Card> {
        return model.cards
    }
    
    func choose(_ card: MemorizeGame_model<String>.Card) {
        model.choose(card)
    }
}
