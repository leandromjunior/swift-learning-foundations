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
    var body: some View {
        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Hello, world!@*/Text("Hello, world!")/*@END_MENU_TOKEN@*/
    }
}

#Preview {
    //ContentView()
    SecondView()
}
