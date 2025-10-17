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
    @State private var selectedImage: Image?
    
    var body: some View {
        NavigationStack {
            List(1..<3) { row in
                Text("\(row)")
            }
            .navigationTitle("Row")
            .toolbar {
                PhotosPicker(selection: $pickerItem, matching: .images) {
                    Button("New Photo", systemImage: "plus") { }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
