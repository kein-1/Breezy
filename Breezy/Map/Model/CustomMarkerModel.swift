//
//  CustomMarkerModel.swift
//  Breezy
//
//  Created by Kein Li on 5/11/24.
//

import Foundation
import CoreLocation

struct CustomMarkerModel : Hashable, Identifiable {
    var id = UUID()
    let aq: AirQuality
    let coord : CLLocationCoordinate2D
    let placeMark: Placemark
}

