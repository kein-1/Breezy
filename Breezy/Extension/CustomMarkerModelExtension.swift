//
//  CustomMarkerModelExtension.swift
//  Breezy
//
//  Created by Kein Li on 5/20/24.
//

import Foundation


// MARK: - CustomModelMarker extensions


extension CustomMarkerModel {
    
    static let mockData: Self =
        CustomMarkerModel(aq: AirQuality.mockAQ,
                      coord: .newYork,
                      placeMark: .mockPlacemark)
    
    static let mockDataArray: [Self] = [
                    
        CustomMarkerModel(aq: AirQuality.mockAQ,
                          coord: .newYork,
                          placeMark: .mockPlacemark),
        
        CustomMarkerModel(aq: AirQuality.mockAQ,
                          coord: .boston,
                          placeMark: .mockPlacemarkBoston)
        ]
}

