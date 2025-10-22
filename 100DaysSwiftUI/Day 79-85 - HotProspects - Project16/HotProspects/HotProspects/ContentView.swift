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
    Tabs()
    //ContentView()
}
