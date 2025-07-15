import Foundation

// Closures

// Starting with a closure that returns nothing
let sayHello = {
    print("Hi there!")
}

sayHello()


// Now a closure that receives a String and returns a String either
let sayHelloToYou = { (name: String) -> String in
    return "Hi, \(name)"
}

print(sayHelloToYou("Taylor")) // We don't use parameter name calling a closure, only the value


let team = ["Gloria", "Suzanne", "Piper", "Tiffany", "Tasha"]

// Let's write a normal function and after "translate" it to a closure
func captainFirstSorted(name: String, name2: String) -> Bool {
    if name == "Suzanne" {
        return true
    } else if name2 == "Suzanne" {
        return false
    }
    
    return name < name2
}

let captainFirstTeam = team.sorted(by: captainFirstSorted)
print(captainFirstTeam)

// Translating the fucntion above into a closure (passing it directly into a constant)
let captainFirstTeam2 = team.sorted(by: {(name: String, name2: String) -> Bool in
    if name == "Suzanne" {
        return true
    } else if name2 == "Suzanne" {
        return false
    }
    
    return name < name2
})

print(captainFirstTeam2)


// Trailing Closures and Short Hand

let captainFirstTeam3 = team.sorted(by: {name, name2 in // The function "Sorted" already infers that we must pass two strings and return a bool, so we don't need to repeat this as it shows here
    return false
})

let captainFirstTeam4 = team.sorted {name, name2 in // When passing a closure inside a function, we don't need to put the parenthesis and much less the parameter name
    if name == "Suzanne" {
        return true
    } else if name2 == "Suzanne" {
        return false
    }
    
    return name > name2
}

// The syntax could be even shorter (Caution: This writing can be a little bit confusing)

let captainFirstTeam5 = team.sorted {
    if $0 == "Suzanne" {
        return true
    } else if $1 == "Suzanne" {
        return false
    }
    
    return $0 > $1
}

// Even shorter

let reverseTeam = team.sorted {
    return $0 > $1
}

// Short Hand syntax (One line of code)
let reverseTeam2 = team.sorted { $0 > $1 }

let tOnly = team.filter { $0.hasPrefix("T") }
print(tOnly)

let uppercaseTeam = team.map { $0.uppercased() }
print(uppercaseTeam)

// Accepting functions as parameters

func makeArray(size: Int, using generator: () -> Int) -> [Int] { // This is a trailing closure: generator: () -> Int
    var numbers = [Int]() // Empty Array
    
    for _ in 1...size {
        let newNumber = generator()
        numbers.append(newNumber)
    }
    
    return numbers
}

let rolls = makeArray(size: 50) {
    Int.random(in: 1...20)
}

print(rolls)


// We can also implement a function to pass, as shown below
func generateNumber() -> Int {
    Int.random(in: 1...20)
}

let newRolls = makeArray(size: 50, using: generateNumber)
print(newRolls)

//We can pass more than one function as parameter
func doImportantWork(first: () -> Void, second: () -> Void, third: () -> Void) {
    print("About to start first work")
    first()
    print("About to start second work")
    second()
    print("About to start third work")
    third()
    print("Done")
}

doImportantWork {
    print("This is the first work")
} second: {
    print("This is the second work")
} third: {
    print("This is the third work")
}


// Checkpoint 5

let luckyNumber = [7,4,38,21,16,15,12,33,31,49]

let onlyOddNumber = luckyNumber.filter { $0 % 2 != 0 }
print(onlyOddNumber)

let onlyOddNumberSorted = onlyOddNumber.sorted { $0 < $1 }
print(onlyOddNumberSorted)

let onlyOddNumberSortedMapped = onlyOddNumberSorted.map {"\($0) is a lucky number"}

for i in onlyOddNumberSortedMapped {
    print(i)
}
