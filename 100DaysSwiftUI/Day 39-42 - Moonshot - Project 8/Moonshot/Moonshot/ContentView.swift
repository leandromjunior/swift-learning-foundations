//
//  ContentView.swift
//  Moonshot
//
//  Created by Leandro Motta Junior on 14/08/25.
//

import SwiftUI

struct ImageManipulationView: View {
    var body: some View {
        Image(.golden)
            .resizable()
            .scaledToFit()
            .containerRelativeFrame(.horizontal) { size, axis in
                size * 0.8
            }
    }
}

struct ScrollScreenView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ForEach(0..<100) { row in
                    Text("Item: \(row)")
                        .font(.title)
                }
            }
            .frame(maxWidth: .infinity) // Was added to fill the whole screen, the VStack fill only what is needed due to the size of the text, when adding this modifier wwe can scroll by touching any part of the screen
        }
    }
}

// Using the LazyVstack instead of VStack -> This can be used in exactly same way as regular stacks but will load their content on-demand (they will not create views until they are actually shown, and so minimize the amount of system resources being used). Furthermore, it occupies the whole screen by default, so the .frame modifier is not necessary in this case anymore.
struct ScrollScreenView2: View {
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                ForEach(0..<100) { row in
                    Text("Item: \(row)")
                        .font(.title)
                }
            }
        }
    }
}

// The LazyHStack works as the same way as LazyVstack, but we have to pass the .horizontal parameter inside the scrollview.
struct ScrollScreenView3: View {
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 10) {
                ForEach(0..<100) { row in
                    Text("Item: \(row)")
                        .font(.title)
                }
            }
        }
    }
}

struct NavigationLinkView: View {
    var body: some View {
        NavigationStack {
            NavigationLink("Tap Me") {
                Text("Detail View")
            }
            .navigationTitle("SwiftUI")
        }
    }
}

struct NavigationLinkView2: View {
    var body: some View {
        NavigationStack {
            NavigationLink() {
                Text("Detail View")
            } label: {
                VStack {
                    Text("This is the label")
                    Text("So is this")
                    Image(systemName: "face.smiling")
                }
                .font(.largeTitle)
            }
            .navigationTitle("SwiftUI")
        }
    }
}

// Most used with navigationlink
struct NavigationLinkView3: View {
    var body: some View {
        NavigationStack {
            List(0..<100) { row in
                NavigationLink("Row \(row)") {
                    Text("Detail View")
                }
            }
            .navigationTitle("SwiftUI")
        }
    }
}

// Hierarchical Codable Data

struct User: Codable {
    let name: String
    let address: Address
}

struct Address: Codable {
    let street: String
    let city: String
}

struct HierarchicalCodableData: View {
    var body: some View {
        Button("Decode JSON") {
            let input = """
            {
                "name": "Post Malone",
                "address": {
                    "street": "555, Post Malone Avenue",
                    "city": "Austin"
                }
            }
            """
            
            let data = Data(input.utf8)
            let decoder = JSONDecoder()
            
            if let user = try? decoder.decode(User.self, from: data) {
                print(user.address.street)
            }
        }
    }
}

// Scrolling fixed grid view

struct ScrollingVerticalGridView: View {
    let layout = [
        GridItem(.fixed(80)),
        GridItem(.fixed(80)),
        GridItem(.fixed(80))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: layout) {
                ForEach(0..<1000) { column in
                    Text("Item \(column)")
                }
            }
        }
    }
}

// Scrolling Adaptive Grid View

struct ScrollingAdaptiveGridView: View {
    let layout = [
        GridItem(.adaptive(minimum: 80, maximum: 120)), //This adapts to any iPhone screen size
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: layout) {
                ForEach(0..<1000) { column in
                    Text("Item \(column)")
                }
            }
        }
    }
}

// Scrolling Horizontal Grid View

struct ScrollingHorizontalGridView: View {
    let layout = [
        GridItem(.adaptive(minimum: 80, maximum: 120)), //This adapts to any iPhone screen size
    ]
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: layout) {
                ForEach(0..<1000) { row in
                    Text("Item \(row)")
                }
            }
        }
    }
}

// Day 40

struct ContentView: View {
    // Because of the change in the func decode (Bundle-Dccodable) i had to change this line of code inserting the [String: Atronaut] type annotation
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        //        Text(String(astronauts.count)) - Was just to test if the decoder was OK
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(missions) { mission in
                        NavigationLink {
                            Text("Detal View")
                        } label: {
                            VStack {
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .padding() // makes the image more centralized inside the "card"
                                
                                VStack {
                                    Text(mission.displayName)
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                    Text(mission.formattedLaunchDate)
                                        .font(.caption)
                                        .foregroundStyle(.white.opacity(0.5))
                                }
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(.lightBackground)
                            }
                        }
                        .clipShape(.rect(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackground) // makes a line around the image
                        )
                    }
                }
                .padding([.horizontal, .bottom])
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark) // It makes the Moonshot title white
        }
    }
}

#Preview {
    ContentView()
}
