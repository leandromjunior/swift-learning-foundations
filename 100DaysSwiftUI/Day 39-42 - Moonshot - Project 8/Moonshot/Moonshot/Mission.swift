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
    let launchDate: String?
    let crew: [CrewRole]
    let description: String
    
}
