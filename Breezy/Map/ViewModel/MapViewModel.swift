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
    
    var showMarker : Bool { get set }
    var showSearchView: Bool { get set }
    
    var cameraPosition : MapCameraPosition { get set }
    
    func initializeMarker() async
    
    func configureLocationContent(coord: CLLocationCoordinate2D) async
    
    func updateCameraPosition(new center: CLLocationCoordinate2D) 
    
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
    
    var showMarker : Bool = false
    var showSearchView: Bool = false
    
    var cameraPosition : MapCameraPosition = MapCameraPosition.userLocation(fallback: .automatic)
    
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
        await configureLocationContent(coord: location.coordinate)
    }
    
    
    func updateCameraPosition(new center: CLLocationCoordinate2D) {
        cameraPosition = MapCameraPosition.region(.init(center: center, latitudinalMeters: 250, longitudinalMeters: 250))
    }
    
    
    /// Sets up the custom marker
    /// - Parameters:
    ///   - coord: The location coordiante
    ///   - setup: Either the first time it is rendered or not
    func configureLocationContent(coord: CLLocationCoordinate2D) async {
        
        do {
            let (lat,lon) = (coord.latitude,coord.longitude)
            async let airQuality = networkManager.getPollutionData(lat: lat, lon: lon)
            async let placeMark = locationManager.performGeoReverse(lat: lat, lon: lon)
            
            let (aq,pm) = try await (airQuality, placeMark)
            
            let customMarkerModel = CustomMarkerModel(aq: aq, coord: coord, placeMark: pm)
            markers.append(customMarkerModel)
            updateCameraPosition(new: coord)
            self.selectedMarker = customMarkerModel
        } catch {
            print(error)
        }
    }
}
