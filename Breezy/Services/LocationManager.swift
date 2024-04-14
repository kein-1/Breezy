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
    func performGeoReverse() async -> Placemark?
}

class LocationManager: NSObject, LocationService {
    
    var manager: CLLocationManager = CLLocationManager()
    private (set) var currLocation: CLLocation? = nil
    var authStatus: CLAuthorizationStatus = CLAuthorizationStatus.denied
    var threshold : CLLocationDistance = 300
    var lastUpdated : Bool = false
    static var shared = LocationManager()
    
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
    
    
    /// Uses current CLLocation and retrieves a human readable content
    /// - Returns: A Placemark model
    func performGeoReverse() async -> Placemark? {
        guard let currLocation = currLocation else { return nil }
        
        do {
            let geoCoder = CLGeocoder()
            let placemarks = try await geoCoder.reverseGeocodeLocation(currLocation, preferredLocale: nil)
            let result = ""
            for placemark in placemarks {
                let name = placemark.name ?? "Unknown"
                let locality = placemark.locality ?? "Unknown"
                let administrativeArea = placemark.administrativeArea ?? "Unknown"
                let country = placemark.country ?? "Unknown"
                
                let placeMark = Placemark(name: name, locality: locality, administrativeArea: administrativeArea, country: country)
                return placeMark
            }
        } catch {
            
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

