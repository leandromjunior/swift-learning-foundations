//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Leandro Motta Junior on 29/07/25.
//

import SwiftUI

// Day 23
struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .background(.blue)
        .padding()
        .background(.red)
        .padding()
        .background(.green)
        .padding()
        .background(.yellow)
    }
}

struct ConditionalModifiers: View {
    @State private var useRedText = false
    @State private var useRedText2 = false
    var body: some View {
        Button("Hello, world!") {
            useRedText.toggle()
        }
        .foregroundStyle(useRedText ? .red : .blue)
        
        // We could do the following, but it may make our code slower
        
        if useRedText2 {
            Button("Hello, world 2!") {
                useRedText2.toggle()
            }
            .foregroundStyle(.green)
        } else {
            Button("Hello, world 2!") {
                useRedText2.toggle()
            }
            .foregroundStyle(.yellow)
        }
    }
}

struct EnvironmentModifiers : View {
    var body: some View {
        VStack {
            Text("Rossi")
                .font(.largeTitle) // This will override the environment modifier ".font"
                .blur(radius: 0) // Because ".blur" is a regular modifier, we can't disable it by component
            Text("Leo Ortiz")
            Text("Leo Pereira")
            Text("Varela")
            Text("Vina")
        }
        .font(.title)
        .blur(radius: 5)
    }
}

struct ViewsAsProperties: View {
    var motto1: some View { // Computed Property
        Text("Draco Dormiens")
    }
    let motto2 = Text("Nunquam") // Stored Property
    
    //To send multiple views back, it's good to use the following term "@ViewBuilder"
    @ViewBuilder var spells: some View {
        Text("Lumos")
        Text("Obliviate")
    }
    var body: some View {
        motto1
            .foregroundStyle(.red)
        motto2
            .foregroundStyle(.blue)
        
        spells
    }
}

struct NormalModifiers : View {
    var body: some View {
        VStack(spacing: 10) {
            Text("First")
                .font(.largeTitle)
                .padding()
                .foregroundStyle(.white)
                .background(.blue)
                .clipShape(.capsule)
            
            Text("Second")
                .font(.largeTitle)
                .padding()
                .foregroundStyle(.white)
                .background(.blue)
                .clipShape(.capsule)
        }
    }
}

//Instead of the repetitive view above we can make a View Composition (something like a custom view)

struct CapsuleText: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            //.foregroundStyle(.white)
            .background(.blue)
            .clipShape(.capsule)
    }
}

struct ViewComposition: View {
    var body: some View {
        VStack(spacing: 10) {
            CapsuleText(text: "First")
                .foregroundStyle(.white)
            CapsuleText(text: "Second")
                .foregroundStyle(.yellow)
        }
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.white)
            .padding()
            .background(.blue)
            .clipShape(.rect(cornerRadius: 10))
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

struct Watermark: ViewModifier {
    var text: String
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundStyle(.white)
                .padding(5)
                .background(.black)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
}

struct CustomView: View {
    var body: some View {
        Color.yellow
            .frame(width: 300, height: 200)
            .watermarked(with: "Hacking with swift")
        Text("Hello, world!")
            .titleStyle() // With an extension, instead of passing ".modifier(Title())", we can just pass the extension function name
        
    }
}

// Day 24 - The changes will be set on project 1 and 2 files based on what was learned at day 23

#Preview {
    CustomView()
}
