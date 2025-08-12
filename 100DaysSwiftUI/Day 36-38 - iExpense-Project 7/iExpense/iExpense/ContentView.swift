//
//  ContentView.swift
//  iExpense
//
//  Created by Leandro Motta Junior on 12/08/25.
//

import SwiftUI

// Day 36
struct User {
    var firstName = "Bilbo"
    var lastName = "Baggins"
}

// When we use at State with a struct, SwiftUI will automatically update our whole view when a value changes
struct StructDataBehaviorView: View {
    @State private var user = User()

    var body: some View {
        VStack {
            Text("My name is \(user.firstName) \(user.lastName)")
            
            TextField("First Name", text: $user.firstName)
            TextField("Last Name", text: $user.lastName)
        }
    }
}

@Observable
class UserC {
    var firstName = "Bilbo"
    var lastName = "Baggins"
}

// When we use at State with CLASS, we must mark the class as being "Observable" if we want SwiftUI to watch its contents for changes
struct ClassDataBehaviorView: View {
    @State private var userc = UserC()
    var body: some View {
        VStack {
            Text("My name is \(userc.firstName) \(userc.lastName)")
            
            TextField("First Name", text: $userc.firstName)
            TextField("Last Name", text: $userc.lastName)
        }
    }
}

struct SecondViewSheetView: View {
    @Environment(\.dismiss) var dismiss
    let name: String
    
    var body: some View {
        Text("Hello \(name). That's Second View")
        
        Button("Dismiss") {
            dismiss()
        }
    }
}

struct FirstViewSheetView: View {
    @State private var showingSheet = false
    var body: some View {
        Button("Show Sheet") {
            showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            // if there was no var passed in Second View, the parameter here would be empty
            SecondViewSheetView(name: "Leandro")
        }
    }
}

struct DeletingRowsView:View {
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(numbers, id: \.self) {num in
                        Text("Row \(num)")
                    }
                    // That lets us delete a row by sliding the row. This can only be done in a "ForEach"
                    .onDelete(perform: removeRows)
                }
                
                Button("Add Number") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
            }
            // Add an Edit Button at the top of the screen an lets us delete rows either
            .toolbar {
                EditButton()
            }
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}

// This stores the user settings, so when he reopens the app the last modifications will be there, but this way don't store the settings so instantly. Otherwise, we have "AppStorage"
struct StoringUserSettingsView : View {
    @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
    var body: some View {
        Button("Tap Count: \(tapCount)") {
            tapCount += 1
            
            UserDefaults.standard.set(tapCount, forKey: "Tap")
        }
    }
}

// Storing user settings with AppStorage
struct StoringUserSettings2View: View {
    @AppStorage("tapCount") private var tapCount = 0
    var body: some View {
        Button("Tap Count: \(tapCount)") {
            tapCount += 1
        }
    }
}

struct UserS: Codable {
    let firstName: String
    let lastName: String
    
}

struct ArchivingWithCodable: View {
    @State private var user = UserS(firstName: "Max", lastName: "Verstappen")
    var body: some View {
        Button("Save User") {
            let encoder = JSONEncoder()
            
            if let data = try? encoder.encode(user) {
                UserDefaults.standard.set(data, forKey: "UserData")
            }
        }
        // When we have JSON data and we want to covert it to Swift Codable types - we should use "JSONDecoder" rather than "JSONEncoder"
    }
}

// Day 37
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
    StoringUserSettings2View()
}
