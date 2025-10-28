//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by Leandro Motta Junior on 21/10/25.
//

import SwiftUI
import SwiftData

@main
struct HotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
