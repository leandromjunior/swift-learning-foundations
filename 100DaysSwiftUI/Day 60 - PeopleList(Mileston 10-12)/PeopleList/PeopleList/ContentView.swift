//
//  ContentView.swift
//  PeopleList
//
//  Created by Leandro Motta Junior on 15/09/25.
//

import SwiftUI

struct ContentView: View {
    @State private var users: [User] = []
    @State private var isLoading = false
    var body: some View {
        NavigationStack {
            VStack {
                if isLoading {
                    ProgressView("Loading...")
                } else {
                    List(users) { user in
                        VStack(alignment: .leading) {
                            Text(user.name)
                        }
                    }
                }
            }
            .navigationTitle("Users")
            .task {
                await fetchData()
            }
        }
    }
    
    func fetchData() async {
        isLoading = true
        
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        var request = URLRequest(url: url)
        request.setValue("aplication/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        do {
            let(data, _) = try await URLSession.shared.data(for: request)
            let decoded = try JSONDecoder().decode([User].self, from: data)
            
            self.users = decoded
        } catch {
            print("Failed loading the data \(error.localizedDescription)")
        }
        
        isLoading = false
    }
}

#Preview {
    ContentView()
}
