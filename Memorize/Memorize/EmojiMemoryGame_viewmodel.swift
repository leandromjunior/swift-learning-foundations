//
//  EmojiMemoryGame_viewmodel.swift
//  Memorize
//
//  Created by Leandro Motta Junior on 22/06/25.
//

import SwiftUI

class EmojiMemoryGame {
    private static let emojis = ["⚽️", "🥅", "🏟️", "🏆", "😘", "❤️", "🎶", "🥶", "🧠", "🧤", "🥳", "🤝", "🎩"]
    
    private static func createMemoryGame() -> MemorizeGame_model<String> {
        return MemorizeGame_model(numberOfPairsOfCards: 4, cardContentFactory: { (pairIndex: Int) in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "😰"
            }
        })
    }
    
    private var model = createMemoryGame()
    
    var cards: Array<MemorizeGame_model<String>.Card> {
        return model.cards
    }
    
    func choose(_ card: MemorizeGame_model<String>.Card) {
        model.choose(card)
    }
}
