//
//  ContentView.swift
//  Edutaiment
//
//  Created by Leandro Motta Junior on 11/08/25.
//

import SwiftUI

struct ContentView: View {
    @State private var table = 2
    @State private var questionPicker = 5
    @State private var randomNum = Int.random(in: 1...40)
    @State private var answer = 0
    @State private var showAlert = false
    @State private var score = 0
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    @State private var count = 0
    
    @State private var animationValue = 1.0
    
    
    let numberOfQuestions = [5, 10, 15]
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
            
            VStack {
                Button("Continue") {
                    
                    checkAnswer(table, randomNum)
                }
                .frame(width: 100, height: 50)
                .background(Color(red: 127/255, green: 0, blue: 255/255))
                .foregroundStyle(.white)
                .clipShape(.rect(cornerRadius: 30))
                .animation(.default, value: animationValue)
                .alert(scoreTitle, isPresented: $showAlert) {
                    Button("OK", action: continueGame)
                }
            }
        }
    }
    
    func checkAnswer(_ number1: Int, _ number2: Int) {
        
        let realAnswer = number1 * number2
        
        if realAnswer == answer {
            scoreTitle = "Well Done!"
            score += 10
        } else {
            scoreTitle = "Oops! That's not right"
        }
        
        showAlert.toggle()
    }
    
    func continueGame() {
        randomNum = Int.random(in: 1...40)
        answer = 0
    }
}

#Preview {
    ContentView()
}
