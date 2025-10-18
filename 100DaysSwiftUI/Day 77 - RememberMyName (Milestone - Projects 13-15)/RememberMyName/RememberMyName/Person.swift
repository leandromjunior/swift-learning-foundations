//
//  Person.swift
//  RememberMyName
//
//  Created by Leandro Motta Junior on 17/10/25.
//

import Foundation

struct People: Identifiable {
    var id: UUID
    var name: String
    var imageFileName: String
    
    static let example = People(id: UUID(), name: "Teste", imageFileName: "123.jpg")
}
