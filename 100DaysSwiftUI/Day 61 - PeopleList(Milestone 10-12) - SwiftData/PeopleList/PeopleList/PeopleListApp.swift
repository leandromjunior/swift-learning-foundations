//
//  PeopleListApp.swift
//  PeopleList
//
//  Created by Leandro Motta Junior on 15/09/25.
//

import SwiftUI
import SwiftData

@main
struct PeopleListApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
