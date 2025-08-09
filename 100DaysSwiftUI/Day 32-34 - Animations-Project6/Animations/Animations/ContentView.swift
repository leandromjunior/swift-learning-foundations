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

// Day 33
struct AnimationStack: View {
    @State private var enabled = false
    var body: some View {
        Button("Tap Me") {
            enabled.toggle()
        }
        .frame(width: 250, height: 250)
        .background(enabled ? .blue : .red)
        .animation(nil, value: enabled)
        .foregroundStyle(.white)
        .clipShape(.rect(cornerRadius: enabled ? 60 : 0))
        .animation(.spring(duration: 1, bounce: 0.6), value: enabled)
    }
}

struct AnimationGestures: View {
    @State private var dragAmount = CGSize.zero
    var body: some View {
        LinearGradient(colors: [.yellow, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
            .frame(width: 300, height: 200)
            .clipShape(.rect(cornerRadius: 10))
            .offset(dragAmount)
            .gesture(
                DragGesture()
                    .onChanged { dragAmount = $0.translation} // performs the drag action
                    //.onEnded {_ in dragAmount = .zero } // When we release, the "card" go to the middle (position 0) again
                // Adding the peace of code below and removing the animation below from the lineargradient, we have the bounce animation only on the release (onEnded) of the card
                    .onEnded {_ in
                        withAnimation(.bouncy) {
                            dragAmount = .zero
                        }
                    }
            )
            //.animation(.bouncy, value: dragAmount)
    }
}

struct NotSoUsableAnimation: View {
    @State private var letters = Array("Hello SwiftUI")
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<letters.count, id: \.self) {num in
                Text(String(letters[num]))
                    .padding(5)
                    .font(.title)
                    .background(enabled ? .blue : .red)
                    .offset(dragAmount)
                    .animation(.linear.delay(Double(num) / 20), value: dragAmount)
            }
        }
        .gesture(
            DragGesture()
                .onChanged { dragAmount = $0.translation}
                .onEnded {_ in
                    dragAmount = .zero
                    enabled.toggle()
                }
        )
    }
}

struct ShowingHidingView: View {
    @State private var isShowingRed = false
    var body: some View {
        VStack {
            Button("Tap Me") {
                withAnimation { // optional but gives a cool effect
                    isShowingRed.toggle()
                }
            }
            
            if isShowingRed {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    //.transition(.scale) // optional but improves the effect
                    .transition(.asymmetric(insertion: .scale, removal: .opacity)) // optional but improves the effect
            }
        }
    }
}

struct CornerRotationModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(active: CornerRotationModifier(amount: -90, anchor: .topLeading),
                  identity: CornerRotationModifier(amount: 0, anchor: .topLeading))
    }
}

struct CustomTransitionView: View {
    @State private var isShowingRed = false
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.blue)
                .frame(width: 200, height: 200)
            
            if isShowingRed {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(.pivot)
            }
        }
        .onTapGesture {
            withAnimation {
                isShowingRed.toggle()
            }
        }
    }
}

#Preview {
    ShowingHidingView()
}
