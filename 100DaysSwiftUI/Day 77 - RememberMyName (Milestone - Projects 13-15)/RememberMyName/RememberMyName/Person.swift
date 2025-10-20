//
//  Person.swift
//  RememberMyName
//
//  Created by Leandro Motta Junior on 17/10/25.
//

import Foundation

struct Person: Identifiable, Codable, Comparable {
    var id = UUID()
    var name: String
    var imageFileName: String
    
    static func <(lhs: Person, rhs: Person) -> Bool {
        lhs.name < rhs.name
    }
}
