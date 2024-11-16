import Foundation

// Function in Swift are named in Camel Case

func noArgumentsAndNoReturnValue() {
    print("I don't know what I'm doing")
}

noArgumentsAndNoReturnValue()

func plusTwo(value: Int) {
    let newValue = value + 2
    
    print(newValue)
    
}

plusTwo(value: 20)

// When a function must return some result, we need to pass the data type after the stated argument (-> Int ; -> String; etc)

func newPlusTwo(value: Int) -> Int {
    
    return value + 2
}

let npt = newPlusTwo(value: 48)
print(npt)

// Or just
print(newPlusTwo(value: 48))

func customAdd(value1: Int, value2: Int) -> Int {
    value1 + value2 // here we have an implicity return. It's the same wether we write: return value1 + value2
}

let customAdded = customAdd(value1: 50, value2: 50)
print (customAdded)

// Or
print(customAdd(value1: 50, value2: 50))

// We can create functions that don't need the argument to be passed at the moment we're calling the function
func customMinus(_ value1: Int, _ value2: Int) -> Int {
    value1 - value2
}

let customMinusResult = customMinus(50, 40)
print(customMinusResult)

// Or
print(customMinus(50, 40))

customAdd(value1: 20, value2: 21)

// Nested Function
func doSomething(with value: Int) -> Int {
    func mainLogic(value: Int) -> Int {
        value + 2
    }
    
    return mainLogic(value: value + 3)
}

let dsResult = doSomething(with: 30)
print(dsResult)


func getFullName(firstName: String = "Leandro", lastName: String = "Junior") -> String {
    return "\(firstName) \(lastName)"
}

let fullNameDefault = getFullName()
print(fullNameDefault)

let fullNameFirstName = getFullName(firstName: "Roger")
print(fullNameFirstName)

let fullNameLastName = getFullName(lastName: "Motta")
print(fullNameLastName)

let fullNameUpdated = getFullName(firstName: "Roger", lastName: "Motta")
print(fullNameUpdated)
