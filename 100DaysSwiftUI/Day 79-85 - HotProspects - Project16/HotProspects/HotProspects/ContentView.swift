//
//  ContentView.swift
//  HotProspects
//
//  Created by Leandro Motta Junior on 21/10/25.
//

import SwiftUI

// Letting users select items in a List

struct SelectItemsInList: View {
    let users = ["Tohru", "Yuki", "Kyo", "Momiji"]
    // @State private var selection: String? -> To handle one selection
    @State private var selection = Set<String>() // -> To handle multiple selection
    var body: some View {
        List(users, id: \.self, selection: $selection) { user in
            Text(user)
        }
        
        // To Handle one selection
//        if let selection {
//            Text("You selected \(selection)")
//        }
        
        // To handle multiple selection
        if selection.isEmpty == false {
            Text("You selected \(selection.formatted())")
        }
        
        EditButton() // -> Swift Function
    }
}

// Creating tabs with TabView and tabItem()
struct Tabs: View {
    // With this variable we can change tabs programatically, by tapping a button for example. So we need to use binding ($) and the .tag() modifier
    @State private var selectedTab = "One"
    var body: some View {
        TabView(selection: $selectedTab) {
            Button("Show Tab 2") {
                selectedTab = "Two"
            }
            .tabItem {
                Label("One", systemImage: "star")
            }
            .tag("One")
            
            Text("Tab 2")
                .tabItem {
                    Label("Two", systemImage: "circle")
                }
                .tag("Two")
        }
    }
}

// Swift's Result type
struct ResultType: View {
    @State private var output = ""
    var body: some View {
        Text(output)
            .task {
                await fetchReadingsTask()
            }
    }
    
    func fetchReadings() async {
        do {
            let url = URL(string: "https://hws.dev/readings.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let readings = try JSONDecoder().decode([Double].self, from: data)
            output = "Found \(readings.count) readings"
        } catch {
            print("Download error")
        }
    }
    
    func fetchReadingsTask() async {
        let fetchTask = Task {
            let url = URL(string: "https://hws.dev/readings.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let readings = try JSONDecoder().decode([Double].self, from: data)
            return "Found \(readings.count) readings"
        }
        
        let result = await fetchTask.result
        
        // We can do this
        do {
            output = try result.get()
        } catch {
            output = "Error: \(error.localizedDescription)"
        }
        
        // OR we can do this
        switch result {
        case .success(let str):
            output = str
        case .failure(let error):
            output = "Error: \(error.localizedDescription)"
        }
    }
}

// Controlling image interpolation in SwiftUI
struct ImageInterpolation: View {
    var body: some View {
        Image(.example)
            .interpolation(.none) // Adding this line, the image is not blur anymore
            .resizable()
            .scaledToFit()
            .background(.black)
    }
}

// Creating Context Menus
struct ContextMenus: View {
    @State private var backgroundColor = Color.red
    var body: some View {
        VStack {
            Text("Hello World!")
                .padding()
                .background(backgroundColor)
            Text("Change Color")
                .padding()
                .contextMenu { // Context Menu -> It shows a menu by pressing a component
                    //The role .destructive make the foregroundColor red
                    Button("Red", systemImage: "checkmark.circle.fill", role: .destructive) {
                        backgroundColor = .red
                    }
                    
                    Button("Green") {
                        backgroundColor = .green
                    }
                    
                    Button("Blue") {
                        backgroundColor = .blue
                    }
                }
        }
    }
}

// Adding custom row swipe actions to a list
struct AddingSwipeActions: View {
    var body: some View {
        List {
            Text("Taylor Swift")
                .swipeActions {
                    Button("Delete", systemImage: "minus.circle", role: .destructive) {
                        print("Delete")
                    }
                }
                .swipeActions(edge: .leading) {
                    Button("Pin", systemImage: "pin") {
                        print("Pinning")
                    }
                    .tint(.orange)
                }
        }
    }
}

// Scheduling local notificationa
import UserNotifications

struct SchedulingNotifications: View {
    var body: some View {
        VStack {
            Button("Request Permission") {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("All set!")
                    } else if let error {
                        print(error.localizedDescription)
                    }
                }
            }
            
            Button("Schedule Notification") {
                let content = UNMutableNotificationContent()
                content.title = "Feed the cat"
                content.subtitle = "It looks hungry"
                content.sound = UNNotificationSound.default
                
                //Show this notification five seconds from now
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                
                // Choose a random identifier
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
                //Add our notification request
                UNUserNotificationCenter.current().add(request)
            }
        }
    }
}

// Adding Swift package dependencies in XCode
// File > Add Package Dependencies > search for the package "https://github.com/twostraws/SamplePackage" and Add.

import SamplePackage

struct AddDependencies: View {
    let possibleNumbers = 1...60
    var results: String {
        let selected = possibleNumbers.random(7).sorted()
        let strings = selected.map(String.init)
        return strings.formatted()
    }
    var body: some View {
        Text(results)
    }
}

struct ContentView: View {
    var body: some View {
        TabView {
            ProspectView(filter: .none)
                .tabItem {
                    Label("Everyone", systemImage: "person.3")
                }
            ProspectView(filter: .contacted)
                .tabItem {
                    Label("Contacted", systemImage: "checkmark.circle")
                }
            ProspectView(filter: .uncontacted)
                .tabItem {
                    Label("Uncontacted", systemImage: "questionmark.diamond")
                }
            MeView()
                .tabItem {
                    Label("Me", systemImage: "person.crop.square")
                }
        }
    }
}

#Preview {
    //SelectItemsInList()
    //Tabs()
    //ResultType()
    //ImageInterpolation()
    //ContextMenus()
    //AddingSwipeActions()
    //SchedulingNotifications()
    //AddDependencies()
    ContentView()
}
