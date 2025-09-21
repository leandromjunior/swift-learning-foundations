//
//  DetailView.swift
//  PeopleList
//
//  Created by Leandro Motta Junior on 16/09/25.
//

import SwiftUI
import SwiftData

struct DetailView: View {
    let user: User
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 20) {
                    Text(user.isActive ? "Active" : "Inactive")
                        .foregroundStyle(user.isActive ? .green : .red)
                        .font(.headline)
                    Text(user.about)
                    
                    HStack {
                        Text("Age")
                        Text(String(user.age))
                        
                    }

                    Text("Friends: \(user.friends.count)")
                    
                    Text("Friends")
                        .font(.title.bold())
                    
                    ForEach(user.friends) { friend in
                        Text(friend.name)
                    }
                }
            }
            .navigationTitle(user.name)
            .scrollBounceBehavior(.basedOnSize)
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)
        let user = User(id: "12", isActive: true, name: "Caio Alfredo", age: 32, company: "Apple", email: "caio@apple.com", address: "Rua Cuper", about: "Love what he does", registered: "1234", tags: ["video", "games"], friends: [Friend(id: "2", name: "Junior")])
        return DetailView(user: user)
            .modelContainer(container)
    } catch {
        return Text("Failed to create container \(error.localizedDescription)")
    }
}
