//
//  PlaceMarkExtension.swift
//  Breezy
//
//  Created by Kein Li on 5/19/24.
//

import Foundation



// MARK: - Mock Data
extension Placemark {
    static let mockPlacemark: Self =
        Placemark(
            name: "New York",
            locality: "New York",
            administrativeArea: "NY",
            country: "United States"
        )
    
    static let mockPlacemarkBoston: Self =
        Placemark(
            name: "Boston",
            locality: "Boston",
            administrativeArea: "Massachusetts",
            country: "United States"
        )
}
