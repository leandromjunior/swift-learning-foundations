import Foundation

let myAge = 26
let yourAge = 24

if myAge > yourAge {
    "I'm Older than you"
} else if myAge < yourAge {
    "You're older than me"
} else {
    "We're the same age"
}

let myMotherAge = myAge + 28
let doubleMyAge = myAge * 2

/// 1. Unary Prefix
let foo = !true
/// 2. Unary Postfix
let name = Optional("Leandro")
type(of: name)
let unaryPostFix = name!
type(of: unaryPostFix)
/// 3. Binary Infix -> Operation between two (or more) elements
let result = 1 + 2
let names = "Manchester" + " " + "City"


// Ternary Operator -> CONDITION ? VALUE IF CONDITION IS MET : VALUE IF CONDITION IS NOT MET

let Age = 30

let message = Age >= 18 ? "You are an adult" : "You are not an adult yet"
