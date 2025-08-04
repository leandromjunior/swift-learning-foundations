//
//  ContentView.swift
//  WordScramble
//
//  Created by Leandro Motta Junior on 04/08/25.
//

import SwiftUI

// Day 29
struct ContentView: View {
    var body: some View {
        List {
            Section("Section 1") {
                Text("Static Row 1")
                Text("Static Row 2")
            }
            
            Section("Section 2") {
                ForEach(0..<5) {
                    Text("Dynamic row \($0)")
                }
            }
            
            Section("Section 3") {
                Text("Static Row 3")
                Text("Static Row 4")
            }
        }
        .listStyle(.grouped)
        
        List(0..<5) {
            Text("Dynamic Row \($0)")
        }
    }
}

struct ListArrayView: View {
    let people = ["Finn", "Leia", "Luke", "Rey"]
    var body: some View {
        List(people, id: \.self) {
            Text($0)
        }
        
        List {
            Text("Static Row")
            
            ForEach(people, id: \.self) {
                Text($0)
            }
            
            Text("Static Row")
        }
    }
}

struct WorkingWithBundleView: View {
    var body: some View {
        if let fileURL = Bundle.main.url(forResource: "some-file", withExtension: "txt") {
            if let fileContents = try? String(contentsOf: fileURL) {
                // We loaded the file into a string
            }
        }
    }
}

struct WorkingWithStrings: View {
    let input = "a b c"
    lazy var letters = input.components(separatedBy: " ")
    
    let input2 = """
                a
                b
                c
                """
    lazy var letters2 = input2.components(separatedBy: "\n")
    lazy var letter = letters.randomElement()
    lazy var trimmed = letter?.trimmingCharacters(in: .whitespacesAndNewlines)
    
    let word = "swift"
    let checker = UITextChecker()
    lazy var range = NSRange(location: 0, length: word.utf16.count)
    lazy var misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
    lazy var allGood = misspelledRange.location == NSNotFound
    
    var body: some View {
        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Hello, world!@*/Text("Hello, world!")/*@END_MENU_TOKEN@*/
    }
}

#Preview {
    ListArrayView()
}
