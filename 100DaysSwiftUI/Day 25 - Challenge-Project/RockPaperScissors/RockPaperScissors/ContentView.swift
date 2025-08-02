//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Leandro Motta Junior on 01/08/25.
//

/* Future implementations
 1 - When the user chooses the same answer (for example, the machine chose paper and the
 user either) the user has to return a message of draw and nothing is scored)
 
 2 - Improve the UI
 */

import SwiftUI

struct ContentView: View {
    let options = ["🪨", "🧻", "✂️"]
    let options2 = ["🧻", "✂️", "🪨"]
    let winLose = ["Win", "Lose"]
    
    @State private var randomWL = Int.random(in: 0...1)
    @State private var roundWL = "" // is going to store the random result of wnLose array
    @State private var randomPos = Int.random(in: 0...2)
    @State private var resultTitle = ""
    @State private var endTitle = ""
    @State private var score = 0
    @State private var count = 0
    @State private var showEnd = false
    @State private var showScore = false
    
    var body: some View {
        ZStack {
            RadialGradient(colors: [.purple, .black], center: .bottom, startRadius: 20, endRadius: 200)
                .ignoresSafeArea()
            VStack(spacing: 20) {
                Text("Rock Paper Scissors")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                Spacer()
                VStack (spacing: 30){
                    Text("I chose \(options[randomPos])")
                    Text("You have to \(winLose[randomWL].uppercased()) this round")
                }
                .foregroundStyle(.white)
                .padding()
                VStack(spacing: 30) {
                    ForEach(0..<3) {pos in
                        Button {
                            buttonLogic(pos)
                        } label: {
                            Text(options2[pos])
                                .padding()
                                .background(.white)
                                .font(.system(size: 30))
                                .clipShape(.capsule)
                        }
                    }
                    
                }
                .alert(resultTitle, isPresented: $showScore) {
                    Button("Continue", action: continueGame)
                } message: {
                    Text("Your current score is \(score)")
                }
                .alert(endTitle, isPresented: $showEnd) {
                    Button("Reset", action: resetGame)
                } message: {
                    Text("Your final score is: \(score)")
                }
                
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.headline.weight(.bold))
                Spacer()
                
            }
            .padding()
        }
    }
    
    func buttonLogic(_ number: Int) {
        count += 1
        roundWL = winLose[randomWL]
        
        if roundWL == "Win" {
            if number == randomPos {
                resultTitle = "Correct"
                score += 1
            } else {
                resultTitle = "Wrong"
                score == 0 ? (score = 0) : (score -= 1)
            }
        } else {
            if number == randomPos {
                resultTitle = "Wrong"
                score == 0 ? (score = 0) : (score -= 1)
            } else {
                resultTitle = "Correct"
                score += 1
            }
        }
        
        showScore = true
        
        if count == 10 {
            endTitle = "Game Over!"
            showEnd = true
        }
        
    }
    
    func continueGame() {
        randomWL = Int.random(in: 0...1)
        randomPos = Int.random(in: 0...2)
        
    }
    
    func resetGame() {
        count = 0
        score = 0
        randomWL = Int.random(in: 0...1)
        randomPos = Int.random(in: 0...2)
    }
    
}

#Preview {
    ContentView()
}
