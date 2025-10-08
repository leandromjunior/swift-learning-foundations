//
//  ContentView.swift
//  AccessibilitySandBox
//
//  Created by Leandro Motta Junior on 08/10/25.
//

import SwiftUI

// Identifying views with useful labels

struct IdentifyingViews: View {
    let pictures = [
        "ales-krivec-15949",
        "galina-n-189483",
        "kevin-horstmann-141705",
        "nicolas-tissot-335096"
    ]
    
    @State private var selectedPictures = Int.random(in: 0...3)
    
    let labels = [
        "Tulips",
        "Frozen tree buds",
        "Sunflowers",
        "Fireworks",
    ]
    
    var body: some View {
        Button {
            selectedPictures = Int.random(in: 0...3)
        } label: {
            Image(pictures[selectedPictures])
                .resizable()
                .scaledToFit()
        }
        .accessibilityLabel(labels[selectedPictures]) //Control the VoiceOver reads
    }
}

// Hiding and grouping accessibility data
struct HidingAndGroupingAccessibilityData: View {
    var body: some View {
        //tells SwiftUI it should be ignored by VoiceOver.
        Image(.character)
            .accessibilityHidden(true)
    }
}

struct HidingAndGroupingAccessibilityData2: View {
    var body: some View {
        VStack {
            Text("Your score is")
            Text("1000")
                .font(.title)
        }
       // .accessibilityElement(children: .combine) // this will cause both text views to be read together, with a short pause between them
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Your score is 1000")
    }
}

// Reading the value of controls
struct ReadingValueOfControls: View {
    @State private var value = 10
    
    var body: some View {
        VStack {
            Text("Value \(value)")
            
            Button("Increment") {
                value += 1
            }
            
            Button("Decrement") {
                value -= 1
            }
        }
        .accessibilityElement()
        .accessibilityLabel("Value")
        .accessibilityValue(String(value))
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .increment:
                value += 1
            case .decrement:
                value -= 1
            default:
                print("Not handled.")
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
    //IdentifyingViews()
    //HidingAndGroupingAccessibilityData()
    //HidingAndGroupingAccessibilityData2()
    ReadingValueOfControls()
    //ContentView()
}
