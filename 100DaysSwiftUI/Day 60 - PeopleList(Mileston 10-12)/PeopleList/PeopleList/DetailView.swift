//
//  DetailView.swift
//  PeopleList
//
//  Created by Leandro Motta Junior on 16/09/25.
//

import SwiftUI

struct DetailView: View {
    @Binding var user: User
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 20) {
                    Text(user.initialsName)
                        .font(.system(size: 73).bold())
                        .background(.gray)
                        .clipShape(.circle)
                        .overlay(
                            Circle()
                                .strokeBorder(user.isActive ? .green : .red, lineWidth: 4)
                                .frame(width: 95, height: 95)
                                
                        )
                        .padding(.top)
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
    DetailView(user: .constant(User(id: "12", isActive: false, name: "Caio Alfredo", age: 32, company: "Meta", email: "teste@gmail.com", address: "Rua oscorp", about: "Like video games", registered: "1234", tags: ["video", "games"], friends: [Friend(id: "2", name: "Junior")])))
}
