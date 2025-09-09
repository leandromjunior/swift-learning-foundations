//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Leandro Motta Junior on 09/09/25.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
