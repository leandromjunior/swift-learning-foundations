import Foundation

// Default Values for parameters

func printTimesTables(for number: Int, end: Int = 10) {
    for i in 1...end {
        print("\(number) x \(i) = \(number * i)")
    }
}

printTimesTables(for: 3, end: 12)
print()
printTimesTables(for: 2) //Because the parameter "end" has a default value we not necessarily have to pass a value for it.

// Handle Errors in functions (Throwing Functions)

enum PasswordError: Error {
    case short, obvious
}

func checkPassword(_ password: String) throws -> String {
    if password.count < 5 {
        throw PasswordError.short
    }
    
    if password == "12345" {
        throw PasswordError.obvious
    }
    
    if password.count < 8 {
        return "OK"
    } else if password.count < 10 {
        return "Good"
    } else {
        return "Excellent"
    }
}

let string = "12345"

do {
    let result = try checkPassword(string)
    print("Password Rating: \(result)")
} catch PasswordError.short{
    print("Please use a longer password.")
} catch PasswordError.obvious {
    print("I have the same password on my luggage!")
} catch {
    print ("There was an error.")
}

// Checkpoint 4

// Calculate square root with no built-in functions

enum PossibleErrors: Error {
    case outOfBound
    case notInteger
    case noRoot
}

func resultSquareRoot(number: Int) throws -> Int {
    
    var squareRoot: Int = 0
    if number < 1 || number > 10_000 {
        throw PossibleErrors.outOfBound
    }
    
    for i in 1...100 {
        if i * i == number {
            squareRoot = i
            break
        }
    }
    
    if squareRoot == 0 {
        throw PossibleErrors.noRoot
    }
            
    return squareRoot
}

do {
    let result = try resultSquareRoot(number: 10_000)
    print("The Square Root is: \(result)")
} catch PossibleErrors.outOfBound {
    print("The number is less than 1 or greater than 10,000")
} catch PossibleErrors.noRoot {
    print("It does not have a square root of this number.")
}
