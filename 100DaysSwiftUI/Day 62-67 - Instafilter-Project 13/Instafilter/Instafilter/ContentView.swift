//
//  ContentView.swift
//  Instafilter
//
//  Created by Leandro Motta Junior on 21/09/25.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI
import StoreKit

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

// Day 64

// Loading photos from the user's photo library
struct LoadingPhotosView: View {
    @State private var pickerItem: PhotosPickerItem?
    @State private var selectedImage: Image?
    
    var body: some View {
        VStack {
            PhotosPicker("Select a picture", selection: $pickerItem, matching: .images)
            
            selectedImage?
                .resizable()
                .scaledToFit()
        }
        .onChange(of: pickerItem) {
            Task {
                selectedImage = try await pickerItem?.loadTransferable(type: Image.self)
            }
        }
    }
}

struct LoadingMoreThanOnePhoto: View {
    @State private var pickerItems = [PhotosPickerItem]()
    @State private var selectedImages = [Image]()
    
    var body: some View {
        VStack {
            // This line let the user select an image with no restriction
            //PhotosPicker("Select Images", selection: $pickerItems, matching: .images)
            
            // This line restrict the user to change 3 photos at maximum
            /*PhotosPicker(selection: $pickerItems, maxSelectionCount: 3, matching: .images) {
                Label("Select a picture", systemImage: "photo")
            } */
            
            // This line don't let the user choose a screenshot as image
            PhotosPicker(selection: $pickerItems, maxSelectionCount: 3, matching: .any(of: [.images, .not(.screenshots)])) {
                Label("Select a picture", systemImage: "photo")
            }
            
            ScrollView {
                ForEach(0..<selectedImages.count, id: \.self) { i in
                    selectedImages[i]
                        .resizable()
                        .scaledToFit()
                }
            }
        }
        .onChange(of: pickerItems) {
            Task {
                selectedImages.removeAll()
                
                for item in pickerItems {
                    if let loadedImage = try await item.loadTransferable(type: Image.self) {
                        selectedImages.append(loadedImage)
                    }
                }
            }
        }
    }
}

// How to let the user share content with ShareLink
struct ShareLinkView: View {
    var body: some View {
        // Simple ShareLink
        //ShareLink(item: URL(string: "https://www.google.com")!)
        
        // ShareLink with a subject
        ShareLink(item: URL(string: "https://www.google.com")!, subject: Text("Search for anything here"), message: Text("Try searching for a subject that you love!"))
        
        // Customizing the button
        ShareLink(item: URL(string: "https://www.google.com")!) {
            Label("Let's make google search famous again", systemImage: "swift")
        }
        
        //providing a preview inside the share button
        let example = Image(.unnamed)
        
        ShareLink(item: example, preview: SharePreview("Singapore Airport", image: example)) {
            Label("Click to share", systemImage: "airplane")
        }
    }
}

//App
struct ContentView: View {
    @State private var processedImage: Image?
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 0.5
    
    @State private var selectedItem: PhotosPickerItem? //optional because we don't have a value to display by default
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    @State private var showingFilter = false
    
    @AppStorage("filterCount") var filterCount = 0
    @Environment(\.requestReview) var requestReview
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                PhotosPicker(selection: $selectedItem) {
                    if let processedImage {
                        processedImage
                            .resizable()
                            .scaledToFit()
                    } else {
                        ContentUnavailableView("No picture", systemImage: "photo.badge.plus", description: Text("Tap to import a photo"))
                    }
                }
                .buttonStyle(.plain)
                .onChange(of: selectedItem, loadImage)
                
                Spacer()
                
                HStack {
                    //With the inclusion of this condition asked in the challenge 1, the slider will be shown only if there is a image selected
                    if processedImage != nil {
                        Text("Intensity")
                        Slider(value: $filterIntensity)
                            .onChange(of: filterIntensity, applyProcessing)
                        
                        Text("Radius")
                        Slider(value: $filterRadius)
                            .onChange(of: filterRadius, applyProcessing)
                    }
                }
                .padding(.vertical)
                
                HStack {
                    if let processedImage {
                        Button("Change Filter", action: changeFilter)
                        
                        Spacer()
                        
                        ShareLink(item: processedImage, preview: SharePreview("Instafilter image", image: processedImage))
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .confirmationDialog("Select a filter", isPresented: $showingFilter) {
                Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                Button("Edges") { setFilter(CIFilter.edges()) }
                Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                Button("Vignette") { setFilter(CIFilter.vignette()) }
                Button("Distortion") { setFilter(CIFilter.bumpDistortion()) }
                Button("Cancel", role: .cancel) { }
            }
        }
    }
    
    func changeFilter() {
        showingFilter = true
    }
    
    func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
            guard let inputImage = UIImage(data: imageData) else { return }
            
            let beginImage = CIImage(image: inputImage)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            applyProcessing()
        }
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterRadius * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey)}
        
        guard let outputImage = currentFilter.outputImage else { return }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
        
        let uiImage = UIImage(cgImage: cgImage)
        processedImage = Image(uiImage: uiImage)
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
        
        filterCount += 1
        
        if filterCount >= 20 {
            requestReview()
        }
    }
}

#Preview {
    //ChangingBlurView()
    //onChangeView()
    //ConfirmationDialogView()
    //CoreImageView()
    //ShowingEmptyVIew()
    //AnotherWayShowingEmptyView()
    //LoadingPhotosView()
    //LoadingMoreThanOnePhoto()
    //ShareLinkView()
    ContentView()
}
