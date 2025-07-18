import Foundation

// Class

class Game {
    var score = 0 {
        didSet {
            print("Score is now: \(score)")
        }
    }
}

var game = Game()
game.score += 10


// Class Inheritance

class Employee {
    let hours: Int
    
    init(hours: Int) {
        self.hours = hours
    }
}

class Developer: Employee {
    
    func work() {
        print("I'm writing code for \(hours) hours.") // WE can use a variable from a parent class in a child class
    }
}

class Manager: Employee {
    
    func work() {
        print("I'm going to meetings for \(hours) hours.")
    }
}

let robert = Developer(hours: 8)
let joseph = Manager(hours: 10)
robert.work()
joseph.work()


class Employee2 {
    let hours: Int
    
    init(hours: Int) {
        self.hours = hours
    }
    
    func printSummary() {
        print("I work \(hours) hours a day.")
    }
}

class Developer2: Employee2 {
    
    func work() {
        print("I'm writing code for \(hours) hours.") // WE can use a variable from a parent class in a child class
    }
}

final class Manager2: Employee2 { //The 'final' word means that this class cannot be inherited from another
    
    func work() {
        print("I'm going to meetings for \(hours) hours.")
    }
}

let novall = Developer2(hours: 12)
novall.printSummary()


class Developer3: Employee2 {
    
    func work() {
        print("I'm writing code for \(hours) hours.") // WE can use a variable from a parent class in a child class
    }
    
    override func printSummary() { // This will override (replace/customize) the parent 'Employee2' function
        print("I'm a developer who will sometimes work \(hours) hours a day, but other times spend hours arguing about whether code should be indented using tabs or spaces")
    }
}

let jon = Developer3(hours: 4)
jon.printSummary()


// Add Initializers for classes

class Vehicle {
    var isElectric: Bool
    
    init(isElectric: Bool) {
        self.isElectric = isElectric
    }
}

class Car: Vehicle {
    var isConvertible: Bool
    
    init(isElectric: Bool, isConvertible: Bool) {
        self.isConvertible = isConvertible
        super .init(isElectric: isElectric) // We need to use the property of the super class (parent) in the subclass initializer (if the subclass have an init)
    }
}

let teslaX = Car(isElectric: true, isConvertible: false)

// This works too
class Car2: Vehicle {
    var isConvertible: Bool = false
}

let teslaY = Car2(isElectric: true)

// Copying Classes

class User {
    var username = "Anonymous"
}

var user1 = User()

var user2 = user1
user2.username = "Taylor"

print(user1.username) // Taylor
print(user2.username) // Taylor

class User2 {
    var username = "Anonymous"
    
    func copy() -> User2 {
        let user = User2()
        user.username = username
        return user
    }
}

var user3 = User2()
var user4 = user3.copy()
user4.username = "Posty"

print(user3.username) // Anonymous
print(user4.username) // Posty

// Creating Deinitializer for classes

class User5 {
    let ID: Int
    
    init(ID: Int) {
        self.ID = ID
        print("User \(ID): I'm alive!")
    }
    
    deinit { // The deinitializer gets run when the last class instance gets destroyed
        print("User \(ID): I'm dead!")
    }
}

for i in 1...3 {
    let user = User5(ID: i)
    print("User \(user.ID): I'm in control!")
}

var users = [User5]()

for i in 1...3 {
    let user = User5(ID: i)
    print("User \(user.ID): I'm in control!")
    users.append(user)
}

print("Loop is finished!")
users.removeAll()
print("Array is clear!")


// Working with variables inside classes

class Person {
    var name = "Paul"
}

let person = Person()
person.name = "Taylor"
print(person.name)

var person2 = Person()
person2.name = "Taylor"
person2 = Person() // Here we atributed the class to person2 again, it's allowed because it's a var
print(person2.name)

let person3 = Person()
person3.name = "Taylor"
person3 = Person() // Here it's not allowed because it's a constant
print(person3.name)


// Checkpoint 7

class Animal {
    var legs: Int
    
    init(legs: Int) {
        self.legs = legs
    }
}

class Dog: Animal {
    
    func speak() {
        print("AuAuAu")
    }
}

final class Corgi: Dog {
    
    override func speak() {
        print("AuAu")
    }
}

final class Poodle: Dog {
    
    override func speak() {
        print("Au")
    }
}

class Cat: Animal {
    var isTame: Bool
    
    func speak() {
        print("Meow")
    }
    
    init(legs: Int, isTame: Bool) {
        self.isTame = isTame
        super .init(legs: legs)
    }
}

class Persian: Cat {
    override func speak() {
        print("Meoow")
    }
}

class Lion: Cat {
    
    override func speak() {
        print("Meoooooooooooooowwwwww")
    }
}

let poodle = Poodle(legs: 4)
poodle.speak()

let corgi = Corgi(legs: 4)
corgi.speak()

let dog = Dog(legs: 4)
dog.speak()

let cat = Cat(legs: 4, isTame: true)
cat.speak()

let persian = Persian(legs: 4, isTame: false)
persian.speak()

let lion = Lion(legs: 4, isTame: false)
lion.speak()
