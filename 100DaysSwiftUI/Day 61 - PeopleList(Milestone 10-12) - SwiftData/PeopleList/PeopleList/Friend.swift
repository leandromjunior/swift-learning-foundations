//
//  Friend.swift
//  PeopleList
//
//  Created by Leandro Motta Junior on 15/09/25.
//

import Foundation

class Friend: Codable, Identifiable {
    
    var id: String
    var name: String
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}
