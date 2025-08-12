//
//  ContentView.swift
//  Edutaiment
//
//  Created by Leandro Motta Junior on 11/08/25.
//

import SwiftUI

struct ContentView: View {
    
    let numberOfQuestions = [5, 10, 15]
    
    @State private var table = 2
    @State private var questionPicker = 5
    @State private var randomNum = Int.random(in: 1...40)
    @State private var answer = 0
    @State private var score = 0
    @State private var count = 0
    
    @State private var animationValue = 1.0
    
    @State private var showAlert = false
    @State private var showEndAlert = false
    
    @State private var scoreTitle = ""
    @State private var endTitle = ""
    
    var body: some View {
        ZStack {
            List {
                
                Stepper("\(table.formatted()) table", value: $table, in: 2...12, step: 1)
                
                Section("Select the number of questions you want") {
                    Picker("Questions", selection: $questionPicker) {
                        ForEach(numberOfQuestions, id: \.self) { number in
                            Text("\(number)")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Text("\(table) x \(randomNum)")
                
                TextField("", value: $answer, format: .number)
                    .keyboardType(.decimalPad)
            }
            
            VStack(spacing: 20) {
                
                Text("Play: \(count)")
                Text("Score: \(score)")
            
            }
            .font(.title.bold())
            
            VStack {
                Spacer()
                Spacer()
                
                Button("Continue") {
                    
                    checkAnswer(table, randomNum)
                    continueGame()
                }
                .frame(width: 100, height: 50)
                .background(Color(red: 127/255, green: 0, blue: 255/255))
                .foregroundStyle(.white)
                .clipShape(.rect(cornerRadius: 30))
                .animation(.default, value: animationValue)
                .alert(scoreTitle, isPresented: $showAlert) {
                    Button("OK", action: continueGame)
                }
                .alert(endTitle, isPresented: $showEndAlert) {
                    Button("Reset", action: resetGame)
                } message: {
                    Text("Your final score is \(score)")
                }
                
                Spacer()
            }
            
        }
    }
    
    func checkAnswer(_ number1: Int, _ number2: Int) {
        
        let realAnswer = number1 * number2
        
        if realAnswer == answer {
            score += 10
        } else {
            scoreTitle = "Oops! That's not correct"
            showAlert.toggle()
        }
        
        count += 1
        
        if count == questionPicker {
            endTitle = "Game Over"
            showEndAlert.toggle()
        }
    }
    
    func continueGame() {
        randomNum = Int.random(in: 1...40)
        answer = 0
    }
    
    func resetGame() {
        
        count = 0
        score = 0
        randomNum = Int.random(in: 1...40)
        answer = 0
    }
}

#Preview {
    ContentView()
}
