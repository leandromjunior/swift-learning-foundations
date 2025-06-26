//
//  ContentView.swift
//  Memorize
//
//  Created by Leandro Motta Junior on 14/06/25.
//

import SwiftUI

struct ContentView: View {
    var viewModel: EmojiMemoryGame
    var emojis = ["⚽️", "🥅", "🏟️", "🏆", "😘", "❤️", "🎶", "🥶", "🧠", "🧤", "🥳", "🤝", "🎩"]
    
    var body: some View {
        VStack {
            cards
        }
        .padding()
        
    }
    
    var cards: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 90))]) {
                ForEach(emojis.indices, id: \.self) { index in
                    CardView(content: emojis[index])
                        .aspectRatio(2/3, contentMode: .fit)
                }
            }
        }
        .foregroundColor(.gray)
    }
    
}

struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = true
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp{
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}











#Preview {
    ContentView()
}
