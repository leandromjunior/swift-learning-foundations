//
//  ContentView.swift
//  Memorize
//
//  Created by Leandro Motta Junior on 14/06/25.
//

import SwiftUI

struct ContentView: View {
    var emojis = ["⚽️", "🥅", "🏟️", "🏆", "😘", "❤️", "🎶", "🥶", "🧠", "🧤", "🥳", "🤝", "🎩"]
    @State var cardCount = 6
    
    var body: some View {
        VStack {
            cards
            Spacer()
            cardCountAdjusters
        }
        .padding()
        
    }
    
    var cards: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 90))]) {
                ForEach(emojis[0..<cardCount], id: \.self) { emoji in
                    CardView(content: emoji)
                        .aspectRatio(2/3, contentMode: .fit)
                }
            }
        }
        .foregroundColor(.gray)
    }
    
    var cardCountAdjusters: some View {
        HStack {
            removeCardButton
            Spacer()
            addCardButton
            
        }
        .imageScale(.large)
        .font(.largeTitle)
        
    }
    
    var removeCardButton: some View {
        Button {
            if cardCount > 1 {
                cardCount -= 1
            }
        } label: {
            Image(systemName: "rectangle.stack.badge.minus.fill")
        }
        .disabled(cardCount < 2)
    }
    
    var addCardButton: some View {
        Button {
            if cardCount < emojis.count {
                cardCount += 1
            }
        } label: {
            Image(systemName: "rectangle.stack.badge.plus.fill")
            }
        .disabled(cardCount == emojis.count)
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
