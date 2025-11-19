//
//  Card.swift
//  Flashzilla
//
//  Created by Leandro Motta Junior on 14/11/25.
//

import Foundation

struct Card: Codable {
    var prompt: String
    var answer: String
    
    static let example = Card(prompt: "What's your name?", answer: "Leandro")
}
