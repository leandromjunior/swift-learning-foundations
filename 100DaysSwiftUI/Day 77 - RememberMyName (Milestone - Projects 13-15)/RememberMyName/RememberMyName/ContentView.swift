//
//  ContentView.swift
//  RememberMyName
//
//  Created by Leandro Motta Junior on 15/10/25.
//

import SwiftUI
import CoreImage
import PhotosUI

struct ContentView: View {
    @State private var pickerItem: PhotosPickerItem?
    @State private var selectedImage: UIImage?
    @State private var people: [Person] = []
    @State private var hasSelectedImage = false
    @State private var personName = ""
    
    let savePath = URL.documentsDirectory.appending(path: "SavedPeople")
    
    var body: some View {
        NavigationStack {
            List(1..<3) { row in
                Text("\(row)")
            }
            .navigationTitle("People")
            .toolbar {
                PhotosPicker(selection: $pickerItem, matching: .images) {
                    Button("New Photo", systemImage: "plus") { }
                }
            }
        }
        .onChange(of: pickerItem) {
            Task {
                if let data = try await pickerItem?.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    selectedImage = uiImage
                    hasImage()
                }
            }
        }
        .sheet(isPresented: $hasSelectedImage) {
            AddView { name in
                addPeople(name: name)
            }
        }
    }
    
    func hasImage() {
        if selectedImage != nil {
            hasSelectedImage = true
        }
    }
    
    func save() {
        do {
            let data = try Data(JSONEncoder().encode(people))
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data")
        }
    }
    
    func addPeople(name: String) {
        guard let image = selectedImage else { return }
        
        let id = UUID()
        let filename = "\(id).jpg"
        
        let imagePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(filename)
        
        if let data = image.jpegData(compressionQuality: 0.8) {
            try? data.write(to: imagePath, options: [.atomic, .completeFileProtection])
        }
        
        let newPerson = Person(id: id, name: name, imageFileName: filename)
        people.append(newPerson)
        
        save()
    }
}

#Preview {
    ContentView()
}
