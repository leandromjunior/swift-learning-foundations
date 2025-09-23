//
//  ContentView.swift
//  Instafilter
//
//  Created by Leandro Motta Junior on 21/09/25.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

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

// Day 63

// Integratin Core Image with SwiftUI
struct CoreImageView: View {
    @State private var image: Image?
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
        }
        .onAppear(perform: loadImage)
    }
    
    func loadImage() {
        
        //image = Image(.unnamed)
        
        let inputImage = UIImage(resource: .unnamed)
        let beginImage = CIImage(image: inputImage)
        
        let context = CIContext()
        // to change the filter change the .sepiaTone() for .twirlDistortion(), as an example
        let currentFilter = CIFilter.sepiaTone()
        currentFilter.inputImage = beginImage
        //currentFilter.intensity = 1
        
        let amount = 1.0
        
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(amount, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(amount * 200, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(amount * 10, forKey: kCIInputScaleKey)
        }
        
        // get a CIImage from our filter or exit if that fails
        guard let outputImage = currentFilter.outputImage else { return }
        
        // attempt to get a CGImage from our CIImage
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
        
        // convert that to a UIImage
        let UiImage = UIImage(cgImage: cgImage)
        
        // and convert that to a SwiftUI image
        image = Image(uiImage: UiImage)
    }
}

// Showing empty states with ContentUnavailableView
struct ShowingEmptyVIew: View {
    var body: some View {
        ContentUnavailableView("No Snippets", systemImage: "swift", description: Text("You don't have any saved snippets yet."))
    }
}

struct AnotherWayShowingEmptyView: View {
    var body: some View {
        ContentUnavailableView {
            Label("No Snippets", systemImage: "swift")
        } description: {
            Text("You don't have any saved snippets yet.")
        } actions: {
            Button("Create Snnipet") {
                // Create a snippet
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

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
    //ConfirmationDialogView()
    //CoreImageView()
    //ShowingEmptyVIew()
    AnotherWayShowingEmptyView()
    //ContentView()
}
