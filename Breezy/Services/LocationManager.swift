//
//  LocationService.swift
//  Breezy
//
//  Created by Kein Li on 3/29/24.
//

import Foundation
import CoreLocation


/// Protocol for Location Service
protocol LocationService {
    var manager : CLLocationManager { get }
    var threshold : CLLocationDistance { get }
    var shouldUpdate : Bool { get }
    
    func performGeoReverse() async -> Placemark?
}

class LocationManager: NSObject, LocationService {
    
    var manager: CLLocationManager = CLLocationManager()
    var threshold : CLLocationDistance = 300
    var shouldUpdate : Bool = false
    static var shared = LocationManager()
    
    private override init() {
        super.init()
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        manager.delegate = self // utilize delegate pattern
    }
        
    /// Internal helper function to check authroization
    private func checkAuthorization()  {
        switch manager.authorizationStatus {
            case .notDetermined:
                manager.requestWhenInUseAuthorization()
            case .restricted:
                manager.requestWhenInUseAuthorization()
            case .denied:
                manager.requestWhenInUseAuthorization()
            case .authorizedAlways, .authorizedWhenInUse:
                manager.requestLocation() // immediately calls delegate function locationManager(_:didUpdateLocation    s:) defined below
            default:
                print("unknown")
            }
    }
    
    
    /// Uses current CLLocation and retrieves a human readable content
    /// - Returns: A Placemark model
    func performGeoReverse() async -> Placemark? {
        guard let currLocation = manager.location else { return nil }
        
        let geoCoder = CLGeocoder()
        guard let placemarks = try? await geoCoder.reverseGeocodeLocation(currLocation, preferredLocale: nil) else {
            print("error in reverse geocode")
            return nil
        }
                
        for placemark in placemarks {
            let name = placemark.name
            let locality = placemark.locality
            let administrativeArea = placemark.administrativeArea
            let country = placemark.country
            let placeMark = Placemark(name: name, locality: locality, administrativeArea: administrativeArea, country: country)
            return placeMark
        }
        return nil
    }
    
}

// MARK: - Exension for CLLocationManagerDelete protocols

extension LocationManager : CLLocationManagerDelegate {
    
    /// Triggers whenever CLLocationManager detects a change
    /// - Parameters:
    ///   - manager: the location manager that generated the updated event
    ///   - locations: array of updated locations. most recent is at the end
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locations = Array(locations.suffix(2))
        if locations.count < 2 {
            self.shouldUpdate = true
            return
        }
        let beforeLast = locations[0], last = locations[1]
        self.shouldUpdate = last.distance(from: beforeLast) > self.threshold ? true : false
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    
    /// Runs when the location manager is first created and when
    /// - Parameter manager: the location manager
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("running auth delegate")
        checkAuthorization()
    }
}

