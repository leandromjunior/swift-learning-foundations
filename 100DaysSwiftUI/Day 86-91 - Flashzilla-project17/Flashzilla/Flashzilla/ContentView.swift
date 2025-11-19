//
//  ContentView.swift
//  Flashzilla
//
//  Created by Leandro Motta Junior on 12/11/25.
//

import SwiftUI

// How to use Gestures in SwiftUI
struct UseGestures: View {
    var body: some View {
        Text("Hello, World!")
            .onTapGesture(count: 2) { // Double Tap
                print("DOuble Tapped!")
            }
        
        Text("Long Press")
            .onLongPressGesture {
                print("Long Pressed!")
            }
        
        Text("2 seconds of long press")
            .onLongPressGesture(minimumDuration: 2) {
                print("Long Pressed!")
            }
        
        Text("Hello, World!")
            .onLongPressGesture(minimumDuration: 1) {
                print("Long Pressed by 1 sec.")
            } onPressingChanged: { inProgress in // change the status of a property (Boolean)
                print("In progress: \(inProgress)")
            }
    }
}

struct PinchingGesture: View {
    @State private var currentAmount = 0.0
    @State private var finalAmount = 1.0
    var body: some View {
        // Pinching in and out
        Text("Hello, World!")
            .scaleEffect(finalAmount + currentAmount)
            .gesture(
                MagnifyGesture()
                    .onChanged { value in
                        currentAmount = value.magnification - 1
                    }
                    .onEnded { value in
                        finalAmount += currentAmount
                        currentAmount = 0
                    }
            )
    }
}

//struct RotateGesture: View {
//    @State private var currentAmount = Angle.zero
//    @State private var finalAmount = Angle.zero
//    var body: some View {
//        Text("Hello, World!")
//            .rotationEffect(currentAmount + finalAmount)
//            .gesture(
//                RotateGesture()
//                    .onChanged { value in
//                        currentAmount = value.rotation
//                    }
//                    .onEnded { value in
//                        finalAmount += currentAmount
//                        currentAmount = .zero
//                    }
//            )
//    }
//}

struct PriorityGesture: View {
    var body: some View {
        // In this case, the child's gesture (Text) will always get the priority instead of its parent (VStack)
        VStack {
            Text("Hello!")
                .onTapGesture {
                    print("Text tapped!")
                }
        }
        .onTapGesture {
            print("VStack tapped!")
        }
        // In this case the parent receives the priority (highPriorityGesture())
        VStack {
            Text("Parent Priority")
                .onTapGesture {
                    print("Text tapped!")
                }
        }
        .highPriorityGesture(
            TapGesture()
                .onEnded {
                    print("Vstack Tapped!")
                }
        )
        // Both the parent and child gestures are triggered at the same time
        VStack {
            Text("Triggered Simultaneously")
                .onTapGesture {
                    print("Text tapped!")
                }
        }
        .simultaneousGesture(
            TapGesture()
                .onEnded {
                    print("Vstack tapped")
                }
        )
        
    }
}

struct sequentialGesture: View {
    // how far the circle has been dragged
    @State private var offset = CGSize.zero
    
    // Whether it is currently being dragged or not
    @State private var isDragging = false
    
    var body: some View {
        // a drag gesture that updates offset and isDragging as it moves around
        let dragGesture = DragGesture()
            .onChanged { value in offset = value.translation }
            .onEnded { _ in
                withAnimation {
                    offset = .zero
                    isDragging = false
                }
            }
        
        // a long press gesture that enables isDragging
        let pressGesture = LongPressGesture()
            .onEnded { value in
                withAnimation {
                    isDragging = true
                }
            }
        
        // a combined gesture that forces the user to long press then drag
        let combined = pressGesture.sequenced(before: dragGesture)
        
        // a 64x64 circle that scales up when it's dragged, sets its offset to whatever we had back from the drag gesture, and uses our combined gesture
        Circle()
            .fill(.red)
            .frame(width: 64, height: 64)
            .scaleEffect(isDragging ? 1.5 : 1)
            .offset(offset)
            .gesture(combined)
    }
}

// Disabling user interactivity with allowsHitTesting()
struct DisablingInteractivity: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.blue)
                .frame(width: 300, height: 300)
                .onTapGesture {
                    print("Rectangle Tapped!")
                }
            
            Circle()
                .fill(.red)
                .frame(width: 300, height: 300)
                .contentShape(.rect) //with this modifier when tapping any area of the ZStack, the print will be "Circle Tapped!"
                .onTapGesture {
                    print("Circle Tapped!")
                }
                //.allowsHitTesting(false) // with this modifier when tapping the circle will always print "Rectangle tapped!"
        }
    }
}

// Showing in the next two examples the difference of using .contentShape() in practice
struct DisablingInteractivity2: View {
    var body: some View {
        // In this case, the message will print only if we press the both Text, but not if we press the spacer (space between the texts)
        VStack {
            Text("Hello")
            Spacer().frame(height: 100)
            Text("World!")
        }
        .onTapGesture {
            print("VStack Tapped!")
        }
    }
}

struct DisablingInteractivity3: View {
    var body: some View {
        // In this case ( with the modifier contentShape() ), if we press any area of the view like the both text AND the spacer (space between texts), the message will be printed!
        VStack {
            Text("Hello")
            Spacer().frame(height: 100)
            Text("World!")
        }
        .contentShape(.rect)
        .onTapGesture {
            print("VStack Tapped!")
        }
    }
}

// Triggering events repeatdelly using a timer
struct EventsTimer: View {
    let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()
    @State private var counter = 0
    var body: some View {
        Text("Hello, World!")
            .onReceive(timer) { time in
                if counter == 5 {
                    timer.upstream.connect().cancel() // Cancel the automatic timer
                } else {
                    print("The time is now \(time)") //print the .now time every 1 second
                }
                
                counter += 1
            }
    }
}

// How to be notified when your SwiftUI app moves to the background
struct BackgroundNotification: View {
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        Text("Hello")
            .onChange(of: scenePhase) { oldPhase, newPhase in
                if newPhase == .active { // The app is open
                    print("Active")
                } else if newPhase == .inactive { // The app is closed (the user get off the app)
                    print("Inactive")
                } else if newPhase == .background { // Runs right after the user get off the app
                    print("Background")
                }
            }
    }
}

// Supporting specific accessibility needs with SwiftUI

// To run this code: open the simulator > Settings App > Accessibility > DIsplay & Text Size > Different Without Color toggle.
struct SpecificAccessibilityColor: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    var body: some View {
        HStack {
            if differentiateWithoutColor {
                Image(systemName: "checkmark.circle")
            }
            
            Text("Success")
        }
        .padding()
        .background(differentiateWithoutColor ? .black : .green)
        .foregroundStyle(.white)
        .clipShape(.capsule)
    }
}

// To run this code: open the simulator > Settings App > Accessibility > Motion > Reduce Motion toggle.
struct SpecificAccessibilityMotion: View {
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @State private var scale = 1.0
    
    var body: some View {
        Button("Hello, World!") {
            if reduceMotion {
                scale *= 1.5
            } else {
                withAnimation {
                    scale *= 1.5
                }
            }
        }
        .scaleEffect(scale)
    }
}

// With this alternative we can create a little wrapper function that bypass animation automatically

func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
    if UIAccessibility.isReduceMotionEnabled {
        return try body()
    } else {
        return try withAnimation(animation, body)
    }
}

struct SpecificAccessibilityMotionAlternative: View {
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @State private var scale = 1.0
    
    var body: some View {
        Button("Hello, World!") {
            withOptionalAnimation {
                scale *= 1.5
            }
        }
        .scaleEffect(scale)
    }
}

struct SpecificAccessibilityTransparency: View {
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
    var body: some View {
        Text("Hello, World!")
            .padding()
            .background(reduceTransparency ? .black : .black.opacity(0.5))
            .foregroundStyle(.white)
            .clipShape(.capsule)
    }
}

// Project
extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(y: offset * 10)
    }
}

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.accessibilityVoiceOverEnabled) var accessibilityVoiceOverEnabled
    
    @State private var isActive = true
    
    // The line below was used for examples
    //@State private var cards = Array<Card>(repeating: .example, count: 5)
    @State private var cards = [Card]()
    
    @State private var timeRemaining = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State private var showingEditScreen = false
    
    var body: some View {
        ZStack {
            Image(decorative: "background")// When using voiceOver this is the best approach instead of Image(.background)
                .resizable()
                .ignoresSafeArea()
            VStack {
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)
                
                ZStack {
                    ForEach(0..<cards.count, id: \.self) { index in
                        CardView(card: cards[index]) {
                            withAnimation {
                                removeCard(at: index)
                            }
                        }
                        .stacked(at: index, in: cards.count)
                        .allowsHitTesting(index == cards.count - 1) //Prevents the user from dragging some card that is not the first one
                        .accessibilityHidden(index < cards.count - 1)
                    }
                }
                .allowsHitTesting(timeRemaining > 0) // while the timer is bigger than zero, the card is interactive
                
                if cards.isEmpty {
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(.white)
                        .foregroundStyle(.black)
                        .clipShape(.capsule)
                }
            }
            
            VStack {
                HStack {
                    Spacer()
                    
                    Button {
                        showingEditScreen = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(.circle)
                    }
                }
                
                Spacer()
            }
            .foregroundStyle(.white)
            .font(.largeTitle)
            .padding()
            
            // If the accessibility point is activated the menu shows the options below
            if accessibilityDifferentiateWithoutColor || accessibilityVoiceOverEnabled {
                VStack {
                    Spacer()
                    
                    HStack {
                        Button {
                            withAnimation {
                                removeCard(at: cards.count - 1)
                            }
                        } label: {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(.circle)
                        }
                        .accessibilityLabel("Wrongs")
                        .accessibilityHint("Mark your answer as being incorrect.")
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                removeCard(at: cards.count - 1)
                            }
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(.circle)
                        }
                        .accessibilityLabel("Correct")
                        .accessibilityHint("Mark your answer as being correct.")
                    }
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        .onReceive(timer) { time in
            guard isActive else { return }
            
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        .onChange(of: scenePhase) { // this piece of code is useful because when the user closes the app (put on background) while the timer is ticking, the timer pauses exactly where it was, so when the app is reopened the timer is at the same moment
            if scenePhase == .active { // if the app is running/open
                if cards.isEmpty == false {
                    isActive = true
                }
            } else {
                isActive = false
            }
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: resetCards,content: EditCards.init)
    }
    
    func removeCard(at index: Int) {
        guard index >= 0 else { return } //make sure we don’t try to remove a card that doesn’t exist
        
        cards.remove(at: index)
        
        if cards.isEmpty {
            isActive = false
        }
    }
    // Executed when the button "Start Again" is pressed
    func resetCards() {
        // The line below was removed
        //cards = Array<Card>(repeating: .example, count: 10)
        timeRemaining = 100
        isActive = true
        loadData()
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                cards = decoded
            }
        }
    }
}


#Preview {
    //UseGestures()
    //PinchingGesture()
    //RotateGesture()
    //PriorityGesture()
    //sequentialGesture()
    //DisablingInteractivity()
    //DisablingInteractivity2()
    //DisablingInteractivity3()
    //EventsTimer()
    //BackgroundNotification()
    //SpecificAccessibilityColor()
    //SpecificAccessibilityMotion()
    //SpecificAccessibilityMotionAlternative()
    //SpecificAccessibilityTransparency()
    ContentView()
}
