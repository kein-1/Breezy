//
//  Placemark.swift
//  Breezy
//
//  Created by Kein Li on 4/14/24.
//

import Foundation


struct Placemark: Hashable {
    let name: String?
    let locality: String?
    let administrativeArea: String?
    let country: String?
}

// MARK: - Mock Data

extension Placemark {
    static let mockPlacemark: Self =
        Placemark(
            name: "Golden Gate Bridge",
            locality: "San Francisco",
            administrativeArea: "California",
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
