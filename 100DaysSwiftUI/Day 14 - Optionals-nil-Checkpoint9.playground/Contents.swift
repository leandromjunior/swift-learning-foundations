import Foundation

// Optionals

var username: String? = nil

if let unWrapped = username {
    print("We got something, look: \(unWrapped)")
} else {
    print("The optional is empty")
}

username = "Hey buddy!"

if let unWrapped2 = username {
    print("We got something, look: \(unWrapped2)")
} else {
    print("The optional is empty")
}

func square(number: Int) -> Int {
    return number * number
}

var number: Int? = nil

// It's common to use the same name of the variable for the 'íf let'
if let number = number{
    print(square(number: number))
}

let album = "Red"
let albums = ["Reputation", "Red", "1989"]

if let position = albums.firstIndex(of: album) {
    print("Found")
}

// Guard let (Run if the variable doesn't have a value inside)

func printSquare(of number: Int?) {
    guard let number = number else {
        print("Missing Input")
        
        // We MUST exit the function here
        return
    }
    
    // number is still available outside of 'guard'
    print("\(number) x \(number) is \(number * number)")
    
}

var myVar: Int? = 3
printSquare(of: myVar)

myVar = nil
printSquare(of: myVar)

// Nil Coalescing

let captains = [
    "Enterprise": "Picard",
    "Voyager": "Janeway",
    "Defiant": "Sisko"
]

let new = captains["Serenity"] // This key doesn't exist in the dictionary, so it returns a new to the constant

let new2 = captains["Serenity"] ?? "N/A" // Here we can see this in action
print(new2)

let new3 = captains["Serenity", default: "N/A"] // It has the same behavior
print(new3)

let tvShows = ["Archer", "Babylon 5", "Ted Lasso"]
let favorite = tvShows.randomElement() ?? "None"
print(favorite)

struct Book {
    let title: String
    let author: String?
    
}

let book = Book(title: "BeWolf", author: nil)
let author = book.author ?? "Anonymous"
print(author)

let book2 = Book(title: "Type X", author: "Arthur")
let author2 = book2.author ?? "Anonymous"
print(author2)

let input = ""
let num = Int(input) ?? 0 // The constant input is empty, so it returns an optional because it isn't possible to convert nothing into Integer
print(num)


// Optional Chaining

let names = ["Arya", "Bran", "Robb", "Sansa"]

let chosen = names.randomElement()?.uppercased() ?? "No One"
print("Next in line: \(chosen)")

struct Movie {
    let title: String
    let director: String?
}

var movie: Movie? = nil
let director = movie?.director?.first?.uppercased() ?? "A"
print(director)

// Function Failure with optionals

enum UserError: Error {
    case badID, networkFailed
}

func getUser(id: Int) throws -> String {
    throw UserError.networkFailed
}

if let user = try? getUser(id: 23) {
    print("User: \(user)")
}

let user = (try? getUser(id: 23)) ?? "Anonymous"
print(user)


// Checkpoint 9

func retInt(arr: [Int]?) -> Int { arr?.randomElement() ?? Int.random(in: 1...100) }

print(retInt(arr: nil))
print(retInt(arr: [1,4,7,9,10,14]))
