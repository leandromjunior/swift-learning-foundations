import Foundation

protocol CanBreathe {
    func breathe()
}

// Here the structures are inheriting the protocol

struct Person: CanBreathe {
    func breathe() {
        print("Person Breathing")
    }
}

struct Animal: CanBreathe {
    func breathe() {
        print("Animal Breathing")
    }
}

// Instantiating the variables and calling the functions

let leandro = Person()
leandro.breathe()

let dog = Animal()
dog.breathe()

// Obs.: The function body cannot be created inside the protocol but we can create an extension

protocol CanScratch {
    func scratch()
}

extension CanScratch {
    func scratch() {
        print("Scratching you lovingly...")
    }
}

struct Cat: CanScratch {
    
}

let maya = Cat()
maya.scratch()


protocol HasName {
    var name: String {get}
    var age: Int {get set}
}

struct Dog: HasName {
   // var name: String -> The Swift by default create the variable inside the structure as var but since the variable is readable only, I chose to change for a constant variable (let)
    let name: String
    
    var age: Int

}

var luna = Dog(
    name: "Luna",
    age: 12
)

print(luna.name)
print(luna.age)
luna.age += 1
print(luna.age)

// Example similar to the example above but using extension

protocol HasName2 {
    var name: String {get}
    var age: Int {get set}
    
    mutating func increaseAge()
}

extension HasName2 {
    
    func describeMe() -> String {
        
        return "Your name is \(name) and your are \(age) years old."
    }
    
    mutating func increaseAge() {
        self.age += 1
    }
}

struct Human: HasName2 {
    let name: String
    var age: Int
}

var gabigol = Human(
    name: "Gabriel Barbosa",
    age: 28
)

print(gabigol.describeMe())
gabigol.increaseAge()
print(gabigol.age)


protocol Vehicle {
    var speed: Int {get set}
    
    mutating func increaseSpeed(by value: Int)
}

extension Vehicle {
    mutating func increaseSpeed(by value: Int) {
        self.speed += value
    }
}

struct Bike: Vehicle {
    var speed: Int
    
    init() {
        self.speed = 0 // Just initializing the variable with value 0
    }
}

var bike = Bike()

bike.increaseSpeed(by: 15)
print(bike.speed)

// Using "is" to check if an object conforms to a protocol

func describe(obj: Any) {
    if obj is Vehicle {
        print("Obj conforms to the Vehicle protocol")
    } else {
        print("Obj does not conform to the Vehicle protocol")
    }
}

describe(obj: bike) // Conforms

struct Car {
    
}

let car = Car()

describe(obj: car) // Does not conform

// Using "as?" syntax to check and to promote an object to a specific type

func increaseSpeedIfVehicle(obj: Any) {
    if var vehicle = obj as? Vehicle {
        print(vehicle.speed)
        vehicle.increaseSpeed(by: 20)
        print(vehicle.speed)
    } else {
        print("This was not a vehicle")
    }
}

increaseSpeedIfVehicle(obj: bike)
