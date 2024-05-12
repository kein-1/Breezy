//
//  CustomMarkerModel.swift
//  Breezy
//
//  Created by Kein Li on 5/11/24.
//

import Foundation
import CoreLocation

struct CustomMarkerModel : Hashable {
    let aq: AirQuality
    let coord : CLLocationCoordinate2D
    let placeMark: Placemark
}


extension CustomMarkerModel {
    static let mockData: Self =
    CustomMarkerModel(aq: AirQuality.mockAQ,
                      coord: .newYork,
                      placeMark: .mockPlacemark)
}
