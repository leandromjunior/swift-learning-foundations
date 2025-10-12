//
//  EditView.swift
//  BucketList
//
//  Created by Leandro Motta Junior on 30/09/25.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var editViewModel: EditViewModel
    
    
    var onSave: (Location) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Place name", text: $editViewModel.name)
                    TextField("Description", text: $editViewModel.description)
                }
                
                Section("Nearby...") {
                    switch editViewModel.loadingState {
                    case .loading:
                        Text("Loading...")
                    case .loaded:
                        ForEach(editViewModel.pages, id: \.pageId) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ") +
                            Text(page.description)
                                .italic()
                        }
                    case .failed:
                        Text("Please try again later")
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save") {
                    var newLocation = editViewModel.location
                    newLocation.id = UUID()
                    newLocation.name = editViewModel.name
                    newLocation.description = editViewModel.description
                    
                    onSave(newLocation)
                    dismiss()
                }
            }
            .task {
                await editViewModel.fetchNearbyPlaces()
            }
        }
    }
    
    //This init is very useful for Views inside a .sheet (that the user can drag to close), you need to ensure that closing the screen cancels the changes.
    init(location: Location, onSave: @escaping (Location) -> Void) {
        //editViewModel.location = location
        self.onSave = onSave
        
        _editViewModel = State(initialValue: EditViewModel(location: location))
    }
}

#Preview {
    EditView(location: .example) { _ in }
}
