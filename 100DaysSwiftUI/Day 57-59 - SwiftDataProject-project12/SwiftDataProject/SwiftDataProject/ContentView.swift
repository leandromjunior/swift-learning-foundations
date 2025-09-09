//
//  ContentView.swift
//  SwiftDataProject
//
//  Created by Leandro Motta Junior on 09/09/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    //@Query(sort: \User.name) var users: [User]
    
//    @Query(filter: #Predicate<User> { user in
//        user.name.localizedStandardContains("R") //It finds the R at any position of the string Upper or lower
//    }, sort: \User.name) var users: [User]
    
//    @Query(filter: #Predicate<User> { user in
//        user.name.localizedStandardContains("R") && user.city == "London" // condition for filter
//    }, sort: \User.name) var users: [User]
    
    //We can write the same code above this way:
    @Query(filter: #Predicate<User> { user in
        if user.name.localizedStandardContains("R") {
            if user.city == "London" {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }, sort: \User.name) var users: [User]
    
    @State private var path = [User]()
    
    var body: some View {
        NavigationStack(path: $path) {
            List(users) { user in
                NavigationLink(value: user) {
                    Text(user.name)
                }
            }
            .navigationTitle("Users")
            .navigationDestination(for: User.self) { user in
                EditUserView(user: user)
            }
            .toolbar {
                Button("Add User", systemImage: "plus") {
//                    let user = User(name: "", city: "", joinDate: .now)
//                    modelContext.insert(user)
//                    path = [user]
                    
                    // If it has any data saved in user it will be deleted before create the samples
                    try? modelContext.delete(model: User.self)
                    
                    // Adding some samples for [Filtering @Query using Predicate]
                    let first = User(name: "Ed Sheeran", city: "London", joinDate: .now.addingTimeInterval(86400 * -10))
                                let second = User(name: "Rosa Diaz", city: "New York", joinDate: .now.addingTimeInterval(86400 * -5))
                                let third = User(name: "Roy Kent", city: "London", joinDate: .now.addingTimeInterval(86400 * 5))
                                let fourth = User(name: "Johnny English", city: "London", joinDate: .now.addingTimeInterval(86400 * 10))

                                modelContext.insert(first)
                                modelContext.insert(second)
                                modelContext.insert(third)
                                modelContext.insert(fourth)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
