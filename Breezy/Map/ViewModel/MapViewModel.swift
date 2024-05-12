//
//  MapViewModel.swift
//  Breezy
//
//  Created by Kein Li on 5/8/24.
//

import Foundation
import Observation
import MapKit
import _MapKit_SwiftUI


protocol MapViewProtocol: AnyObject {
    
    var networkManager : any NetworkService { get }
    var locationManager : any LocationService { get }
    var markers: [CustomMarkerModel] { get }
    func requestLocation() -> CLLocation
}

@Observable
class MapViewModel: MapViewProtocol {
    
    let networkManager: any NetworkService
    let locationManager:  any LocationService
    var markers = [CustomMarkerModel]()
    
    init(networkManager: any NetworkService, locationManager: any LocationService) {
        self.networkManager = networkManager
        self.locationManager = locationManager
    }
    
    func requestLocation() -> CLLocation {
        guard let location = locationManager.manager.location else {
            print("no last")
            return CLLocation()
        }
        print("location is good !")
        print(location)
        return location
    }
    
    /// Setup the initial Map view's camera position
    /// - Returns: A MapCameraPosition object based on the user's current location
    func retrievePosition() -> MapCameraPosition {
        guard let location = locationManager.manager.location else {
            return MapCameraPosition.automatic
        }
        return MapCameraPosition.region(.init(center: location.coordinate, latitudinalMeters: 100, longitudinalMeters: 100))
    }
    
    
    
    /// Makes a network call to a pin provided by the user then updates
    /// the array
    /// - Parameter coord: <#coord description#>
    func addCoordinate(coord: CLLocationCoordinate2D) async {
        let (lat,lon) = (coord.latitude,coord.longitude)
        do {
            async let airQuality = networkManager.getPollutionData(lat: lat, lon: lon)
            async let placeMark = locationManager.performGeoReverse(lat: lat, lon: lon)
            
            let (aq,pm) = try await (airQuality, placeMark)
            
            let customMarkerModel = CustomMarkerModel(aq: aq, coord: coord, placeMark: pm)
            markers.append(customMarkerModel)
            print(markers)
        } catch {
            print(error)
        }
    }
}
