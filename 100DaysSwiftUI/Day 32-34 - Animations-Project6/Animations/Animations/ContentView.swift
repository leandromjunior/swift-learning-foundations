//
//  ContentView.swift
//  Animations
//
//  Created by Leandro Motta Junior on 07/08/25.
//

import SwiftUI

struct StartingWithAnimationView: View {
    @State private var animationAmount = 1.0
    var body: some View {
        Button("Tap Me") {
            animationAmount += 1
        }
        .padding(50)
        .background(.red)
        .foregroundStyle(.white)
        .clipShape(.circle)
        .scaleEffect(animationAmount)
        .blur(radius: (animationAmount - 1) * 3) // Blur the button each time its increase
        .animation(.default, value: animationAmount) // Add an animation to the button incrasing
    }
}

struct AnotherAnimations: View {
    @State private var animationAmount = 1.0
    var body: some View {
        Button("Tap Me") {
            animationAmount += 1
        }
        .padding(50)
        .background(.red)
        .foregroundStyle(.white)
        .clipShape(.circle)
        .scaleEffect(animationAmount)
        .blur(radius: (animationAmount - 1) * 3)
        //.animation(.linear, value: animationAmount) // The growth is more linear
        //.animation(.spring(duration: 1, bounce: 0.8), value: animationAmount)
        //.animation(.easeInOut(duration: 2), value: animationAmount)
        .animation(
            .easeInOut(duration: 2)
                //.delay(1), // makes the button growth with a 1 second delay
                .repeatForever(autoreverses: true),
            value: animationAmount
        )
    }
}

struct AnotherAnimations2: View {
    @State private var animationAmount = 1.0
    var body: some View {
        Button("Tap Me") {
            //nothing now
        }
        .padding(50)
        .background(.red)
        .foregroundStyle(.white)
        .clipShape(.circle)
        .overlay(
            Circle()
                .stroke(.red)
                .scaleEffect(animationAmount)
                .opacity(2 - animationAmount)
                .animation(
                    .easeInOut(duration: 1)
                        .repeatForever(autoreverses: false),
                    value: animationAmount
                )
        )
        .onAppear {
            animationAmount = 2
        }
    }
}

struct AnimationBinding: View {
    @State private var animationAmount = 1.0
    var body: some View {
        VStack {
            // The animation "declared" inside the stepper affects the button, this occurs due to binding, note that the scaleeffect is applied to the button, so the variable increase of value affects the button
            Stepper("Scale Amount", value: $animationAmount.animation(.easeInOut(duration: 1).repeatCount(3, autoreverses: true)), in: 1...10)
            
            Spacer()
            
            Button("Tap Me") {
                animationAmount += 1
            }
            .padding(40)
            .background(.red)
            .foregroundStyle(.white)
            .clipShape(.circle)
            .scaleEffect(animationAmount)
        }
    }
}

struct ContentView: View {
    @State private var animationAmount = 0.0
    var body: some View {
        Button("Tap Me") {
            // the modifier inside the withAnimation is optional, the parenthesis could be empty
            withAnimation(.spring(duration: 1, bounce: 0.5)) {
                animationAmount += 360
            }
        }
        .padding(50)
        .background(.red)
        .foregroundStyle(.white)
        .clipShape(.circle)
        .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
    }
}

#Preview {
    ContentView()
}
