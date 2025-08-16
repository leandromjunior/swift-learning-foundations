//
//  Mission.swift
//  Moonshot
//
//  Created by Leandro Motta Junior on 16/08/25.
//

import Foundation

// We can just put the struct below inside the another struct, this makes the code more practical and readable

//struct CrewRole: Codable {
//    let name: String
//    let role: String
//}

struct Mission: Codable, Identifiable {
    
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
//    let launchDate: String?
    // Now that our decoding code understands how our dates are formatted, we can change that property to be an optional Date (Bundle-Decodable - line 63)
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    // Creating 2 computed properties
    
    var displayName: String {
        "Apollo \(id)" // Form the name of the mission to display in the screen
    }
    
    var image: String {
        "apollo\(id)" //form the name of the image inside the assets folder and get it to the screen
    }
    
    // This will replace the code "Text(mission.launchDate ?? "N/A")" innside the ContentView [line - 227] that attempts to use an optional Date inside a text view
    var formattedLaunchDate: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
}
