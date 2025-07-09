import Foundation

// Arrays

var scores = Array<Int>()
scores.append(100)
scores.append(80)
scores.append(85)
print(scores[1])

var albums = [String]()
albums.append("Folklore")
albums.append("Fearless")
albums.append("Red")
print(albums.count)

var characters = ["Lana", "Pam", "Ray", "Sterling"]
print(characters.count)

characters.remove(at: 2)
print(characters.count)

characters.removeAll()
print(characters.count)

let bondMovies = ["Casino Royale", "Spectre", "No Time to Die"]
print(bondMovies.contains("Frozen"))

let cities = ["London", "Tokyo", "Rome", "Budapest"]
print(cities.sorted())

let presidents = ["Bush", "Obama", "Trumo", "Biden"]
let reversedPresidents = presidents.reversed()
print(reversedPresidents)

// Dictionaries

let employee = ["name" : "Taylor Swift", "job" : "Singer", "location" : "Nashville"]
print(employee["name", default: "Unknown"])
print(employee["job", default: "Unknoen"])
print(employee["location", default: "Unknown"])

let hasGraduated = ["Eric" : true, "Maeve" : false, "Otis" : false]

let olympics = [
    2012 : "London",
    2016 : "Rio de Janeiro",
    2021 : "Tokyo"
]

print(olympics[2012, default: "Unknown"])

var heights = [String : Int]()
heights["Yao Ming"] = 229
heights["Shaquille O'Neal"] = 216
heights["LeBron James"] = 206

var archEnemies = [String : String]()
archEnemies["Batman"] = "The Joker"
archEnemies["Superman"] = "Lex Luthor"
archEnemies["Batman"] = "Penguin" // This one is gonna subscribe the first Batman


// Sets (Don't accept duplicates and don't have order)

var actors = Set<String>()
actors.insert("Denzel Washington") //Unlike arrays, sets use "insert" to add items
actors.insert("Tom Cruise")
actors.insert("Nicolas Cage")
actors.insert("Samuel L Jackson")
actors.insert("Tom Cruise") //Duplicate

print(actors)


// Enums

enum Weekday {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
}

var day = Weekday.monday
day = Weekday.wednesday
day = .friday // In this case, "Weekday" is implicity

print(day)

enum Weekday2 { // Another way to declare enums
    case monday, tuesday, wednesday, thursday, friday
}

// Obs.: Declaring enums avoid to make a mistake like writing a string with a misclick, for example:

var dayF = "Friday "
dayF = Weekday2.saturday // Avoid us to choose a value that is not in our scope
