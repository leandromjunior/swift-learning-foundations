//
//  User.swift
//  SwiftDataProject
//
//  Created by Leandro Motta Junior on 09/09/25.
//

import Foundation
import SwiftData

@Model
class User {
    var name: String
    var city: String
    var joinDate: Date
    @Relationship(deleteRule: .cascade) var jobs = [Job]() //This line delete the jobs from the array when a user related to them is deleted.
    
    init(name: String, city: String, joinDate: Date) {
        self.name = name
        self.city = city
        self.joinDate = joinDate
    }
}
