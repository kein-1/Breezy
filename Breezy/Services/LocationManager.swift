//
//  LocationService.swift
//  Breezy
//
//  Created by Kein Li on 3/29/24.
//

import Foundation
import CoreLocation


protocol LocationService {
    var userApprovedStatus : Bool {get}
}


class LocationManager: LocationService {
    
    var locationService: CLLocationManager
    init() {
        self.locationService = CLLocationManager()
    }
    
    var userApprovedStatus : Bool {
        if CLLocationManager.locationServicesEnabled() {
            switch locationService.authorizationStatus {
            case .notDetermined:
                return false
            case .restricted:
                return false
            case .denied:
                return false
            case .authorizedAlways:
                return true
            case .authorizedWhenInUse:
                return true
            @unknown default:
                return false
            }
        }
        return true
    }
}

