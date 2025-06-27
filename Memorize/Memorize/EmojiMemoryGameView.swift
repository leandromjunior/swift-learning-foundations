//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Leandro Motta Junior on 14/06/25.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    var viewModel: EmojiMemoryGame = EmojiMemoryGame()
    
    var body: some View {
        VStack {
            cards
        }
        .padding()
        
    }
    
    var cards: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 90))]) {
                ForEach(viewModel.cards.indices, id: \.self) { index in
                    CardView(card: viewModel.cards[index])
                        .aspectRatio(2/3, contentMode: .fit)
                }
            }
        }
        .foregroundColor(.gray)
    }
    
}

struct CardView: View {
    let card: MemorizeGame_model<String>.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp{
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
    }
}











#Preview {
    EmojiMemoryGameView()
}
