//
//  ContentView_ViewModel.swift
//  RememberMyName
//
//  Created by Leandro Motta Junior on 20/10/25.
//

import Foundation
import _PhotosUI_SwiftUI

extension ContentView {
    
    @Observable
    class ViewModel {
        var pickerItem: PhotosPickerItem?
        var selectedImage: UIImage?
        private(set) var people: [Person] = []
        var hasSelectedImage = false
        
        let savePath = URL.documentsDirectory.appending(path: "SavedPeople")
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                people = try JSONDecoder().decode([Person].self, from: data)
            } catch {
                people = []
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
        
//        func loadPeople() -> [Person] {
//            do {
//                let data = try Data(contentsOf: savePath)
//                return try JSONDecoder().decode([Person].self, from: data)
//            } catch {
//                return []
//            }
//        }
        
        func loadImage(for person: Person) -> UIImage? {
            let imagePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(person.imageFileName)
            return UIImage(contentsOfFile: imagePath.path)
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
            
            selectedImage = nil
            pickerItem = nil
        }
    }
}
