import Foundation

enum Animals {
    case cat
    case dog
    case turtle
}

let cat = Animals.cat

print(cat)

if cat == Animals.cat {
    print("This is a cat!")
} else if cat == Animals.dog {
    print("This is NOT a cat. It's a dog!")
} else {
    print("This is something else")
}

// Doing the same thing with Switch Case, which is more practical and common
switch cat {
    
case .cat:
    print("This is a cat!!")
    break
case .dog:
    print("This is NOT a cat. It's a dog!")
    break
case .turtle:
    print("This is a Turtle!")
    break

}

// Obs.: Switch Case must be exhaustive, this means that switch case must cover all the cases OR using the default annotation as shown below

let dog = Animals.dog

switch dog {
    
case .cat:
    print("This is NOT a dog. It's a Cat!")
    break
case .dog:
    print("This is a dog!")
    break
default:
    print("This is something else")
    
}

// Enumerations with Associated Values

enum Shortcut {
    case fileOrFolder(path: URL, name: String)
    case wwwUrl(path: URL)
    case song(artist: String, songName: String)
}

let wwwApple = Shortcut.wwwUrl(path: URL(string: "https://apple.com")!)

switch wwwApple {
    
case .fileOrFolder(path: let path, name: let name):
    print(path)
    print(name)
    break
case .wwwUrl(path: let path):
    print(path)
    break
case .song(artist: let artist, songName: let song):
    print(artist)
    print(song)
    break
}

// Simpler way to write the code above (Removing the external argument)

switch wwwApple {
    
case .fileOrFolder(let path, let name):
    print(path)
    print(name)
    break
case .wwwUrl(let path):
    print(path)
    break
case .song(let artist, let song):
    print(artist)
    print(song)
    break
}

// even more simpler way to write the code above (Removing each "let" and writing after the case, so the "let" is applied to all variables in the case)

switch wwwApple {
    
case let .fileOrFolder(path, name):
    print(path)
    print(name)
    break
case let .wwwUrl(path):
    print(path)
    break
case let .song(artist, song):
    print(artist)
    print(song)
    break
}

// If statement with case and enumerations

if case let .wwwUrl(path) = wwwApple {
    print(path)
}

let dieForMe = Shortcut.song(artist: "Post Malone", songName: "Die For Me")

if case let .song(artist, songName) = dieForMe {
    print(songName)
}

// In the example above, the artist is ignored
if case let .song(_, songName) = dieForMe {
    print(songName)
}

// Enumerations with computed property

enum Vehicle {
    case car (manufacturer: String, model: String)
    case bike (manufacturer: String, yearMade: Int)
    
    var manufacturer: String {
        
        switch self {
            
        case let .car(manufacturer, _):
            return manufacturer
        case let .bike(manufacturer, _):
            return manufacturer
        }
    }
}

let car = Vehicle.car(manufacturer: "Honda", model: "Civic")

print(car.manufacturer)

let bike = Vehicle.bike(manufacturer: "Oxer", yearMade: 1981)

print(bike.manufacturer)

// Enumerations with raw values

enum FamilyMember: String {
    case father = "Dad"
    case mother = "Mom"
    case brother = "Bro"
    case sister = "Sis"
}

print(FamilyMember.father.rawValue)
print(FamilyMember.brother.rawValue)

enum FavoritePlayer: String, CaseIterable {
    case ca = "Gabigol"
    case mid = "Arrascaeta"
    case def = "Ortiz"
}

print(FavoritePlayer.allCases)
print(FavoritePlayer.allCases.map(\.rawValue))

if let ca = FavoritePlayer(rawValue: "Gabigol") {
    print("Found Gabi")
    print(ca)
} else {
    print("This player does not exist")
}

// Mutating Function in enum

enum Height{
    case short
    case medium
    case long
    
    mutating func makeLong() {
        self = Height.long
    }
}

var myHeight = Height.medium
print(myHeight)

myHeight.makeLong()
print(myHeight)

