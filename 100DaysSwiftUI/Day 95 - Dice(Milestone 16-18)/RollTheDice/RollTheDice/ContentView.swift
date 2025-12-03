//
//  ContentView.swift
//  RollTheDice
//
//  Created by Leandro Motta Junior on 27/11/25.
//

import SwiftUI

struct ContentView: View {
    @State private var numbers = Numbers()
    let faces = [4, 6, 8, 10, 20, 100]
    @State private var selectedFace = 4
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Form {
                        Picker("Dice", selection: $selectedFace) {
                            ForEach(faces, id: \.self) {face in
                                Text("\(face) faced")
                            }
                        }
                    }
                }
                
                VStack {
                    Text("\(randomizeNumber(for: selectedFace))")
                }
                
                HStack {
                    ForEach($numbers.numbers) { $i in
                        Text("\(i.number)")
                    }
                }
            }
        }
    }
    
    func randomizeNumber(for value: Int) -> Int {
        return Int.random(in: 1...value)
    }
}

#Preview {
    ContentView()
}
