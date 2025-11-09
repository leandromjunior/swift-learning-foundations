//
//  Prospect.swift
//  HotProspects
//
//  Created by Leandro Motta Junior on 27/10/25.
//

import Foundation
import SwiftData

@Model
class Prospect {
    var name: String
    var emailAdress: String
    var isContacted: Bool
    var dateAdded = Date()
    
    init(name: String, emailAdress: String, isContacted: Bool, dateAdded: Date) {
        self.name = name
        self.emailAdress = emailAdress
        self.isContacted = isContacted
        self.dateAdded = dateAdded
    }
}
