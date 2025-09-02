//
//  ContentView.swift
//  Bookworm
//
//  Created by Leandro Motta Junior on 01/09/25.
//

import SwiftUI
import SwiftData

// Day 53
// Creating a custom component with @Binding

struct PushButton: View {
    let title: String
    @Binding var isOn: Bool
    
    var onColors = [Color.red, Color.yellow]
    var offColors = [Color(white: 0.6), Color(white: 0.4)]
    var body: some View {
        Button(title) {
            isOn.toggle()
        }
        .padding()
        .background(LinearGradient(colors: isOn ? onColors : offColors, startPoint: .top, endPoint: .bottom))
        .foregroundStyle(.white)
        .clipShape(.capsule)
        .shadow(radius: isOn ? 0 : 5)
    }
}

struct CreatingComponentWithBindindView: View {
    @State private var rememberMe = false
    var body: some View {
        VStack {
            PushButton(title: "Remember Me", isOn: $rememberMe)
            Text(rememberMe ? "On" : "Off")
        }
    }
}

// Accepting multi-line text input with TextEditor
struct TextEditorView: View {
    // The AppStorage is not designed to store secure info like username or password
    @AppStorage("notes") private var notes = ""
    
    var body: some View {
        NavigationStack {
            TextEditor(text: $notes) //The behaviour is like a Notes app
                .navigationTitle("Notes")
                .padding()
        }
    }
}

struct TextEditorView2: View {
    @AppStorage("notes") private var notes = ""
    
    var body: some View {
        NavigationStack {
            TextField("Enter the text", text: $notes, axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .navigationTitle("Notes")
                .padding()
        }
    }
}

// Introduction to SwiftData and SwiftUI
struct StudentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var students: [Student]
    var body: some View {
        NavigationStack {
            List(students) { student in
                Text(student.name)
            }
            .navigationTitle("Classroom")
            .toolbar {
                Button("Add") {
                    let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
                    let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]
                    
                    let chosenFirst = firstNames.randomElement()!
                    let chosenLast = lastNames.randomElement()!
                    
                    let student = Student(id: UUID(), name: "\(chosenFirst) \(chosenLast)")
                    
                    modelContext.insert(student)
                }
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    StudentView()
}
