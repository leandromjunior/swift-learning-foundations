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
struct NameViewProperlyLater: View {
    var body: some View {
        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Hello, world!@*/Text("Hello, world!")/*@END_MENU_TOKEN@*/
    }
}

#Preview {
    AlertView()
}
