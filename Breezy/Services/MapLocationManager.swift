//
//  MapLocationManager.swift
//  Breezy
//
//  Created by Kein Li on 5/10/24.
//

import Foundation
import CoreLocation

protocol MapLocationService {
    var manager : CLLocationManager { get }
}

class MapLocationManager: NSObject, MapLocationService {
    
    let manager : CLLocationManager = CLLocationManager()
    override init() {
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
                print("restricted !")
            case .denied:
                manager.requestWhenInUseAuthorization()
            case .authorizedAlways, .authorizedWhenInUse:
                manager.requestLocation() // immediately calls delegate function locationManager(_:didUpdateLocation    s:) defined below
            @unknown default:
                print("unknown")
            }
    }
}


extension MapLocationManager : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) { }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    /// Runs when the location manager is first created and when
    /// - Parameter manager: the location manager
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("running auth delegate123")
        checkAuthorization()
    }
}


