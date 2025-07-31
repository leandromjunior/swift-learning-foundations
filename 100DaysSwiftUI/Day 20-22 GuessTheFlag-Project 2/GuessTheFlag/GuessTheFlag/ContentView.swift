//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Leandro Motta Junior on 26/07/25.
//

import SwiftUI

// Day 20
struct ContentView: View {
    var body: some View {
        VStack(spacing: 15) {
            Text("Hello, world!")
            Text("This is another text view")
            
            HStack {
                Text("HStack inside a VStack")
                Text("View of a HStack inside a VStack")
                
                ZStack {
                    Text("Zstack inside a HStack inside a VStack")
                }
            }
            
        }
        .padding()
        
        // Related to vertical "divider"
        VStack(alignment: .leading) {
            Text("Hello, world!")
            Text("This is another text view")
            
            Spacer()
        }
        .padding()
        
        // Related to horizontal "divider"
        HStack(spacing: 50) {
            Text("Hello, world!")
            Text("This is another text view")
            
            Spacer()
        }
        .padding()
        
        // Related to the depth
        ZStack (alignment: .top) {
            Text("Hello, world!")
            Text("This is another text view in ZStack")
            
            Spacer()
        }
    }
}

struct SecondView: View {
    var body: some View {
        ZStack {
            //Color.mint
            Color(red: 1, green: 0.8, blue: 0)
               // .frame(minWidth: 200, maxWidth: .infinity, maxHeight: 200)
            Text("Your Content")
            
        }
        .ignoresSafeArea() // Fill the spaces between dynamic Island/Notch and the bottom spaces
    }
}

struct ThirdView: View {
    var body: some View {
        ZStack {
            VStack(spacing:0) { // The spacing is removing a blank space between red and white
                Color.red
                Color.blue
            }
            
            Text("Your Content")
                .foregroundStyle(.secondary) // Collor inside the letters
                .padding(50)
                .background(.ultraThinMaterial) // Frost Glass design
        }
        .ignoresSafeArea()
    }
}

struct FirstGradientView: View {
    var body: some View {
        LinearGradient(colors: [.white, .black], startPoint: .top, endPoint: .bottom)
    }
        
}

struct SecondGradientView: View {
    var body: some View {
        LinearGradient(stops: [
            .init(color: .white, location: 0.40),
            .init(color: .black, location: 0.60)
        ], startPoint: .top, endPoint: .bottom)
    }
}

struct ThirdGradientView: View {
    var body: some View {
        RadialGradient(colors: [.blue, .black], center: .center, startRadius: 20, endRadius: 200)
    }
}

struct FourthGradientView: View {
    var body: some View {
        AngularGradient(colors: [.red, .yellow, .green, .blue, .purple, .red], center: .center)
    }
}

struct FifthGradientView: View {
    var body: some View {
        Text("Your Content")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .foregroundStyle(.white)
            .background(.red.gradient)
    }
}

struct FirstButtonView: View {
    var body: some View {
        Button("Delete Selection", action: executeDelete)
        
        Button("Delete Selection", role: .destructive, action: executeDelete) //The "destructive turns the fontcolor of the button into red"
    }
    
    func executeDelete(){
        print("Now Deleting...")
    }
}

struct SecondButtonView: View {
    var body: some View {
        VStack {
            Button("Button 1") { }
                .buttonStyle(.bordered)
            
            Button("Button 2", role: .destructive) { }
                .buttonStyle(.bordered)
            
            Button("Button 3") { }
                .buttonStyle(.borderedProminent)
            
            Button("Button 4", role: .destructive) { }
                .buttonStyle(.borderedProminent)
            
            Button("Button 6") { }
                .buttonStyle(.borderedProminent)
                .tint(.indigo)
            
            //Button with custom label/button
            Button {
                print("Button was tapped")
            } label: {
                Text("Tap Me!")
                    .padding()
                    .foregroundStyle(.white)
                    .background(.red)
            }
            
            Button("Edit", systemImage: "pencil") {
                print("Edit button was tapped")
            }
            
            // The same as button above but more customized
            Button {
                print("Edit button was tapped")
            } label: {
                Label("Edit", systemImage: "pencil")
                    .padding()
                    .foregroundStyle(.white)
                    .background(.red)
            }
        }
    }
}

struct AlertView: View {
    @State private var showAlert = false
    
    var body: some View {
        
        Button("Show Alert") {
            showAlert = true
        }
        .alert("Important Message", isPresented: $showAlert) {
            Button("OK") { }
        }
        
        // Example adding two buttons inside the alert
        Button("Show Alert 2") {
            showAlert = true
        }
        .alert("Important Message", isPresented: $showAlert) {
            Button("Delete", role: .destructive) { }
            Button("Cancel", role: .cancel) { }
        }
        
        // Example adding a message inside the alert
        Button("Show Alert 3") {
            showAlert = true
        }
        .alert("Important Message", isPresented: $showAlert) {
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Please read the message.")
        }
    }
}

// Day 21
struct GuessTheFlagView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showScore = false
    @State private var scoreTitle = ""
    @State private var endTitle = "" // Day 22
    @State private var score = 0 // Day 22
    @State private var count = 0 // Day 22
    @State private var showEnd = false // Day 22
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 141/255, green: 124/255, blue: 85/255), location: 0.3),
                .init(color: Color(red:34/255, green: 67/255, blue: 88/255), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 400)
            .ignoresSafeArea()
            VStack {
                Spacer()
                
                Text("Guess The Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of:")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) {number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 30)
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 20))
                .alert(scoreTitle, isPresented: $showScore) {
                    Button("Continue", action: askQuestion)
                } message: {
                    Text("Your score is \(score)") // Day 22
                }
                // Day 22
                .alert(endTitle, isPresented: $showEnd) {
                    Button("Reset", action: resetGame)
                } message: {
                    if score <= 40 {
                        Text("Your final score is \(score). You'll be better next time")
                    } else {
                        Text("Congratulations! Your final score is \(score). Well done!")
                    }
                }
                
                Spacer()
                Spacer()
                Text("Score: \(score)") // Day 22
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
    }
    
    func flagTapped(_ number: Int) {
        
        count += 1 // Day 22
        
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 10
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
        }
        
        //Day 22
        if count == 8 {
            endTitle = "Game Over"
            showEnd = true
        }
        
        showScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    // Day 22
    func resetGame() {
        
        count = 0
        score = 0
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}
    
    // Myself Challenge
    
    struct MyOwnChallenge: View {
        @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
        @State private var correctAnswer = Int.random(in: 0...2)
        @State private var scoreTitle = ""
        @State private var show = false
        var body: some View {
            ZStack {
                RadialGradient(colors: [.blue, .gray], center: .center, startRadius: 400, endRadius: 200)
                    .ignoresSafeArea()
                
                VStack(spacing: 40) {
                    VStack {
                        Text("Whose Flag is it?")
                            .font(.title.weight(.heavy))
                            .foregroundStyle(.primary)
                        Image(countries[correctAnswer])
                    }
                    
                    ForEach(0..<3) {position in
                        Button {
                            tappedCountry(position)
                        } label: {
                            Text(countries[position])
                                .foregroundStyle(.black)
                        }
                        .buttonStyle(.bordered)
                        .background(.ultraThinMaterial)
                        .clipShape(.capsule)
                    }
                }
                .alert(scoreTitle, isPresented: $show) {
                    Button("Continue", action: continueButton)
                }
            }
        }
        
        func tappedCountry(_ position: Int) {
            if position == correctAnswer {
                scoreTitle = "Correct"
            } else {
                scoreTitle = "Wrong"
            }
            
            show = true
        }
        
        func continueButton() {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        }
    }

/* Day 24 Challenge 2
 Go back to project 2 and replace the Image view used for flags with a new FlagImage() view that renders one flag image using the specific set of modifiers we had.
 */

struct FlagImage: View {
    var images = [String]()
    var number: Int
    var body: some View {
        Image(images[number])
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}

struct GuessTheFlagViewChallenge: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showScore = false
    @State private var scoreTitle = ""
    @State private var endTitle = "" // Day 22
    @State private var score = 0 // Day 22
    @State private var count = 0 // Day 22
    @State private var showEnd = false // Day 22
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 141/255, green: 124/255, blue: 85/255), location: 0.3),
                .init(color: Color(red:34/255, green: 67/255, blue: 88/255), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 400)
            .ignoresSafeArea()
            VStack {
                Spacer()
                
                Text("Guess The Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of:")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) {number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(images: countries, number: number)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 30)
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 20))
                .alert(scoreTitle, isPresented: $showScore) {
                    Button("Continue", action: askQuestion)
                } message: {
                    Text("Your score is \(score)") // Day 22
                }
                .alert(endTitle, isPresented: $showEnd) {
                    Button("Reset", action: resetGame)
                } message: {
                    if score <= 40 {
                        Text("Your final score is \(score). You'll be better next time")
                    } else {
                        Text("Congratulations! Your final score is \(score). Well done!")
                    }
                }
                
                Spacer()
                Spacer()
                Text("Score: \(score)") // Day 22
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
    }
    
    func flagTapped(_ number: Int) {
        
        count += 1
        
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 10
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
        }
        
        if count == 8 {
            endTitle = "Game Over"
            showEnd = true
        }
        
        showScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func resetGame() {
        
        count = 0
        score = 0
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}


#Preview {
    GuessTheFlagViewChallenge()
}
