//
//  Student.swift
//  Bookworm
//
//  Created by Leandro Motta Junior on 02/09/25.
//

import Foundation
import SwiftData

@Model // The model macro contains the @observable and it is important to work with SwiftData
class Student {
    var id: UUID
    var name: String
    
    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
}
