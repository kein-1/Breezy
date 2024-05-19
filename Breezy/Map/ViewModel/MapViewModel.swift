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


protocol MapViewProtocol: Observable, AnyObject {
    
    var networkManager : any NetworkService { get }
    var locationManager : any LocationService { get }
    
    var markers: [CustomMarkerModel] { get }
    var selectedMarker: CustomMarkerModel? { get set }
    func initializeMarker() async
    
    func configureLocationContent(coord: CLLocationCoordinate2D, setup: Bool) async
    
    var cameraPosition : MapCameraPosition { get }
    func updateCameraPosition()
    
}

@Observable
class MapViewModel: MapViewProtocol {
    
    
    
    let networkManager: any NetworkService
    let locationManager:  any LocationService
    var markers = [CustomMarkerModel]()
    
    var selectedMarker: CustomMarkerModel? = nil {
        didSet {
            if selectedMarker == nil {
                print("changed to nil ")
            } else {
                print("not nil")
            }
        }
    }
    
    
    init(networkManager: any NetworkService, locationManager: any LocationService) {
        self.networkManager = networkManager
        self.locationManager = locationManager
    }
    
    func initializeMarker() async {
        guard let location = locationManager.manager.location else {
            print("no last")
            self.selectedMarker = CustomMarkerModel.mockData
            return
        }
        await configureLocationContent(coord: location.coordinate, setup: true)
    }
    
    
    var cameraPosition : MapCameraPosition = MapCameraPosition.userLocation(fallback: .automatic)
    
    func updateCameraPosition() {
        
    }
    
    
    /// Sets up the custom marker
    /// - Parameters:
    ///   - coord: The location coordiante
    ///   - setup: Either the first time it is rendered or not
    func configureLocationContent(coord: CLLocationCoordinate2D, setup: Bool) async {
        let (lat,lon) = (coord.latitude,coord.longitude)
        do {
            async let airQuality = networkManager.getPollutionData(lat: lat, lon: lon)
            async let placeMark = locationManager.performGeoReverse(lat: lat, lon: lon)
            
            let (aq,pm) = try await (airQuality, placeMark)
            
            let customMarkerModel = CustomMarkerModel(aq: aq, coord: coord, placeMark: pm)
            markers.append(customMarkerModel)
            if setup {
                self.selectedMarker = customMarkerModel
            }
            print(markers)
        } catch {
            print(error)
        }
    }
}
