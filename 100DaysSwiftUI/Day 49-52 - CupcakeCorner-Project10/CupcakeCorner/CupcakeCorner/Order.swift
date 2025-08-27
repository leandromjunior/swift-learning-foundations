//
//  Order.swift
//  CupcakeCorner
//
//  Created by Leandro Motta Junior on 26/08/25.
//

import Foundation

@Observable
class Order {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    // Adding a property observer to the specialRequestEnable to turn the "dependent" variables false when the specialRequestEnabled is false to avoid any bugs
    var specialRequestEnable = false {
        didSet {
            if specialRequestEnable == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
}
