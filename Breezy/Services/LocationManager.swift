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
    var currLocation: CLLocation? { get }
    var authStatus: CLAuthorizationStatus { get }
    func getLocation() -> CLLocation?
    var threshold : CLLocationDistance { get }
    var lastUpdated : Bool { get }
//    func performGeoReverse() ->
}

@Observable
class LocationManager: NSObject, LocationService {
    
    var manager: CLLocationManager = CLLocationManager()
    private (set) var currLocation: CLLocation? = nil
    var authStatus: CLAuthorizationStatus = CLAuthorizationStatus.denied
    var threshold : CLLocationDistance = 300
    var lastUpdated : Bool = false
    
    // singleton design for sharing
    static let shared = LocationManager()
    
    private override init() {
        super.init()
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        manager.delegate = self // utilize delegate pattern
    }
    
    
    func getLocation() -> CLLocation? {
        checkAuthorization()
        return currLocation
    }
        
    private func checkAuthorization()  {
        
        switch manager.authorizationStatus {
            case .notDetermined:
                manager.requestWhenInUseAuthorization()
            case .restricted:
                print("restricted !")
            case .denied:
                manager.requestWhenInUseAuthorization()
            case .authorizedAlways, .authorizedWhenInUse:
            print("in use")
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
        print("running update location delegate")
        guard let latestLocation = locations.last else {
            print("lastlast")
            return
        }
        
        guard let currLocation = self.currLocation else {
            self.currLocation = latestLocation
            self.lastUpdated = true
            return
        }
        
        print("ran here")
        if currLocation.distance(from: latestLocation) > self.threshold {
            self.lastUpdated = true
        } else {
            self.lastUpdated = false
        }
        self.currLocation = latestLocation
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("running auth delegate")
        checkAuthorization()
    }
}

