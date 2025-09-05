//
//  ContentView.swift
//  Bookworm
//
//  Created by Leandro Motta Junior on 01/09/25.
//

import SwiftUI
import SwiftData

// Day 53
// Creating a custom component with @Binding

struct PushButton: View {
    let title: String
    @Binding var isOn: Bool
    
    var onColors = [Color.red, Color.yellow]
    var offColors = [Color(white: 0.6), Color(white: 0.4)]
    var body: some View {
        Button(title) {
            isOn.toggle()
        }
        .padding()
        .background(LinearGradient(colors: isOn ? onColors : offColors, startPoint: .top, endPoint: .bottom))
        .foregroundStyle(.white)
        .clipShape(.capsule)
        .shadow(radius: isOn ? 0 : 5)
    }
}

struct CreatingComponentWithBindindView: View {
    @State private var rememberMe = false
    var body: some View {
        VStack {
            PushButton(title: "Remember Me", isOn: $rememberMe)
            Text(rememberMe ? "On" : "Off")
        }
    }
}

// Accepting multi-line text input with TextEditor
struct TextEditorView: View {
    // The AppStorage is not designed to store secure info like username or password
    @AppStorage("notes") private var notes = ""
    
    var body: some View {
        NavigationStack {
            TextEditor(text: $notes) //The behaviour is like a Notes app
                .navigationTitle("Notes")
                .padding()
        }
    }
}

struct TextEditorView2: View {
    @AppStorage("notes") private var notes = ""
    
    var body: some View {
        NavigationStack {
            TextField("Enter the text", text: $notes, axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .navigationTitle("Notes")
                .padding()
        }
    }
}

// Introduction to SwiftData and SwiftUI
struct StudentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var students: [Student]
    var body: some View {
        NavigationStack {
            List(students) { student in
                Text(student.name)
            }
            .navigationTitle("Classroom")
            .toolbar {
                Button("Add") {
                    let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
                    let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]
                    
                    let chosenFirst = firstNames.randomElement()!
                    let chosenLast = lastNames.randomElement()!
                    
                    let student = Student(id: UUID(), name: "\(chosenFirst) \(chosenLast)")
                    
                    modelContext.insert(student)
                }
            }
        }
    }
}
// Day 54
struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    //@Query(sort: \Book.title) var books: [Book] // Ordena por titulo
    //@Query(sort: \Book.rating, order: .reverse) var books: [Book] // Ordena pela nota maior e menor
    
    // The previous sort is good to use with a single field, but for two values or either one, we could use the SortDescriptor
    //@Query(sort: [SortDescriptor(\Book.title)]) var books: [Book]
    
   // @Query(sort: [SortDescriptor(\Book.title, order: .reverse)]) var books: [Book]
    
    // Sorting for two values, in case of it has two books with the same title, the sort for author come in
    @Query(sort: [
        SortDescriptor(\Book.title),
        SortDescriptor(\Book.author)
    ]) var books: [Book]
    
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(books) { book in
                    NavigationLink(value: book) {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            
                            VStack(alignment: .leading) {
                                Text(book.title)
                                    .font(.headline)
                                    .foregroundStyle(book.rating < 2 ? .red : .black)
                                Text(book.author)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .navigationTitle("BookWorm")
            .navigationDestination(for: Book.self) { book in
                DetailView(book: book)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAddScreen.toggle()
                    } label: {
                        Label("Add Button", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                AddBookView()
            }
        }
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            // find this book in  the query
            let book = books[offset]
            // delete it from the context
            modelContext.delete(book)
        }
    }
}

#Preview {
    ContentView()
}

/*
 Due to the challenge 2 of day 56, the line 126 was inserted
 2 - Modify ContentView so that books rated as 1 star are highlighted somehow, such as having their name shown in red.
 */
