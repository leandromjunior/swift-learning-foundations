//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Leandro Motta Junior on 16/12/25.
//

import SwiftUI

@Observable
class Favorites {
    
    private var resorts: Set<String>
    
    private let key = "Favorites"
    
    init() {
        
        resorts = []
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        
    }
}
