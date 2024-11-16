import Foundation

struct Person {
    let name: String
    let age: Int
}

let Carlos = Person(name: "Carlos", age: 46)

print(Carlos.name)
print(Carlos.age)

// Strcutures with costum constructors/initializers

struct MacBook {
    let name: String
    let manufacturer: String
    init(name: String) {
        self.name = name
        self.manufacturer = "Apple"
    }
}

let pro = MacBook(
    name: "MacBook Pro 16"
)

let air = MacBook(
    name: "MacBook Air 13"
)

print(pro.name)
print(pro.manufacturer)

print(air.name)
print(air.manufacturer)

// The same thing of the code above but in a different way

struct MacBook2 {
    let name: String
    let manufacturer = "Apple"
}

let pro2 = MacBook2(
    name: "MacBook Pro 16"
)

let air2 = MacBook2(
    name: "MacBook Air 13"
)

print(pro2.name)
print(pro2.manufacturer)

print(air2.name)
print(air2.manufacturer)

// Computer Properites -> Return values by assigning a function to the property of the structure

struct Person2 {
    let firstName: String
    let lastName: String
    var fullName: String {
        "\(firstName) \(lastName)"
    }
}

let person2Example = Person2(
    firstName: "Gabriel",
    lastName: "Barbosa"
)

print(person2Example.firstName)
print(person2Example.lastName)
print(person2Example.fullName)



// Subclasses

struct Bike {
    let manufacturer: String
    let currentSpeed: Int
    func copyMutable(currentSpeed: Int) -> Bike {
        Bike(manufacturer: self.manufacturer, currentSpeed: currentSpeed)
    }
}

let bike1 = Bike(manufacturer: "Caloi", currentSpeed: 10)

let bike2 = bike1.copyMutable(currentSpeed: 25) // Here we can just mutate the current speed and keeping the same manufacturer

let bike3 = Bike(manufacturer: "HD", currentSpeed: 20)

print(bike1.currentSpeed)

print(bike2.currentSpeed)

print(bike3.currentSpeed)
print(bike3.manufacturer)

