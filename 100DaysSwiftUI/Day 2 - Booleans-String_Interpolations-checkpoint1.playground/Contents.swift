import Foundation

// Boolean

let filename = "paris.jpg"
print(filename.hasSuffix(".jpg"))

let number = 120
print(number.isMultiple(of: 2))

let goodDogs = true

var gameOver = false
print(gameOver)
gameOver.toggle() //toggle acts like a switch turning "false" into "true" and vice-versa
print(gameOver)

let isMultiple = 120.isMultiple(of: 3)

// The toggle works like the code below
var isAuthenticated = false
isAuthenticated = !isAuthenticated
print(isAuthenticated)
isAuthenticated = !isAuthenticated
print(isAuthenticated)

// Strings Interpolation

let people = "Haters"
let action = "hate"
let lyric = people + "gonna" + action // This ("+") is useful to interpolate string with another string
print(lyric)

let name = "Taylor"
let age = 26
let message = "Hello, my name is \(name) and I'm \(age) years old." // this is useful to interpolate string with numbers, for example
print(message)

let num = 11
let missionMessage = "Apollo \(num) landed on the moon."

print("5 x 5 is \(5 * 5)") // String interpolation with arithmetic calculation

// Checkpoint 1

let celsius = 30.0

let convertionFahrenheit = ((celsius * 9) / 5) + 32

print("The conversion of \(celsius)°C degree to Fahrenheit is \(convertionFahrenheit)°F")
