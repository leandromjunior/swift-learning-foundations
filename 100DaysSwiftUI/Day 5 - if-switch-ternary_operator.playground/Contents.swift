import Foundation

let speed = 88
let percentage = 85
let age = 18

if speed >= 88 {
    print("Where we're going, so we don't need roads.")
}

if percentage < 85 {
    print("Sorry, you failed the test.")
}

if age >= 18 {
    print("You're eligible to vote.")
}

let myName = "Leandro Motta Junior"
let friendName = "Davi Camargo Oliveira dos Santos"

if myName < friendName {
    print("It's \(myName) vs \(friendName)")
}

if myName > friendName {
    print("It's \(friendName) vs \(myName)")
}

var numbers = [1,2,3]
numbers.append(4)

if numbers.count > 3 {
    numbers.remove(at: 0)
}

print(numbers)

// If Condition

let country = "Canada"

if country == "Australia" {
    print("G'day")
}

let name = "Taylor Swift"

if name != "Anonymous" {
    print("Hello, \(name)")
}

var username = "taylorswift13"

if username.isEmpty {
    username = "Anonymous"
}

print("Welcome, \(username)")


// Multiple Conditions

let userAge = 14
let hasParentPermission = true

if userAge >= 18 || hasParentPermission {
    print("You can buy the game!")
}

enum TransportOption {
    case airplane, helicopter, bicycle, car, scooter
}

let transport = TransportOption.airplane

if transport == .airplane || transport == .helicopter {
    print("Let's fly!")
} else if transport == .bicycle {
    print("I hope there's a bike path...")
} else if transport == .car {
    print("Time to get stuck in the traffic.")
} else {
    print("I'm going to hire a scooter now.")
}


// Switch Case

let place = "Metropolis"

switch place {
case "Gotham":
    print("You're Batman!")
case "Mega-City One":
    print("You're Judge Dredd!")
case "Wakanda":
    print("You're Black Panther!")
default:
    print("Who are you?")
}

let day = 5
print("My true love gave to me...")

switch day {
case 5:
    print("5 golden rings")
    fallthrough // It makes swift print the next switch case
case 4:
    print("4 calling birds")
    fallthrough
case 3:
    print("3 French hens")
    fallthrough
case 2:
    print("2 turtle doves")
    fallthrough
default:
    print("A partridge in a pear tree")
}

// Ternary Conditional Operator

let personAge = 18
let canVote = personAge >= 18 ? "Yes" : "No"
print(canVote)

let hour = 23
print(hour < 12 ? "It's before noon" : "It's after noon")

let names = ["Jayne", "Kaylee", "Mal"]
let crewCount = names.isEmpty ? "No One" : "\(names.count) people"
print(crewCount)

enum Theme {
    case light, dark
}

let theme = Theme.dark

let background = theme == .dark ? "Black" : "White"
print(background)
