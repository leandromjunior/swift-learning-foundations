//
//  ContentView.swift
//  BucketList
//
//  Created by Leandro Motta Junior on 28/09/25.
//

import SwiftUI
import MapKit
import LocalAuthentication

// Adding conformance to Comparable for custom types

// Without the comparable we couldn't use the .sorted() in the users array. We must get an error
struct User: Identifiable, Comparable {
    let id = UUID()
    var firstName: String
    var lastName: String
    
    static func <(lhs: User, rhs: User) -> Bool {
        lhs.lastName < rhs.lastName
    }
}
struct ComparableView: View {
    let users = [
        User(firstName: "Arnold", lastName: "Rimmer"),
        User(firstName: "Kristine", lastName: "Kochanski"),
        User(firstName: "David", lastName: "Lister"),
    ].sorted()
    
    var body: some View {
        List(users) { user in
            Text("\(user.lastName), \(user.firstName)")
        }
    }
}


// Writing data to the documents directory
struct WritingDataToDocumentView: View {
    var body: some View {
        Button("Read and write") {
            let data = Data("Test message".utf8)
            let url = URL.documentsDirectory.appending(path: "message.txt")
            
            do {
                try data.write(to: url, options: [.atomic, .completeFileProtection])
                let input = try String(contentsOf: url)
                print(input)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

// Switching view states with enums

struct LoadingView: View {
    var body: some View {
        Text("Loading...")
    }
}

struct SuccessView: View {
    var body: some View {
        Text("Success!")
    }
}

struct FailedView: View {
    var body: some View {
        Text("Failed.")
    }
}

struct ViewsWithEnumsView: View {
    enum LoadingState {
        case loading, success, failed
    }
    
    @State private var loadingState = LoadingState.loading
    var body: some View {
        if loadingState == .loading {
            LoadingView()
        } else if loadingState == .success {
            SuccessView()
        } else if loadingState == .failed {
            FailedView()
        }
        
        // Or we can use Switch Case too
        switch loadingState {
        case .loading:
            LoadingView()
        case .success:
            SuccessView()
        case .failed:
            FailedView()
        }
    }
}

// Day 69

// Integrating MapKit with SwiftUI
struct MapsView: View {
    var body: some View {
        Map()
            //.mapStyle(.imagery) //Show satellite map
            //.mapStyle(.hybrid) //Show satellite map with city map when zooming
            .mapStyle(.hybrid(elevation: .realistic)) //Show the globe with real time zone
    }
}

struct MapInteractionView: View {
    var body: some View {
        //Map(interactionModes: [.rotate, .zoom]) //let the user rotate and zoom the map
        Map(interactionModes: []) //Don't let the user interact with the map, it's a static image
    }
}

struct MapInitialPositionView: View {
    let position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        )
    )
    var body: some View {
        Map(initialPosition: position)
    }
}

struct MapChangePositionView: View {
    @State private var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 38.897957, longitude: -77.036560), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        )
    )
    var body: some View {
        VStack {
            Map(position: $position)
//                .onMapCameraChange { context in
//                    print(context.region)
//                }
            // With the .continuous value the value of position changes while the user is moving the map and not only when he stops moving
                .onMapCameraChange(frequency: .continuous) { context in
                    print(context.region)
                }
            
            HStack(spacing: 50) {
                Button("Paris") {
                    position = MapCameraPosition.region(
                        MKCoordinateRegion(
                            center: CLLocationCoordinate2D(latitude: 48.8566, longitude: 2.3522), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
                        )
                    )
                }
                
                Button("Tokyo") {
                    position = MapCameraPosition.region(
                        MKCoordinateRegion(
                            center: CLLocationCoordinate2D(latitude: 35.6897, longitude: 139.6922), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
                        )
                    )
                }
            }
        }
    }
}

struct LocationExample: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}

struct PlacingMarkerView: View {
    let locations = [
        LocationExample(name: "Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
        LocationExample(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
    ]
    
    var body: some View {
        Map {
            ForEach(locations) { location in
                Marker(location.name, coordinate: location.coordinate)
            }
        }
    }
}

struct PlacingAnnotationsView: View {
    let locations = [
        LocationExample(name: "Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
        LocationExample(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
    ]
    
    var body: some View {
        Map {
            ForEach(locations) { location in
                Annotation(location.name, coordinate: location.coordinate) {
                    Text(location.name)
                        .font(.headline)
                        .padding()
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(.capsule)
                }
                .annotationTitles(.hidden)
            }
        }
    }
}

struct OnTapMapView: View {
    var body: some View {
        // It marks the location/coordinates from the local where the user tapped. The tap location is not ideal because it gives us screen coordinates rather than map coordinates. But using MapReader we can convert between the two types of coordinates (lat, lon)
        MapReader { proxy in
            Map()
                .onTapGesture { position in
                    if let coordinate = proxy.convert(position, from: .local) {
                        print(coordinate)
                    }
                }
        }
    }
}

// Using Touch ID and Face ID with SwiftUI
struct BiometricAuthenticationView: View {
    @State private var isUnlocked = false
    var body: some View {
        VStack {
            if isUnlocked {
                Text("Unlocked")
            } else {
                Text("Locked")
            }
        }
        .onAppear(perform: authenticate)
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // it's possible, so go ahead and use it
            let reason = "We need to unlock your data."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                
                // authentication has now completed
                if success {
                    // authenticated successfully
                    isUnlocked = true
                } else {
                    // there was a problem
                }
            }
        } else {
            // no biometrics
        }
    }
}

struct ContentView: View {
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3), span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    
    @State private var viewModel = ViewModel()
    
    var body: some View {
        if viewModel.isUnlocked {
            MapReader { proxy in
                Map(initialPosition: startPosition) {
                    ForEach(viewModel.locations) { location in
                        Annotation(location.name, coordinate: location.coordinate) {
                            Image(systemName: "star.circle")
                                .resizable()
                                .foregroundStyle(.blue)
                                .frame(width: 44, height: 44)
                                .background(.white)
                                .clipShape(.circle)
                                .simultaneousGesture(LongPressGesture(minimumDuration: 1).onEnded { _ in viewModel.selectedPlace = location })
                        }
                    }
                }
                .onTapGesture { position in
                    if let coordinate = proxy.convert(position, from: .local) {
                        viewModel.addLocation(at: coordinate)
                    }
                }
                .sheet(item: $viewModel.selectedPlace) { place in
                    EditView(location: place) { newLocation in
                        viewModel.udpateLocation(location: newLocation)
                    }
                }
            }
        } else {
            Button("Unlock Places", action: viewModel.authenticate)
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.capsule)
        }
    }
}

#Preview {
    //ComparableView()
    //WritingDataToDocumentView()
    //ViewsWithEnumsView()
    //MapsView()
    //MapInteractionView()
    //MapInitialPositionView()
    //MapChangePositionView()
    //PlacingMarkerView()
    //PlacingAnnotationsView()
    //OnTapMapView()
    //BiometricAuthenticationView()
    ContentView()
}

/*
 Obs. for BiometricAuthenticationView() - To take Face ID for a test drive in the simulator, go to the Features menu and choose Face ID > Enrolled, then launch the app again. This time you should see the Face ID prompt appear, and you can trigger successful or failed authentication by going back to the Features menu and choosing Face ID > Matching Face or Non-matching Face.
 */
