import Foundation

// Functions

func showMessages() {
    print("You're welcome")
    print("What you want to do?")
    print("I'm excited to play")
}

showMessages()


func printTimesTables(number: Int, end: Int) {
    for i in 1...end {
        print("\(number) x \(i) = \(number * i)")
    }
}

printTimesTables(number: 6, end: 17)


// Functions with return values

func sameString(word1: String, word2: String) -> Bool {
    if word1.sorted() == word2.sorted() {
        return true
    } else {
        return false
    }
}

print(sameString(word1: "abc", word2: "cba"))

// Another alternative for the function above

func sameString2(string1: String, string2: String) -> Bool {
    string1.sorted() == string2.sorted() // When we have only on line of code inside a function we don't need to put the 'return' term.
}

print(sameString(word1: "abc", word2: "bac"))

func pythagoras(a: Double, b: Double) -> Double {
    let input = a * a + b * b
    let root = sqrt(input)
    return root
}

let c = pythagoras(a: 3, b: 4)
print(c)

// Refactoring the function above to have one line of code inside it only
func pythagorasOneLine(a: Double, b: Double) -> Double {
    sqrt(a * a + b * b)
}

let c2 = pythagorasOneLine(a: 3, b: 4)
print(c2)


// Functions return multiple values

func getUser() -> (firstName: String, lastName: String) {
    (firstName: "Taylor", lastName: "Swift")
}

let (firstName, lastName) = getUser()
print("Name: \(firstName)")

// If we want to use just one parameter we can replace the other constant with an underscore
let (_, lastName2) = getUser()
print("Name: \(lastName2)")

// Customizable parameters name

func isUpperCase(_ string: String) -> Bool { // In this case (with underscore before the parameter name) we don't need to pass the parameter name externally
    string == string.uppercased()
}

let string = "HELLO, WORLD"
let result = isUpperCase(string)
print(result)

func printTimesTable2(for number: Int) { // In this case we use the parameter name (number) internally and the term "for" (chose by us) externally
    for i in 1...12 {
        print("\(number) x \(i) = \(number * i)")
    }
}

printTimesTable2(for: 5)


func evaluate(_ input: String) {
    print("Yup")
}


evaluate("test")
