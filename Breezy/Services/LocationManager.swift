//
//  LocationService.swift
//  Breezy
//
//  Created by Kein Li on 3/29/24.
//

import Foundation
import CoreLocation


protocol LocationService {
    var manager : CLLocationManager { get }
    var location: CLLocation? { get }
    var authStatus: CLAuthorizationStatus { get }
    func getCurrentLocation() -> CLLocation?
    
}

@Observable
class LocationManager: NSObject, LocationService {
    
    var manager : CLLocationManager = CLLocationManager()
    private (set) var location: CLLocation? = nil
    var authStatus: CLAuthorizationStatus = CLAuthorizationStatus.denied
    
    override init() {
        super.init()
        manager.desiredAccuracy = kCLLocationAccuracyBest // set best location acc
        manager.distanceFilter = 100 // provide updates only after moving 100 meters
        manager.delegate = self // utilize delegate pattern
    }
    
    func getCurrentLocation() -> CLLocation? {
        checkAuthorization()
        return location
    }
        
    private func checkAuthorization()  {
        
        
        print(authStatus.rawValue)
        
        switch manager.authorizationStatus {
            case .notDetermined:
                manager.requestWhenInUseAuthorization()
            case .restricted:
                print("restricted !")
            case .denied:
                manager.requestWhenInUseAuthorization()
                print("denied !")
            case .authorizedAlways, .authorizedWhenInUse:
                manager.requestLocation() // immediately calls delegate function locationManager(_:didUpdateLocation    s:) defined below
            @unknown default:
                print("unknown")
            }
    }
    
}

// MARK: - Exension for CLLocationManagerDelete protocols

extension LocationManager : CLLocationManagerDelegate {
    
    
    /// Triggers whenever CLLocationManager detects a change
    /// - Parameters:
    ///   - manager: the location manager that generated the updated event
    ///   - locations: array of updated locations. most recent is at the end
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.last else {
            print("lastlast")
            return
        }
        print("the location has been updated")
        self.location = latestLocation
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("ran123")
        checkAuthorization()
        print("this running")
        self.authStatus = manager.authorizationStatus
    }
}

