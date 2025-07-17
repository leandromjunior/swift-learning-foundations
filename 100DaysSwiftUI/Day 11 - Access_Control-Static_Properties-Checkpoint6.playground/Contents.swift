import Foundation

/* Access Control
 
 private -> Don't let anything outside the struct use this.
 fileprivate -> Don't let anything outside the current file use this
 public -> Let anyone, anywhere use this
 
 */

struct BankAccount {
    private var funds = 0
    
    mutating func deposit(amount: Int) {
        funds += amount
    }
    
    mutating func withdraw(amount: Int) -> Bool {
        if funds >= amount {
            funds -= amount
            return true
        } else {
            return false
        }
    }
}

var account = BankAccount()
account.deposit(amount: 100)
let success = account.withdraw(amount: 200)

if success {
    print("Withdrew money successfully")
} else {
    print("Failed to get the money")
}

//account.funds -= 1000 // When a variable is private we can't access it without the struct


struct BankAccount2 {
    private(set) var funds = 0 // When a variable is a private(set) we can't change it outside the struct but we can read it outise the struct
    
    mutating func deposit(amount: Int) {
        funds += amount
    }
    
    mutating func withdraw(amount: Int) -> Bool {
        if funds >= amount {
            funds -= amount
            return true
        } else {
            return false
        }
    }
}

var account2 = BankAccount2()

print(account2.funds) // We can
//account2.funds += 10 // We cannot


// Static properties and methods

struct School {
    static var studentCount = 0
    
    static func add(student: String) {
        print("\(student) joined the school.")
        studentCount += 1
    }
}

School.add(student: "Leandro") //Using static, we can call a method or see a property without needing to make an instance of the struct
print(School.studentCount)

struct AppData {
    static let version = "1.3 beta 2"
    static let saveFilename = "settings.json"
    static let homeURL = "https://www.google.com"
}

print(AppData.version)

struct Employee {
    let username: String
    let password: String
    
    static let example = Employee(username: "lemottajr", password: "h4343536")
}

print(Employee.example)


// Checkpoint 6

struct Car {
    let model: String
    let numberOfSeats: Int
    private(set) var currentGear = 0
    
    mutating func changeGears(up: Bool, down: Bool) {
        
        if up == true && down == true {
            print("The car can't up and down at the same time")
        } else {
            if up {
                if currentGear == 10 {
                    print("The \(model) gear is in it maximum")
                } else {
                    currentGear += 1
                    print("The \(model) gear is up to \(currentGear)")
                }
            }
            
            if down {
                if currentGear == 0{
                    print("The \(model) gear is already neutral")
                } else {
                    currentGear -= 1
                    print("The \(model) gear is down to \(currentGear)")
                }
            }
        }
    }
    
    init(model: String, numberOfSeats: Int) {
        self.model = model
        self.numberOfSeats = numberOfSeats
    }
}

var car = Car(model: "Civic", numberOfSeats: 5)

car.changeGears(up: true, down: false)
car.changeGears(up: true, down: false)
print(car.currentGear)
car.changeGears(up: false, down: true)
car.changeGears(up: false, down: true)
car.changeGears(up: false, down: true)
