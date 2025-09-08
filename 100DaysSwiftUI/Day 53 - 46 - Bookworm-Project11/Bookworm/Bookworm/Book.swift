//
//  Book.swift
//  Bookworm
//
//  Created by Leandro Motta Junior on 02/09/25.
//

import Foundation
import SwiftData

@Model
class Book {
    var title: String
    var author: String
    var genre: String
    var review: String
    var rating: Int
    var days: Date
    
    init(title: String, author: String, genre: String, review: String, rating: Int, days: Date) {
        self.title = title
        self.author = author
        self.genre = genre
        self.review = review
        self.rating = rating
        self.days = days
    }
}
