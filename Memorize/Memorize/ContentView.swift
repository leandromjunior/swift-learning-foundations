//
//  ContentView.swift
//  Memorize
//
//  Created by Leandro Motta Junior on 14/06/25.
//

import SwiftUI

struct ContentView: View {
    var emojis = ["⚽️", "🥅", "🏟️", "🏆", "😘", "❤️", "🎶", "🥶", "🧠", "🧤"]
    @State var emojiCount = 6
    
    var body: some View {
        VStack{
            HStack {
                LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
                    ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
                        CardView(content: emoji)
                    }
                }
            }
            .foregroundColor(.gray)
            Spacer()
            HStack {
                removeCardButton
                Spacer()
                addCardButton
                
            }
            .font(.largeTitle)
            .padding(.horizontal)
        }
        .padding(.horizontal)
        
        
    }
    
    var removeCardButton: some View {
        Button {
            if emojiCount > 1 {
                emojiCount -= 1
            }
        } label: {
            Image(systemName: "minus.rectangle.portrait")
        }
    }
    
    var addCardButton: some View {
        Button {
            if emojiCount < emojis.count {
                emojiCount += 1
            }
        } label: {
            Image(systemName: "plus.rectangle.portrait")
            }
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
                shape.stroke(lineWidth: 3)
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
