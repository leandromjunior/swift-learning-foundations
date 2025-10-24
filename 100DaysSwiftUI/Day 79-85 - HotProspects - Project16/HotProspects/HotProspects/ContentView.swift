//
//  ContentView.swift
//  HotProspects
//
//  Created by Leandro Motta Junior on 21/10/25.
//

import SwiftUI

// Letting users select items in a List

struct SelectItemsInList: View {
    let users = ["Tohru", "Yuki", "Kyo", "Momiji"]
    // @State private var selection: String? -> To handle one selection
    @State private var selection = Set<String>() // -> To handle multiple selection
    var body: some View {
        List(users, id: \.self, selection: $selection) { user in
            Text(user)
        }
        
        // To Handle one selection
//        if let selection {
//            Text("You selected \(selection)")
//        }
        
        // To handle multiple selection
        if selection.isEmpty == false {
            Text("You selected \(selection.formatted())")
        }
        
        EditButton() // -> Swift Function
    }
}

// Creating tabs with TabView and tabItem()
struct Tabs: View {
    // With this variable we can change tabs programatically, by tapping a button for example. So we need to use binding ($) and the .tag() modifier
    @State private var selectedTab = "One"
    var body: some View {
        TabView(selection: $selectedTab) {
            Button("Show Tab 2") {
                selectedTab = "Two"
            }
            .tabItem {
                Label("One", systemImage: "star")
            }
            .tag("One")
            
            Text("Tab 2")
                .tabItem {
                    Label("Two", systemImage: "circle")
                }
                .tag("Two")
        }
    }
}

// Swift's Result type
struct ResultType: View {
    @State private var output = ""
    var body: some View {
        Text(output)
            .task {
                await fetchReadingsTask()
            }
    }
    
    func fetchReadings() async {
        do {
            let url = URL(string: "https://hws.dev/readings.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let readings = try JSONDecoder().decode([Double].self, from: data)
            output = "Found \(readings.count) readings"
        } catch {
            print("Download error")
        }
    }
    
    func fetchReadingsTask() async {
        let fetchTask = Task {
            let url = URL(string: "https://hws.dev/readings.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let readings = try JSONDecoder().decode([Double].self, from: data)
            return "Found \(readings.count) readings"
        }
        
        let result = await fetchTask.result
        
        // We can do this
        do {
            output = try result.get()
        } catch {
            output = "Error: \(error.localizedDescription)"
        }
        
        // OR we can do this
        switch result {
        case .success(let str):
            output = str
        case .failure(let error):
            output = "Error: \(error.localizedDescription)"
        }
    }
}

// Controlling image interpolation in SwiftUI
struct ImageInterpolation: View {
    var body: some View {
        Image(.example)
            .interpolation(.none) // Adding this line, the image is not blur anymore
            .resizable()
            .scaledToFit()
            .background(.black)
    }
}

// Creating Context Menus
struct ContextMenus: View {
    @State private var backgroundColor = Color.red
    var body: some View {
        VStack {
            Text("Hello World!")
                .padding()
                .background(backgroundColor)
            Text("Change Color")
                .padding()
                .contextMenu { // Context Menu -> It shows a menu by pressing a component
                    //The role .destructive make the foregroundColor red
                    Button("Red", systemImage: "checkmark.circle.fill", role: .destructive) {
                        backgroundColor = .red
                    }
                    
                    Button("Green") {
                        backgroundColor = .green
                    }
                    
                    Button("Blue") {
                        backgroundColor = .blue
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
    //SelectItemsInList()
    //Tabs()
    //ResultType()
    //ImageInterpolation()
    ContextMenus()
    //ContentView()
}
