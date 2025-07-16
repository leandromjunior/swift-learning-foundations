import Foundation

// Structs

struct Album {
    let title: String
    let artist: String
    let year: Int
    
    func printSummary() {
        print("\(title) (\(year)) by \(artist)")
    }
}

let red = Album(title: "Red", artist: "Taylor Swift", year: 2012)
let metallica = Album(title: "Master of Puppets", artist: "Metallica", year: 1986)

print(metallica.title)
print(red.artist)

red.printSummary()
metallica.printSummary()


struct Employee {
    let name: String
    var vacationRemaining: Int
    
    mutating func takeVacation(days: Int) { // because the function update a variable, it's needed to pass the term "mutating", if the func only read, the term would not be necessary
        if vacationRemaining > days {
            vacationRemaining -= days
            print("Good Holidays")
            print("Days Remaining: \(vacationRemaining)")
        } else {
            print("Oops! There aren't enough days remaining!")
        }
    }
}


var archer = Employee(name: "Sterling Archer", vacationRemaining: 14)
archer.takeVacation(days: 5) // When a function is inside a struct it becames a method
print(archer.vacationRemaining)


struct Employee2 {
    let name: String
    var vacationRemaining: Int = 14
    
    mutating func takeVacation(days: Int) { // because the function update a variable, it's needed to pass the term "mutating", if the func only read, the term would not be necessary
        if vacationRemaining > days {
            vacationRemaining -= days
            print("Good Holidays")
            print("Days Remaining: \(vacationRemaining)")
        } else {
            print("Oops! There aren't enough days remaining!")
        }
    }
}

// When a variable/constant inside a struct comes with a default value we don't need to pass in the call, but we can if we want
var kane = Employee2(name: "Lana Kane")
let poovey = Employee2(name: "Pam Poovey", vacationRemaining: 35)

print(kane.takeVacation(days: 7))
print(kane.vacationRemaining)


// Computed Property

struct Employee3 {
    let name: String
    var vacationAllocated = 14
    var vacationTaken = 0
    
    var vacationRemaining: Int {
        vacationAllocated - vacationTaken
    }
}

var dexter = Employee3(name: "Dexter Morgan")
dexter.vacationTaken += 4
print(dexter.vacationRemaining)
dexter.vacationTaken += 4
print(dexter.vacationRemaining)


//We can handle directly the computed property "vacationRemaining" using getter and setter
struct Employee4 {
    let name: String
    var vacationAllocated = 14
    var vacationTaken = 0
    
    var vacationRemaining: Int {
        get {
            vacationAllocated - vacationTaken
        }
        
        set {
            vacationAllocated = vacationTaken + newValue
        }
    }
}

var arthur = Employee4(name: "Arthur Mitchell")
arthur.vacationTaken += 4
arthur.vacationRemaining = 5
print(arthur.vacationAllocated)


// Property Changes (Observers can only be "attached" to a var. Never to constants, because constants never change)

//The code bellow might be exhaustive to write
struct Game {
    var score = 0
}

var game = Game()
game.score += 10
print("Score is now: \(game.score)")
game.score -= 3
print("Score is now: \(game.score)")
game.score += 1

// Instead, we can use observers to do the job for us
struct Game2 {
    var score = 0 {
        didSet { // Print AFTER the variable change
            print("Score is now: \(score)")
        }
    }
}

var game2 = Game2()
game2.score += 10
game2.score -= 3
game2.score += 1

struct App {
    var contacts = [String]() {
        willSet { // Print BEFORE the variable change
            print("Current value is: \(contacts)")
            print("New value will be: \(newValue)")
        }
        
        didSet {
            print("There are now: \(contacts.count) contacts")
            print("Old value was: \(oldValue)")
        }
    }
}

var app = App()
app.contacts.append("Walter")
app.contacts.append("Saul")
app.contacts.append("Jessie")


// Initializers

struct Player {
    let name: String
    let shirtNumber: Int
    
    init(n: String, shirt: Int) {
        self.name = n
        self.shirtNumber = shirt
    }
}


struct Player2 {
    let name: String
    let shirtNumber: Int
    
    // We don't need to pass all the defined variables as parameters, but we NEED to use all of them into the init as shown bellow
    init(name: String) {
        self.name = name
        shirtNumber = Int.random(in: 1...99) //In this case, we didn't want to be a value passed by parameter, but a value generated automatically instead
    }
}

let player2 = Player2(name: "Megan")
print(player2.shirtNumber)

// As soon as we add a custom initializer for our struct, the default (swift) memberwise initializer goes away. If we want it to stay, we need to move our initializer to an extension, for example

struct Employee5 {
    var name: String
    var yearsActive = 0
}

extension Employee5 {
    init() {
        self.name = "Anonymous"
        print("Creating an anonymous employee")
    }
}

// Creating a named employee now works
let roslin = Employee5(name: "Laura Roslin")

// as does creating an anonymous employee
let anon = Employee5()
