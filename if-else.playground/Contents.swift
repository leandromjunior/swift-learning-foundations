import Foundation

let myName = "Leandro"
let myAge = 26
let yourName = "Gambeta"
let yourAge = 19

if myName == "leandro" {
    "Your name is \(myName)."
}
else {
    "Oops, I guessed it wrong."
}

if myName == "Leandro" {
    "Now I guessed it correctly"
} else if myName == "Gambeta" {
    "Are you Gambeta?"
} else {
    "Ok I give up"
}

if myName == "Leandro" && myAge == 30 {
    "Name is Leandro and age is 30"
} else if myAge == 26 {
    "I only guessed your age"
} else {
    "I don't know what i'm doing"
}

if myAge == 26 || myName == "Gambeta" {
    "Either age is 26, name is Gambeta or both"
} else if myName == "Leandro" || myAge == 39 {
    "It's too late to get in this clause"
}

if (myName == "Leandro" && myAge == 29) && (yourName == "Gambeta" || yourAge == 19) {
    "My name is Leandro an I'm 26... AND... your name is Gambeta or you are 19"
} else {
    "Hmm, that did not work so well."
}
