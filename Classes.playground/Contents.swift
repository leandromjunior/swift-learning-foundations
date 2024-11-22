import Foundation

// Classes must have a Constructor/Initializer

class Person {
    var name: String
    var age: Int
    
    init (
        name: String,
        age: Int
    ) {
        self.name = name
        self.age = age
    }
    
    func increaseAge() {
        self.age += 1
    }
}

let Leandro = Person(name: "Leandro", age: 27)

print("Before function:", Leandro.age)
Leandro.increaseAge()
print("After Function:", Leandro.age)

let Hamilton = Leandro
Hamilton.increaseAge()
print("Hamilton after Function:", Hamilton.age)
print("Leandro after Function:", Leandro.age)

// The code above shows that the variables points to the same memory (Because of the class). Let's confirm that below

if Leandro === Hamilton {
    print("Leandro and Hamilton point to the same memory")
} else {
    print("They don't point to the same memory")
}

// Avoiding properties to be changed externally

class Person2 {
    private(set) var age: Int
    
    init(
        age: Int
    ) {
        self.age = age
    }
    
    func increaseAgeTwo() {
        self.age += 2
    }
}

let Gabigol = Person2(age: 26)

// Because of the "private(set) we can't change the variable Gabigol externally as shown below"
// Gabigol.age += 2

// We can only change the variable using the internal function
Gabigol.increaseAgeTwo()
print("Gabigol Age:", Gabigol.age)

// Designated Initializer/Convenience Initializer and Superclasses/Subclasses

class Tesla {
    var manufacturer = "Tesla"
    var model: String
    var year: Int
    
    init() {
        self.model = "X"
        self.year = 2023
    }
    
    init(model: String, year: Int) {
        self.model = model
        self.year = year
    }
    
    convenience init (model: String) {
        self.init(
            model: model,
            year: 2023
        )
    }
}

// Subclassing a superclass

class TeslaModelY: Tesla {
    // We need to create a override init since the superclass already have an initializer, so we can create "another version of it
    
    override init () {
        super.init(
            model: "Y",
            year: 2023
        )
    }
}

let modelY = TeslaModelY()
print(modelY.model)
print(modelY.year)
print(modelY.manufacturer)

// Foundation of Deinitializer (Used the most for notifications)

class MyClass {
    init() {
        print("Initialized")
    }
    
    func doSomething(){
        print("Do Something")
    }
    
    deinit {
        print("Deinitialized")
    }
}

let myClosure = {
    let myClass = MyClass()
    myClass.doSomething()
}

myClosure()
