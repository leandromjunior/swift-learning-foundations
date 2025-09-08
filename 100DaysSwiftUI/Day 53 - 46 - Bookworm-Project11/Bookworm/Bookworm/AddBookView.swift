//
//  AddBookView.swift
//  Bookworm
//
//  Created by Leandro Motta Junior on 02/09/25.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy"
    @State private var review = ""
    @State private var days = Date.now
    
    var hasValidData: Bool {
        if title.isEmpty || author.isEmpty {
            return false
        }
        return true
    }
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance"]
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name of Book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    DatePicker("Enter a date", selection: $days, displayedComponents: .date)
                }
                
                Section("Write a review") {
                    TextEditor(text: $review)
                    
                    RatingView(rating: $rating)
                }
                
                Section {
                    Button("Save") {
                        let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating, days: days)
                        modelContext.insert(newBook)
                        //try? modelContext.save()
                        dismiss()
                        
                    }
                    .disabled(hasValidData == false)
                }
            }
            .navigationTitle("New Book")
        }
    }
}

#Preview {
    AddBookView()
}

/* The lines 20-26 and line 56 was inserted for te challenge 1 of day 56 as following:
 
 1- Right now it’s possible to select no title, author, or genre for books, which causes a problem for the detail view. Please fix this, either by forcing defaults, validating the form, or showing a default picture for unknown genres – you can choose.
 */
