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
    var locationManager : any MapLocationService { get }
    var markers: [CustomMarkerModel] { get }
    func requestLocation() -> CLLocation
}

@Observable
class MapViewModel: MapViewProtocol {
    
    let networkManager: any NetworkService
    let locationManager:  any MapLocationService
    var markers = [CustomMarkerModel]()
    
    init(networkManager: any NetworkService, locationManager: any MapLocationService) {
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
    
    func retrievePosition() -> MapCameraPosition {
        guard let location = locationManager.manager.location else {
            return MapCameraPosition.automatic
        }
        return MapCameraPosition.region(.init(center: location.coordinate, latitudinalMeters: 100, longitudinalMeters: 100))
    }
    
    func addCoordinate(coord: CLLocationCoordinate2D) async {
        let (lon,lat) = (coord.longitude, coord.latitude)
        guard let airQuality = try? await networkManager.getPollutionData(lon: lon, lat: lat) else {
            return
        }
        
        let custtomMarkerModel = CustomMarkerModel(aq: airQuality, coord: coord)
        markers.append(custtomMarkerModel)
        print(markers)
    }
}
