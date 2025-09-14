//
//  Expense.swift
//  iExpense
//
//  Created by Leandro Motta Junior on 13/09/25.
//

import Foundation
import SwiftData

@Model
class Expense {
    var name: String
    var type: String
    var amount: Double
    
    init(name: String, type: String, amount: Double) {
        self.name = name
        self.type = type
        self.amount = amount
    }
}
