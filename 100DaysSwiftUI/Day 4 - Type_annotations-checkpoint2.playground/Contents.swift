import Foundation

// Type Annotation -> Int, Double, String, Bool

let name: String = "Lasso"
var score: Int = 0
var score2: Double = 0.0
var score3: Double = 0

var user: [String: String] = ["id": "@twostraws"]

var books: Set<String> = Set(["The Bluest Eye", "Foundation", "Girl, Woman, other"])

var soda: [String] = ["Coke", "Pepsi", "Ïrn-Bru"]

//different ways to define an empty array with type annotation
var teams: [String] = [String]()
var cities : [String] = []
var clues = [String]()

enum UIStyle {
    case light, dark, system
}

var style: UIStyle = UIStyle.light
style = .dark

// Checkpoint 2

let soccerTeams: [String] = ["Flamengo", "Palmeiras", "Gremio", "Bahia", "Gremio"]

print("Number of items in the array: \(soccerTeams.count)")

let uniqueValues = Set(soccerTeams)
print("Number of unique items in the array: \(uniqueValues.count)")
