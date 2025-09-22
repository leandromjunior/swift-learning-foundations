//
//  ContentView.swift
//  Instafilter
//
//  Created by Leandro Motta Junior on 21/09/25.
//

import SwiftUI

// Day 62

//How property wrappers become structs
struct ChangingBlurView: View {
    @State private var blurAmount = 0.0 {
        didSet {
            print("New value is \(blurAmount)")
        }
    }
    
    var body: some View {
        VStack {
            Text("Hello World")
                .blur(radius: blurAmount)
            
            Slider(value: $blurAmount, in: 0...20) //This does not make the value of blueAmount change
            
            Button("Random Blur") {
                blurAmount = Double.random(in: 0...20)
            }
        }
    }
}

//Responding to State changes using onChange()
struct onChangeView: View {
    @State private var blurAmount = 0.0
    var body: some View {
        VStack {
            Text("Hello World")
                .blur(radius: blurAmount)
            
            // With the method onChange the value of blurAmount changes explicitly
            Slider(value: $blurAmount, in: 0...20)
                .onChange(of: blurAmount) { oldValue, newValue in
                    print("New value is \(newValue)")
                }
        }
    }
}


//Showing multiple options with confirmationDialog()
struct ConfirmationDialogView: View {
    @State private var showingConfirmation = false
    @State private var backgroundColor = Color.white
    
    var body: some View {
        Button("Hello World") {
            showingConfirmation.toggle()
        }
        .frame(width: 300, height: 300)
        .background(backgroundColor)
        .confirmationDialog("Change Background", isPresented: $showingConfirmation) {
            Button("Red") { backgroundColor = .red }
            Button("Green") { backgroundColor = .green }
            Button("Blue") { backgroundColor = .blue }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Select a New Color")
        }
    }
}

// Day x

//App
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
    //ChangingBlurView()
    //onChangeView()
    ConfirmationDialogView()
    //ContentView()
}
