import Foundation

// For Loop

let platforms = ["iOS", "macOS", "tvOS", "watchOS"]

for platform in platforms {
    print("Swift works great on \(platform)")
}

for i in 1...12 {
    print("5 x \(i) is \(5 * i)")
}

for i in 1...5 {
    print("The \(i) times table")
    
    for j in 1...5 {
        print("    \(j) x \(i) is \(j * i)")
    }
    
    print()
}

for i in 1...5 {
    print("Counting from 1 through 5: \(i)")
}

for i in 1..<5 {
    print("Counting from 1 up to 5: \(i)")
}


var lyric = "Haters gonna"

for _ in 1...5 { // if we don't want to name a variable and consequently not using it inside the loop
    lyric += " hate"
}

print(lyric)

// While Loop

var countdown = 10

while countdown > 0 {
    print("\(countdown)...")
    
    countdown -= 1
}

print("Blast Off")

let id = Int.random(in: 1...1000) //To random among integer numbers
let amount = Double.random(in: 0...1) // To random among Double numbers

var roll = 0

while roll != 20 {
    roll = Int.random(in: 1...20)
    print("I rolled a \(roll)")
}
print("Critical hit!")


var number = 10

while number > 0 {
    number -= 2
    if number.isMultiple(of: 2) {
        print("\(number) is even")
    }
}


// Skip loop (break and continue)

let filenames = ["me.jpg", "work.txt", "sophie.jpg"]

for filename in filenames {
    if filename.hasSuffix(".jpg") {
        continue
    }
    
    print(filename)
}

let number1 = 4
let number2 = 14
var multiples = [Int]()

for i in 1...1000 {
    if i.isMultiple(of: number1) && i.isMultiple(of: number2) {
        multiples.append(i)
        
        if multiples.count == 10 {
            break
        }
    }
}

print(multiples)


// Checkpoint 3

for i in 1...100 {
    if i.isMultiple(of: 3) && i.isMultiple(of: 5) {
        print("FizzBuzz")
    } else if i.isMultiple(of: 3) {
        print("Fizz")
    } else if i.isMultiple(of: 5) {
        print("Buzz")
    } else {
        print(i)
    }
}

// Alternative for the checkpoint challenge using While Loop

var c = 1

while c <= 100 {
    if c.isMultiple(of: 3) && c.isMultiple(of: 5) {
        print("FizzBuzz")
    } else if c.isMultiple(of: 3) {
        print("Fizz")
    } else if c.isMultiple(of: 5) {
        print("Buzz")
    } else {
        print(c)
    }
    
    c += 1
}
