//
//  Number.swift
//  RollTheDice
//
//  Created by Leandro Motta Junior on 03/12/25.
//

import Foundation

struct Number: Identifiable, Codable {
    var id = UUID()
    var number: Int
}

@Observable
class Numbers {
    var numbers = [Number]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(numbers) {
                UserDefaults.standard.set(encoded, forKey: "Numbers")
            }
        }
    }
    
    init() {
        if let savedNumbers = UserDefaults.standard.data(forKey: "Numbers") {
            if let decodedNumbers = try? JSONDecoder().decode([Number].self, from: savedNumbers) {
                numbers = decodedNumbers
                return
            }
        }
        
        numbers = []
    }
}
