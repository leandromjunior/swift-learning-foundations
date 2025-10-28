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
    
    init(name: String, emailAdress: String, isContacted: Bool) {
        self.name = name
        self.emailAdress = emailAdress
        self.isContacted = isContacted
    }
}
