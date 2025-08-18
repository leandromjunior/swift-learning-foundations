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
    NavigationDestinationView2()
}
