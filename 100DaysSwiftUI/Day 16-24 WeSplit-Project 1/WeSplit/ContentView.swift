//
//  ContentView.swift
//  WeSplit
//
//  Created by Leandro Motta Junior on 22/07/25.
//

import SwiftUI

// Day 1
struct ContentView: View {
    @State private var tapCount = 0 // The @state term "replaces" the mutating in some swiftUi cases
    @State private var name = ""
    
    let students = ["Harry", "Hermione", "Ron", "None"]
    @State private var selectedStudent = "None"
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Enter your name", text: $name) // The dollar sign means that we are reading and writing the variable 'var name' "at the same time"
                    Text("Hello, \(name)")
                }
                
                Section {
                    Text("Hello World")
                    Text("Hello World")
                    Text("Hello World")
                }
                
                Section {
                    ForEach(0..<3) { number in // This is a closure
                        Text("Row \(number)")
                    }
                }
                
                Section {
                    Picker("Select your student", selection: $selectedStudent) {
                        // 'self' identify every view on the screen uniquely
                        ForEach(students, id: \.self) {student in // This is a closure
                            Text(student)
                        }
                    }
                }
                
                Text("Hello World")
                Text("Hello World")
                
                Section {
                    Button("Tap Count: \(tapCount)") {
                        self.tapCount += 1
                    }
                }
            }
            .navigationTitle("SwiftUi")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// Day 17
struct SecondView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        //Adding the Navigation Stacker, after clicking the picker, the app opens a new screen listing the options. Otherwise, it would show the options in a menu list
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad) // Number Keyboard
                        .focused($amountIsFocused)
                    
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<100) { people in
                            Text("\(people) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("How much tip do you wnat to leave?") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) { tip in
                            Text(tip, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented) //Changes the Picker layout
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit") // Add a title in the page and side by back button after clicking the Picker
            .toolbar { // Insert the Button 'Done"when the TextField is on focus (Hiding the keyboard)
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
       }
    }
}

#Preview {
    //ContentView()
    SecondView()
}
