//
//  Location.swift
//  BucketList
//
//  Created by Leandro Motta Junior on 30/09/25.
//

import Foundation
import MapKit

struct Location: Codable, Equatable, Identifiable {
    var id: UUID
    var name: String
    var description: String
    var latitudade: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitudade, longitude: longitude)
    }
    
    static let example = Location(id: UUID(), name: "Buck Palace", description: "Lit by over 40,000 lightbulbs", latitudade: 51.501, longitude: -0.141)
    
    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
