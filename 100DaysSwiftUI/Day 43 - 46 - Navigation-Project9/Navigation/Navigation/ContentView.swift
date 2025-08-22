//
//  ContentView.swift
//  Navigation
//
//  Created by Leandro Motta Junior on 18/08/25.
//

import SwiftUI

// Day 43
struct NavigationDestinationView: View {
    var body: some View {
        NavigationStack {
            List(0..<100) { i in
                NavigationLink("Select \(i)", value: i)
            }
            .navigationDestination(for: Int.self) { selection in
                Text("You selected \(selection)")
            }
        }
    }
}

// Using Hashable protocol
struct Student: Hashable {
    var id = UUID()
    var name: String
    var age: Int
}

struct NavigationDestinationView2: View {
    var body: some View {
        NavigationStack {
            List(0..<100) { i in
                NavigationLink("Select \(i)", value: i)
            }
            .navigationDestination(for: Student.self) { student in
                Text("You selected \(student.name)")
            }
        }
    }
}

// Day 44

//Programmatic navigation with NavigationStack
struct ProgrammaticNavigationView: View {
    @State private var path = [Int]()
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Button("Show 32") {
                    path = [32]
                }
                
                Button("Show 64") {
                    path.append(64)
                }
                
                Button("Show 32 then 64") {
                    path = [32, 64]
                }
            }
            .navigationDestination(for: Int.self) { selection in
                Text("You selected \(selection)")
            }
        }
    }
}

// Navigatin to different data types using NavigationPath
struct NavigationPathView: View {
    var body: some View {
        NavigationStack {
            List {
                ForEach(0..<5) { i in
                    NavigationLink("Select Number: \(i)", value: i)
                }
                
                ForEach(0..<5) { i in
                    NavigationLink("Select String: \(i)", value: String(i))
                }
            }
            .navigationDestination(for: Int.self) { selection in
                Text("You selected the number \(selection)")
            }
            .navigationDestination(for: String.self) { selection in
                Text("You selected the string \(selection)")
            }
        }
    }
}

struct NavigationPathView2: View {
    // Different from the code of "ProgrammaticNavigationView", now we might have integers OR strings so we can't use a simple array any more
    @State private var path = NavigationPath()
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(0..<5) { i in
                    NavigationLink("Select Number: \(i)", value: i)
                }
                
                ForEach(0..<5) { i in
                    NavigationLink("Select String: \(i)", value: String(i))
                }
            }
            .toolbar {
                Button("Push 556") {
                    path.append(556)
                }
                
                Button("Push Hello") {
                    path.append("Hello")
                }
            }
            .navigationDestination(for: Int.self) { selection in
                Text("You selected the number \(selection)")
            }
            .navigationDestination(for: String.self) { selection in
                Text("You selected the string \(selection)")
            }
        }
    }
}

//How to make a NavigationStack return to its root view programmatically
struct DetailView: View {
    var number: Int
    var body: some View {
        NavigationLink("Go to random number", value: Int.random(in: 1...1000))
            .navigationTitle("Number: \(number)")
    }
}

struct NormalProgrammaticView: View {
    @State private var path = [Int]()
    
    var body: some View {
        NavigationStack(path: $path) {
            DetailView(number: 0)
                .navigationDestination(for: Int.self) { i in
                    DetailView(number: i)
                }
        }
    }
}

struct DetailView2: View {
    var number: Int
    @Binding var DetailViewPath: [Int]
    
    var body: some View {
        NavigationLink("Go to random number", value: Int.random(in: 1...1000))
            .navigationTitle("Number: \(number)")
            .toolbar {
                Button("Home") {
                    DetailViewPath.removeAll()
                }
            }
    }
}

struct RootProgrammaticView: View {
    @State private var path = [Int]()
    
    var body: some View {
        NavigationStack(path: $path) {
            DetailView2(number: 0, DetailViewPath: $path)
                .navigationDestination(for: Int.self) { i in
                    DetailView2(number: i, DetailViewPath: $path)
                }
        }
    }
}

// Now, the exact same code above but in case of we want to use the NavigationPath()
struct DetailView3: View {
    var number: Int
    @Binding var DetailViewPath: NavigationPath
    
    var body: some View {
        NavigationLink("Go to random number", value: Int.random(in: 1...1000))
            .navigationTitle("Number: \(number)")
            .toolbar {
                Button("Home") {
                    DetailViewPath = NavigationPath()
                }
            }
    }
}

struct RootProgrammaticNavigationPathView: View {
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            DetailView3(number: 0, DetailViewPath: $path)
                .navigationDestination(for: Int.self) { i in
                    DetailView3(number: i, DetailViewPath: $path)
                }
        }
    }
}

// How to save NavigationStack paths using codable
@Observable
class PathStore {
    var path: [Int] {
        didSet {
            save()
        }
    }
    
    private let savePath = URL.documentsDirectory.appending(path: "savedPath")
    
    init() {
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode([Int].self, from: data) {
                path = decoded
                return
            }
        }
        
        path = []
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(path)
            try data.write(to: savePath)
        } catch {
            print("Failed to save navigation data")
        }
    }
}

// The same code above but in caso of we want to use NavigationPath
@Observable
class PathStoreNavigationPath {
    var path: NavigationPath {
        didSet {
            save()
        }
    }
    
    private let savePath = URL.documentsDirectory.appending(path: "savedPath")
    
    init() {
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode(NavigationPath.CodableRepresentation.self, from: data) {
                path = NavigationPath(decoded)
                return
            }
        }
        
        path = NavigationPath()
    }
    
    func save() {
        guard let representation = path.codable else { return }
        
        do {
            let data = try JSONEncoder().encode(representation)
            try data.write(to: savePath)
        } catch {
            print("Failed to save navigation data")
        }
    }
}

struct DetailView4: View {
    var number: Int
    
    var body: some View {
        NavigationLink("Go to random number", value: Int.random(in: 1...1000))
            .navigationTitle("Number: \(number)")
    }
}

// Now when we close the app and reopen it, we are in the same page we were at
struct SavingNavigationPathView: View {
    @State private var pathStore = PathStoreNavigationPath()
    
    var body: some View {
        NavigationStack(path: $pathStore.path) {
            DetailView4(number: 0)
                .navigationDestination(for: Int.self) { i in
                    DetailView4(number: i)
                }
        }
    }
}

// Day 45

// Customizing the navigation bar appearence
struct NavigationBarCustomView: View {
    var body: some View {
        NavigationStack {
            List(0..<100) { i in
                Text("Row \(i)")
            }
            .navigationTitle("Title goes here")
            .navigationBarTitleDisplayMode(.inline) // This center the title
            .toolbarBackground(.blue) // When the user scrolls, the navigationbar turns blue
            .toolbarColorScheme(.dark) // Makes the title "foregroundstyle" white when scrolled
            .toolbar(.hidden, for: .navigationBar) // Hide the navigation bar
        }
    }
}

// Placing toolbar buttons in exact locations
struct ButtonsLocationsView: View {
    var body: some View {
        NavigationStack {
            Text("Hello World")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Tap Me") {
                            // some code
                        }
                    }
                }
        }
    }
}

/*
 usually it's better to use one of the semantic options – placement that have specific meaning, rather than relying just on their location. These include:

 .confirmationAction, when you want users to agree to something, such as agreeing to terms of service.
 
 .destructiveAction, when the user needs to make a choice to destroy whatever it is they are working with, such as confirming they want to remove some data they created.
 
 .cancellationAction, when the user needs to back out of changes they have made, such as discarding changes they have made.
 
 .navigation, which is used for buttons that make the user move between data, such as going back and forward in a web browser.
 */

struct TwoButtonsLocationsView: View {
    var body: some View {
        NavigationStack {
            Text("Hello World")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Tap Me") {
                            // some code
                        }
                    }
                    // This places two buttons in the navigation bar (side by side)
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Tap Me") {
                            // some code
                        }
                    }
                }
        }
    }
}

// The code below makes the same as the code above, but in some codeless way. This is useful when we are aligning two buttons in a same position (leading, trailing, etc.)
struct GroupButtonsLocationsView: View {
    var body: some View {
        NavigationStack {
            Text("Hello World")
                .toolbar {
                    ToolbarItemGroup(placement: .topBarLeading) {
                        Button("Tap Me") {
                            // some code
                        }
                        
                        Button("Other tap me") {
                            // some code
                        }
                    }
                }
        }
    }
}

// Making the navigation title editable

struct EditableNavigationTitle: View {
    @State private var title = "SwiftUI"
    var body: some View {
        NavigationStack {
            Text("Hello, world!")
                .navigationTitle($title)
                .navigationBarTitleDisplayMode(.inline)
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
    EditableNavigationTitle()
}
