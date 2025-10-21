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
    
    @State private var viewModel = ViewModel()
    
    let savePath = URL.documentsDirectory.appending(path: "SavedPeople")
    
    var body: some View {
        NavigationStack {
            List(viewModel.people.sorted()) { person in
                
                HStack {
                    if let image = viewModel.loadImage(for: person) {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                    }
                    
                    Text("\(person.name)")
                        .padding(.leading)
                }
            }
            .navigationTitle("People")
            .toolbar {
                PhotosPicker(selection: $viewModel.pickerItem, matching: .images) {
                    Button("New Photo", systemImage: "plus") { }
                }
            }
//            .onAppear {
//                people = viewModel.loadPeople()
//            }
        }
        .onChange(of: viewModel.pickerItem) {
            Task {
                if let data = try await viewModel.pickerItem?.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    viewModel.selectedImage = uiImage
                    viewModel.hasSelectedImage = true
                }
            }
        }
        .sheet(isPresented: $viewModel.hasSelectedImage) {
            AddView { name in
                viewModel.addPeople(name: name)
            }
        }
    }
    
//    func save() {
//        do {
//            let data = try Data(JSONEncoder().encode(people))
//            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
//        } catch {
//            print("Unable to save data")
//        }
//    }
    
//    func addPeople(name: String) {
//        guard let image = selectedImage else { return }
//        
//        let id = UUID()
//        let filename = "\(id).jpg"
//        
//        let imagePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(filename)
//        
//        if let data = image.jpegData(compressionQuality: 0.8) {
//            try? data.write(to: imagePath, options: [.atomic, .completeFileProtection])
//        }
//        
//        let newPerson = Person(id: id, name: name, imageFileName: filename)
//        people.append(newPerson)
//        
//        viewModel.save()
//        
//        selectedImage = nil
//        pickerItem = nil
//    }
    
//    func loadPeople() -> [Person] {
//        do {
//            let data = try Data(contentsOf: savePath)
//            return try JSONDecoder().decode([Person].self, from: data)
//        } catch {
//            return []
//        }
//    }
//    
//    func loadImage(for person: Person) -> UIImage? {
//        let imagePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(person.imageFileName)
//        return UIImage(contentsOfFile: imagePath.path)
//    }
}

#Preview {
    ContentView()
}
