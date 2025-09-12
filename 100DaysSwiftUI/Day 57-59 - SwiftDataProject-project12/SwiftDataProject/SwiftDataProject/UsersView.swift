//
//  UsersView.swift
//  SwiftDataProject
//
//  Created by Leandro Motta Junior on 11/09/25.
//

import SwiftUI
import SwiftData

struct UsersView: View {
    @Environment(\.modelContext) var modelContext
    @Query var users: [User]
    var body: some View {
        List(users) { user in
            HStack {
                NavigationLink(value: user) {
                    Text(user.name)
                    
                    Spacer()
                    
                    Text(String(user.jobs.count))
                        .fontWeight(.black)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(.capsule)
                    
                }
            }
        }
        // This navigationDestination was in the contentview file but because the List was transfered for here i took the navigationDestination together
        .navigationDestination(for: User.self) { user in
            EditUserView(user: user)
        }
    }
    
    init(minimumJoinDate: Date, sortOrder: [SortDescriptor<User>]) {
        _users = Query(filter: #Predicate<User> { user in
            user.joinDate >= minimumJoinDate
        }, sort: sortOrder)
    }
    
    func addSample() {
        let user1 = User(name: "Piper Chapman", city: "New York", joinDate: .now)
        let job1 =  Job(name: "Organize sock drawer", priority: 3)
        let job2 = Job(name: "Make plans with Alex", priority: 4)
        
        modelContext.insert(user1)
        
        user1.jobs.append(job1)
        user1.jobs.append(job2)
    }
}

#Preview {
    UsersView(minimumJoinDate: .now, sortOrder: [SortDescriptor(\User.name)])
        .modelContainer(for: User.self)
}
