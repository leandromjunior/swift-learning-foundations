//
//  DetailView.swift
//  PeopleList
//
//  Created by Leandro Motta Junior on 16/09/25.
//

import SwiftUI

struct LineDivider: View {
    var body: some View {
        Rectangle()
            .frame(height: 3)
            .foregroundStyle(.gray)
            .padding(.horizontal, 20)
            .padding(.vertical)
    }
}

struct DetailView: View {
    let user: User
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 20) {
                    HStack {
                        Text(user.initialsName)
                            .font(.system(size: 55).bold())
                            .fontDesign(.monospaced)
                            .frame(width: 90, height: 90) //inner circle background resize
                            .background(.gray)
                            .clipShape(.circle)
                            .overlay(
                                Circle()
                                    .strokeBorder(user.isActive ? .green : .red, lineWidth: 4)
                                    .frame(width: 110, height: 100)
                                
                            )
                            .padding([.top, .leading])
                        
                        Spacer()
                        
                        VStack {
                            Text("Age")
                                .font(.headline.bold())
                            Text(String(user.age))
                                .padding(.top)
                        }
                        
                        Spacer()
                        
                        VStack {
                            Text("Friends")
                                .font(.headline.bold())
                            Text("\(user.friends.count)")
                                .padding(.top)
                        }
                        
                        Spacer()
                    }
                    
                    LineDivider()
                    
                    Text(user.about)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.horizontal)
                    
                    LineDivider()
                    
                    Text("Friends List")
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
    // In case of @Binding we need to use a line as the 86
//    DetailView(user: .constant(User(id: "12", isActive: true, name: "Caio Alfredo", age: 32, company: "Meta", email: "teste@gmail.com", address: "Rua oscorp", about: "Like video games", registered: "1234", tags: ["video", "games"], friends: [Friend(id: "2", name: "Junior")])))
    
    DetailView(user: User(id: "12", isActive: true, name: "Caio Alfredo", age: 32, company: "Meta", email: "teste@gmail.com", address: "Rua Oscorp", about: "Like video games", registered: "1234", tags: ["video", "games"], friends: [Friend(id: "2", name: "Junior")]))
}

// The DetailView does not modify any value, so it doesn't need to be @Binding, only let because the view only read
