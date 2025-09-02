//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Leandro Motta Junior on 01/09/25.
//

import SwiftUI
import SwiftData

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Student.self)
    }
}
