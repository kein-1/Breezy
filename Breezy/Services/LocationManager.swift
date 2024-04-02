//
//  LocationService.swift
//  Breezy
//
//  Created by Kein Li on 3/29/24.
//

import Foundation
import CoreLocation


protocol LocationService {
    
    var location: CLLocation? { get }
    var manager : CLLocationManager { get }
    var locationEnabled: Bool { get }
    
    func getLocation() -> CLLocation?
}


class LocationManager: NSObject, LocationService {
    
    // the coordinates
    var location: CLLocation?
    let manager : CLLocationManager = CLLocationManager()
    
    var locationEnabled: Bool {
        return CLLocationManager.locationServicesEnabled()
    }
    
    override init() {
        
        // Call NSObject's init
        super.init()
        
        // Only setup if device's location service is available
        if CLLocationManager.locationServicesEnabled() {
            manager.desiredAccuracy = kCLLocationAccuracyBest // set best location acc
            manager.distanceFilter = 100 // provide updates only after moving 100 meters
            manager.delegate = self // means this instance will trigger delegate updates
        }
    }
    
    
    func initiateLocation() {
        
    }
    
    func checkAuthorization  {
        if let currLocation = location {return currLocation}
        
        switch manager.authorizationStatus {
        case .notDetermined:
            <#code#>
        case .restricted:
            <#code#>
        case .denied:
            <#code#>
        case .authorizedAlways:
            <#code#>
        case .authorizedWhenInUse:
            <#code#>
        @unknown default:
            <#code#>
        }
    }
    
    func startTracking() {
        locationManager.manager.startUpdatingHeading()
    }
    
}

// MARK: - Exension for CLLocationManagerDelete protocols

extension LocationManager : CLLocationManagerDelegate {
    
    
    /// Triggers whenever CLLocationManager detects a change
    /// - Parameters:
    ///   - manager: the location manager that generated the updated event
    ///   - locations: array of updated locations. most recent is at the end
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.last else { return }
        self.location = latestLocation
    }
}

