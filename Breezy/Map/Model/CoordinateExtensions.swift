//
//  Coordinates.swift
//  Breezy
//
//  Created by Kein Li on 5/9/24.
//

import Foundation
import MapKit

extension CLLocationCoordinate2D {
    static let newYork : Self = CLLocationCoordinate2D(latitude: 40.73, longitude: -73.93)
    static let boston : Self = CLLocationCoordinate2D(latitude: 42.36, longitude: -71.05)
    static var seattle: Self = CLLocationCoordinate2D(latitude: 47.608013,
        longitude: -122.335167
    )
}

extension CLLocationCoordinate2D: Hashable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(latitude)
        hasher.combine(longitude)
    }
}
