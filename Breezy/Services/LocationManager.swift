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
    func performGeoReverse(lat: CLLocationDegrees, lon: CLLocationDegrees) async throws -> Placemark
}


class LocationManager: NSObject, LocationService {
    
    var manager: CLLocationManager = CLLocationManager()
    var threshold : CLLocationDistance = 300
    var shouldUpdate : Bool = false
    static var shared = LocationManager()
    private lazy var geoCoder : CLGeocoder = {
        CLGeocoder()
    }()
    
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
    
    
    
    /// Uses given lat/lon to retrieve a human readable location
    /// - Parameters:
    ///   - lat: latitude
    ///   - lon: longitude
    /// - Returns: Placemark object containing the data
    func performGeoReverse(lat: CLLocationDegrees, lon: CLLocationDegrees) async throws -> Placemark {
        let location : CLLocation = CLLocation(latitude: lat, longitude: lon)
        let placemarks = try await self.geoCoder.reverseGeocodeLocation(location)
        
        var name : String?
        var locality : String?
        var administrativeArea : String?
        var country : String?
        for placemark in placemarks {
            name = placemark.name
            locality = placemark.locality
            administrativeArea = placemark.administrativeArea
            country = placemark.country
        }
        return Placemark(name: name, locality: locality, administrativeArea: administrativeArea, country: country)
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
        print("location error" , error)
    }
    
    
    /// Runs when the location manager is first created and when
    /// - Parameter manager: the location manager
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkAuthorization()
    }
}

