//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Leandro Motta Junior on 26/08/25.
//

import SwiftUI

// Day 49

// Sending and Receiving codable data with URLSession and SwiftUI

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct UsingURLSessionView: View {
    @State private var results = [Result]()
    var body: some View {
        List(results, id: \.trackId) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            }
        }
        .task {
            await loadData()
        }
    }
    
    func loadData() async {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodedResponse.results
            }
        } catch {
            print("Invalid Data")
        }
    }
}

//Loading an image from a remote server

struct LoadingImageFromRemoteServer: View {
    var body: some View {
        // To change the size we can just use scale
        //AsyncImage(url: URL(string: "https://hws.dev/img/logo.png"), scale: 3)
        
        // but sometimes we want a precise size
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) {image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            Color.red
        }
        .frame(width: 200, height: 200)
        
        // We can use a third way that that tells us the whether the image was loaded, hit an error or hasn't finished yet
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) {phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
            } else if phase.error != nil {
                Text("There was an error loading the image.")
            } else {
                ProgressView()
            }
        }
        .frame(width: 200, height: 200)
    }
}

// Validating and Disabling form
struct FormValidation: View {
    @State private var username = ""
    @State private var email = ""
    
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("email", text: $email)
            }
            
            Section {
                Button("Create account") {
                    print("creating account...")
                }
            }
            .disabled(username.isEmpty || email.isEmpty)
        }
    }
}

struct FormValidationUsingComputedProperty: View {
    @State private var username = ""
    @State private var email = ""
    
    var disableForm: Bool {
        username.count < 5 || email.count < 5
    }
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("email", text: $email)
            }
            
            Section {
                Button("Create account") {
                    print("creating account...")
                }
            }
            .disabled(disableForm)
        }
    }
}

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
    FormValidation()
}
