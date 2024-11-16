import Foundation // It's the "default" library of Swift

let MyName = "Crystal"

var YourName = "Palace"
print(YourName.uppercased())

// MyName = YourName --> We cannot assign any value to MyName because let variables are immutable

let names_let = [MyName, YourName]
// names_let.append("Manchester") --> We cannot add another elemento into the array because let arrays are immutable as well as its variables

var names_var = [MyName, YourName]

names_var.append("Manchester")
names_var.append("WestHam")

var copy = names_let // If we create a var variable and make it a copy of a let variable, it can be "mutated"
copy.append("City")
