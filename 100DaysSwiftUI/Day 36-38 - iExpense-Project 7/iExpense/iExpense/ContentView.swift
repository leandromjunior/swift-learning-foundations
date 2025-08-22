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

// Adding the "Identifiable" protocol we can remove the "id: \.id" parameter inside the ForEach
struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
                if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            
                            Text(item.type)
                        }
                        
                        Spacer()
                        
                        Text(item.amount, format: .currency(code: "USD"))
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

//Day 38 - Make some notes of what each line or each excerpt do in the "ContentView" above

/*
 1 - Use the user’s preferred currency, rather than always using US dollars.
 2 - Modify the expense amounts in ContentView to contain some styling depending on their value – expenses under $10 should have one style, expenses under $100 another, and expenses over $100 a third style. What those styles are depend on you.
 3 - For a bigger challenge, try splitting the expenses list into two sections: one for personal expenses, and one for business expenses. This is tricky for a few reasons, not least because it means being careful about how items are deleted!
 */

struct ChallengeContentView: View {
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(item.name)
                                .font(.headline)
                            
                            Text(item.type)
                        }
                        
                        Spacer()
                        
                        if item.amount == 0 {
                            Text(item.amount, format: .currency(code: "BRL"))
                                .foregroundStyle(.green)
                        } else if item.amount < 10 {
                            Text(item.amount, format: .currency(code: "BRL"))
                                .foregroundStyle(.yellow)
                        } else if item.amount < 100 {
                            Text(item.amount, format: .currency(code: "BRL"))
                                .foregroundStyle(.orange)
                        } else {
                            Text(item.amount, format: .currency(code: "BRL"))
                                .foregroundStyle(.red)
                        }
                            
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

// Day 46 - Challenge [1]

/*
1 - Change project 7 (iExpense) so that it uses NavigationLink for adding new expenses rather than a sheet. (Tip: The dismiss() code works great here, but you might want to add the navigationBarBackButtonHidden() modifier so they have to explicitly choose Cancel.)
 */

struct ChallengeNavigationView: View {
    
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(item.name)
                                .font(.headline)
                            
                            Text(item.type)
                        }
                        
                        Spacer()
                        
                        if item.amount == 0 {
                            Text(item.amount, format: .currency(code: "BRL"))
                                .foregroundStyle(.green)
                        } else if item.amount < 10 {
                            Text(item.amount, format: .currency(code: "BRL"))
                                .foregroundStyle(.yellow)
                        } else if item.amount < 100 {
                            Text(item.amount, format: .currency(code: "BRL"))
                                .foregroundStyle(.orange)
                        } else {
                            Text(item.amount, format: .currency(code: "BRL"))
                                .foregroundStyle(.red)
                        }
                            
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                NavigationLink() {
                    AddView(expenses: expenses)
                        .navigationBarBackButtonHidden(true) //added this modifier to hide the default back button in the AddView and in the "AddView" view i created another toolbar with a cancel button and the dismiss environment method

                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ChallengeNavigationView()
}
