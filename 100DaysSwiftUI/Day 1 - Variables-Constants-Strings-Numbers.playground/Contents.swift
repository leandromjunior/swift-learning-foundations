import Foundation

// Variables and Constants

var name = "Ted"
name = "Rebecca"
name = "Carlos"

let character = "Daphne"

var playerName = "Rossi"
print(playerName)

playerName = "Pedro"
print(playerName)

playerName = "Leo"
print(playerName)

let manager = "Michael Scott"
let place = "Philadelphia"

// Strings

let actor = "Post Malone"
let fileName = "Brazil.png"
let result = "You Win!"

let movie = """
A day in
the life of an
Developer
"""

let nameLength = actor.count
print(nameLength)

print(result.uppercased())

print(movie.hasPrefix("a day")) // It is not capitalized as in the text
print(movie.hasSuffix("Developer"))

// Numbers

let score = 10
let reallyBig = 1_000_000 //Swift ignores the separator for number cases

let lowerScore = score - 2
let higherScore = score + 30
let doubledScore = score * 2
let squaredScore = score * score
let halvedScore = score / 2

var counter = 10

counter += 5
print(counter)

counter -= 2
counter *= 5
counter /= 3

let number = 120

print(number.isMultiple(of: 3))
print(300.isMultiple(of: 7))

// Decimal Numbers

let decimalNumber = 0.1 + 0.2
print(decimalNumber)

let a = 1
let b = 2.0
let c = Double(a) + b

let double1 = 3.1
let double2 = 3131.3131
let double3 = 3.0
let int1 = 3

var rating = 5.0
rating *= 2
