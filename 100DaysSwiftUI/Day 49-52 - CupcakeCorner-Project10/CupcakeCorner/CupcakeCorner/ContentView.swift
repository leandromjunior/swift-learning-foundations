//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Leandro Motta Junior on 26/08/25.
//

import SwiftUI

// Day 49

// Sending and Receiving codable data with URLSession and SwiftUI

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct UsingURLSessionView: View {
    @State private var results = [Result]()
    var body: some View {
        List(results, id: \.trackId) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            }
        }
        .task {
            await loadData()
        }
    }
    
    func loadData() async {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodedResponse.results
            }
        } catch {
            print("Invalid Data")
        }
    }
}

//Loading an image from a remote server

struct LoadingImageFromRemoteServer: View {
    var body: some View {
        // To change the size we can just use scale
        //AsyncImage(url: URL(string: "https://hws.dev/img/logo.png"), scale: 3)
        
        // but sometimes we want a precise size
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) {image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            Color.red
        }
        .frame(width: 200, height: 200)
        
        // We can use a third way that that tells us the whether the image was loaded, hit an error or hasn't finished yet
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) {phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
            } else if phase.error != nil {
                Text("There was an error loading the image.")
            } else {
                ProgressView()
            }
        }
        .frame(width: 200, height: 200)
    }
}

// Validating and Disabling form
struct FormValidation: View {
    @State private var username = ""
    @State private var email = ""
    
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("email", text: $email)
            }
            
            Section {
                Button("Create account") {
                    print("creating account...")
                }
            }
            .disabled(username.isEmpty || email.isEmpty)
        }
    }
}

struct FormValidationUsingComputedProperty: View {
    @State private var username = ""
    @State private var email = ""
    
    var disableForm: Bool {
        username.count < 5 || email.count < 5
    }
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("email", text: $email)
            }
            
            Section {
                Button("Create account") {
                    print("creating account...")
                }
            }
            .disabled(disableForm)
        }
    }
}

// Day 50

// Adding Codable conformance to an @observable class

@Observable
class User: Codable {
    var name = "Taylor"
}

struct CodableClassView: View {
    var body: some View {
        Button("Encode Taylor", action: encodeTaylor)
    }
    
    func encodeTaylor() {
        let data = try! JSONEncoder().encode(User())
        let str = String(decoding: data, as: UTF8.self)
        print(str) // {"_$observationRegistrar":{},"_name":"Taylor"}
    }
}

class UserTreated: Codable {
    enum COdingKeys: String, CodingKey {
        case _name = "name"
    }
    var name = "Taylor"
}

struct CodableClassTreatedView: View {
    var body: some View {
        Button("Encode Taylor", action: encodeTaylor)
    }
    
    func encodeTaylor() {
        let data = try! JSONEncoder().encode(UserTreated())
        let str = String(decoding: data, as: UTF8.self)
        print(str) // {"name":"Taylor"}
    }
}

// Adding haptic effects

struct BasicHapticsView: View {
    @State private var counter = 0
    var body: some View {
        Button("Tap Count: \(counter)") {
            counter += 1
        }
        .sensoryFeedback(.increase, trigger: counter) //This command makes the cellphone vibrate when tapping the button
        .sensoryFeedback(.impact(flexibility: .soft, intensity: 0.5), trigger: counter) //Another option
        .sensoryFeedback(.impact(weight: .heavy, intensity: 1), trigger: counter)
    }
}

// For more advanced haptics, the framework Core Haptics can be used
import CoreHaptics

struct AdvancedHapticsView: View {
    @State private var engine: CHHapticEngine?
    var body: some View {
        Button("Tap Me", action: complexSuccess)
            .onAppear(perform: prepareHaptics)
    }
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine \(error.localizedDescription)")
        }
    }
    
    func complexSuccess() {
        // make sure that the device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()

        // create one intense, sharp tap
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        events.append(event)

        // convert those events into a pattern and play it immediately
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
}

// Cupcake Corner App

struct ContentView: View {
    @State private var order = Order()
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(Order.types.indices, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper("Number of Cakes: \(order.quantity)", value: $order.quantity, in: 3...20)
                }
                
                Section {
                    Toggle("Any special requests?", isOn: $order.specialRequestEnable)
                    
                    if order.specialRequestEnable {
                        Toggle("Add extra frosting", isOn: $order.extraFrosting)
                        
                        Toggle("Add extra sprinkles?", isOn: $order.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink("Delivery Details") {
                        AdressView(order: order)
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

#Preview {
    ContentView()
}
