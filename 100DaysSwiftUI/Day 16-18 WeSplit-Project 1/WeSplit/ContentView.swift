//
//  ContentView.swift
//  WeSplit
//
//  Created by Leandro Motta Junior on 22/07/25.
//

import SwiftUI

// Day 16
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
                    .pickerStyle(.navigationLink) //Adding the Navigation Stacker plus this pickerStyle, after clicking the picker, the app opens a new screen listing the options. Otherwise, it would show the options in a menu list.
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

// Day 18 - Mini Challenge

/*
 1 - Add a header to the third section, saying "Amount per person"
 2 - Add another section showing the total amount for the check - i.e., the original amount plus tip value, without dividing by the number of people.
 3 - Change the tip percentage picker to show a new screen rather than using a segmented control, and give it a wider range of options - everything from 0% to 100%. Tip: use the range 0..<101 for your range rather than a fixed array.
 */
struct ChallengeView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var totalAmount: Double {
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        
        return grandTotal
    }
    var body: some View {
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
                        ForEach(0..<101) { tip in
                            Text(tip, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }

                Section("Amount per person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                Section ("Total Amount") {
                    Text(totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
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
    ChallengeView()
}
