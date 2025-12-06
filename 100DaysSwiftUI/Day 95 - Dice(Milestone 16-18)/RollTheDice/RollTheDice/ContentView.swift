//
//  ContentView.swift
//  RollTheDice
//
//  Created by Leandro Motta Junior on 27/11/25.
//

import SwiftUI

struct ContentView: View {
    @State private var numbersList = Numbers()
    let faces = [4, 6, 8, 10, 20, 100]
    @State private var selectedFace = 4
    @State private var isPressed = false
    @State private var randomNumber = 0
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
                    
                    if isPressed {
                        Text("\(randomNumber)")
                            .font(.title)
                            .padding()
                    }
                    
                    Button("Play") {
                        isPressed = true
                        randomNumber = randomizeNumber(for: selectedFace)
                        let chosenNumber = Number(id: UUID(), number: randomNumber)
                        numbersList.numbers.append(chosenNumber)
                    }
                    .padding(.top)
                    
                    Button("Clean") {
                        isPressed = false
                    }
                    .disabled(isPressed == false)
                    
                }
                
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach($numbersList.numbers) { $i in
                                Text("\(i.number)")
                                    .font(.title2)
                            }
                        }
                    }
                }
                .padding(.top, 250)
                .padding()
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
