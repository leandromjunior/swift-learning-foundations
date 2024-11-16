import Foundation

let add: (Int, Int) -> Int = {(a: Int, b: Int) -> Int in a + b}

print(add(30,50))

// Passing a function (closure) to another function
// In the line below, the first Int returning refers to the function inside and the second Int returning refers to the main function

func customAdd(_ a: Int, _ b: Int, using functionAsClosure: (Int, Int) -> Int) -> Int {
    functionAsClosure(a, b)
}

print(customAdd(20, 30, using: { (a: Int, b: Int) -> Int in a + b }))

// Another simpler way to pass the same function above (removing the column after the second parameter and the calling of the "using" argument)
print(customAdd(30, 40) { (a: Int, b: Int) -> Int in a + b })

// Another way to pass the same function but less verbose
// Obs.: Not necessarily the way below will compile the code faster, contrary to what we think, declaring the variables again like the way above will make it easier to the compiler "understand" the types, for example, and don't waste time searching for it.

customAdd(50, 50) { a, b in
    a + b
}

// Another way to pass the same function

customAdd(100, 100) { $0 + $1 }

let ages = [30, 20, 19, 40]

ages.sorted(by: {(a: Int, b: Int) -> Bool in a > b})

// Another way to do the same thing above but simpler

ages.sorted(by: > )

// Passing functions to closures

func add10To(_ value: Int) -> Int {
    value + 10
}

func add20To(_ value: Int) -> Int {
    value + 20
}

// In the function below we have just one parameter (Int) because the functions add10To and add20To have one parameter only
func doAddition(on value: Int, using function: (Int) -> Int) -> Int {
    function(value)
}

doAddition(on: 20, using: add10To(_:))

doAddition(
    on: 20,
    using: add20To(_:))
