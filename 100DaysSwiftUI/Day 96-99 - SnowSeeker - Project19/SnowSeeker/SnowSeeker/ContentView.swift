//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Leandro Motta Junior on 11/12/25.
//

import SwiftUI

struct SplitView: View {
    var body: some View {
        NavigationSplitView {
            Text("Primary")
        } detail: {
            Text("Content")
        }
    }
}

struct SplitView2: View {
    var body: some View {
        NavigationSplitView {
            NavigationLink("Primary") {
                Text("New Text")
            }
        } detail: {
            Text("Content")
                .navigationTitle("Content View")
        }
    }
}

struct SplitView3: View {
    var body: some View {
        // if we change the content in parentheses to (preferredCompactColumn: .constant(.detail)) we change the default exhibition.
        NavigationSplitView(columnVisibility: .constant(.all)) {
            NavigationLink("Primary") {
                Text("New Text")
            }
        } detail: {
            Text("Content")
                .navigationTitle("Content View")
        }
        .navigationSplitViewStyle(.balanced)
    }
}

struct User: Identifiable {
    var id = "Flamengo"
}

// Showing sheets using optionals
struct showingSheet: View {
    @State private var selectedUser: User? = nil
    @State private var isShowingUser = false
    
    var body: some View {
        Button("Tap Me") {
            selectedUser = User()
            isShowingUser = true
        }
        .sheet(item: $selectedUser) { user in
            Text(user.id)
                .presentationDetents([.medium, .large]) // It defines how much the sheet will occupy
        }
    }
}
// Showing alert using optionals
struct showingSheetandAlert: View {
    @State private var selectedUser: User? = nil
    @State private var isShowingUser = false
    
    var body: some View {
        Button("Tap Me") {
            selectedUser = User()
            isShowingUser = true
        }
        .alert("Welcome", isPresented: $isShowingUser, presenting: selectedUser) { user in
            Button(user.id) { }
        }
    }
}

// Using groups as transparent layout containers
struct UserView: View {
    var body: some View {
        Group {
            Text("Name: Leandro")
            Text("Country: Brazil")
            Text("Pets: Maya")
        }
        .font(.title)
    }
}

struct UserDisplayedView: View {
    @State private var layoutVertically = false
    
    var body: some View {
        Button {
            layoutVertically.toggle()
        } label: {
            if layoutVertically {
                VStack {
                    UserView()
                }
            } else {
                HStack {
                    UserView()
                }
            }
        }
    }
}

struct UserDisplayedView2: View { //Another way to show vertically OR Horizontal
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var body: some View {
        if horizontalSizeClass == .compact {
            VStack {
                UserView()
            }
        } else {
            HStack {
                UserView()
            }
        }
    }
}

// Tip
// In situations where we have only one view inside a stack and it doesn't take any parameters, we can pass the view's initializer directly to the stack to make the code shorter
struct UserDisplayedView2Tip: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var body: some View {
        if horizontalSizeClass == .compact {
            VStack(content: UserView.init)
        } else {
            HStack(content: UserView.init)
        }
    }
}

struct ViewThatFitsView: View {
    var body: some View {
        ViewThatFits {
            // An Ipad, iPhone Pro Max or landscape view will show the rectangle
            Rectangle()
                .frame(width: 500, height: 200)
            
            // Smaller devices/screens will show the circle
            Circle()
                .frame(width: 200, height: 200)
        }
    }
}

// Making a SwiftUI view searchable
struct SearchableView: View {
    @State private var searchText = ""
    let allNames = ["Leandro", "Flamengo", "Melvin", "Arrascaeta"]
    
    var filteredNames: [String] {
        if searchText.isEmpty {
            allNames
        } else {
            allNames.filter { $0.localizedStandardContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationStack {
            List(filteredNames, id: \.self) { name in
                Text(name)
            }
            .searchable(text: $searchText, prompt: "Look for something")
            .navigationTitle("Searching")
        }
    }
}

// Sharing @Observable objects through SwiftUI's environment
@Observable
class Player {
    var name = "Anonymous"
    var highScore = 0
}

struct HighScoreView: View {
    var player: Player
    
    var body: some View {
        Text("Your high score: \(player.highScore)")
    }
}

struct MainPlayerView: View {
    @State private var player = Player()
    var body: some View {
        VStack {
            Text("Welcome")
            HighScoreView(player: player)
        }
    }
}

// Tip

struct HighScoreView2: View {
    @Environment(Player.self) var player
    
    var body: some View {
        @Bindable var player = player
        
        Stepper("High score: \(player.highScore)", value: $player.highScore)
    }
}

// We can have the same result of MainPlayerView in a simpler code
struct MainPlayerView2: View {
    @State private var player = Player()
    var body: some View {
        VStack {
            Text("Welcome")
            HighScoreView2()
        }
        .environment(player) // Works only for classes with @Observable Macro
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
    //SplitView()
    //SplitView2()
    //SplitView3()
    //showingSheet()
    //UserDisplayedView()
    //ViewThatFitsView()
    //SearchableView()
    //MainPlayerView()
    MainPlayerView2()
    //showingSheetandAlert()
    //ContentView()
}
