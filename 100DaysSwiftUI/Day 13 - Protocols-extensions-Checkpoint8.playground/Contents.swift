import Foundation

// Protocol

protocol Vehicle {
    var name: String { get }
    var currentPassengers: Int { get set }
    func estimateTime(for distance: Int) -> Int
    func travel(distance: Int)
}

struct Car: Vehicle {
    let name = "Car"
    var currentPassengers = 3
    func estimateTime(for distance: Int) -> Int {
        return distance/50
    }
    
    func travel(distance: Int) {
        print("I'm driving \(distance)km.")
    }
    
    func openSunRoof() {
        print("It's a nice day.")
    }
}

struct Bycicle: Vehicle {
    let name = "Bycicle"
    var currentPassengers = 1
    func estimateTime(for distance: Int) -> Int {
        return distance/10
    }
    
    func travel(distance: Int) {
        print("I'm cycling \(distance)km.")
    }
}

func commute(distance: Int, using vehicle: Vehicle) {
    if vehicle.estimateTime(for: distance) > 100 {
        print("That's too slow! I'll try a diferent vehicle.")
    } else {
        vehicle.travel(distance: distance)
    }
}

func getTravelEstimate(using vehicles: [Vehicle], distance: Int) {
    for vehicle in vehicles {
        let estimate = vehicle.estimateTime(for: distance)
        print("\(vehicle.name): \(estimate) hours to travel \(distance)km.")
    }
}

let car = Car()
commute(distance: 100, using: car)

let bike = Bycicle()
commute(distance: 50, using: bike)

getTravelEstimate(using: [car, bike], distance: 150)


// Opaque return types

func getRandomNumber() -> some Equatable {
    Int.random(in: 1...6)
   // Double.random(in: 1...6) if we decided to change the type from Int to Double, swift would not complsin, because the 'some Equatable' return allows this
}

func getRandomBool() -> some Equatable {
    Bool.random()
}

print(getRandomNumber() == getRandomNumber())


// Extensions

struct Book {
    let title: String
    let pageCount: Int
    let readingHours: Int
    
    init(title: String, pageCount: Int) {
        self.title = title
        self.pageCount = pageCount
        self.readingHours = pageCount / 50
    }
}

let book = Book(title: "Test", pageCount: 200) // In this case the swift do not let us to pass the reading hours, as long as we create an extension

struct Book2 {
    let title: String
    let pageCount: Int
    let readingHours: Int
}

extension Book2 {
    init(title: String, pageCount: Int) {
        self.title = title
        self.pageCount = pageCount
        self.readingHours = pageCount / 50
    }
}

let book2 = Book2(title: "Test", pageCount: 200, readingHours: 13)
print(book2.readingHours)

// Protocol Extensions

extension Array {
    var isNotEmpty: Bool {
        isEmpty == false
    }
}

let guests = ["Mario", "Luigi", "Peach"]

if guests.isNotEmpty {
    print("Guest count: \(guests.count)")
}

protocol Person {
    var name: String { get }
    func sayHello()
}

extension Person { //With a protocol extension, swift do not force we to implement the function into the struct, for example
    func sayHello() {
        print("Hi, I'm \(name)")
    }
}

struct Employee: Person {
    let name: String
}

let taylor = Employee(name: "Taylor")
taylor.sayHello()


// Checkpoint 8

protocol Building {
    var numberOfRooms: Int { get }
    var cost: Int { get }
    var estateAgent: String { get set }
    
    func salesSummary()
}

extension Building {
    func salesSummary() {
        print("The building has \(numberOfRooms) rooms and it costs USD \(cost). Contact our Estate Agent \(estateAgent) for more details.")
    }
}

struct House: Building {
    let numberOfRooms: Int
    let cost: Int
    var estateAgent: String
}

struct Office: Building {
    let numberOfRooms: Int
    let cost: Int
    var estateAgent: String
}

let house = House(numberOfRooms: 3, cost: 200_000, estateAgent: "Alicia")
let office = Office(numberOfRooms: 6, cost: 100_000, estateAgent: "Patrick")

house.salesSummary()
office.salesSummary()

protocol BuildingUpdated {
    var numberOfRooms: Int { get }
    var baseCost: Int { get set }
    var estateAgent: String { get set }
    
    func salesSummary()
}

extension BuildingUpdated {
    var cost: Int {
        return baseCost * numberOfRooms
    }
    func salesSummary() {
        print("The building has \(numberOfRooms) rooms and it costs USD \(cost). Contact our Estate Agent \(estateAgent) for more details.")
    }
}

struct HouseUpdated: BuildingUpdated {
    let numberOfRooms: Int
    var baseCost: Int
    var estateAgent: String
}

struct OfficeUpdated: BuildingUpdated {
    let numberOfRooms: Int
    var baseCost: Int
    var estateAgent: String
}

let houseUpdated = HouseUpdated(numberOfRooms: 3, baseCost: 200_000, estateAgent: "Alicia")
let officeUpdated = OfficeUpdated(numberOfRooms: 6, baseCost: 100_000, estateAgent: "Patrick")

houseUpdated.salesSummary()
officeUpdated.salesSummary()
