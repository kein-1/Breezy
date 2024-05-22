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


@Observable
class MockMapViewModel: MapViewProtocol {
    
    let networkManager: any NetworkService
    let locationManager:  any LocationService
    var markers = [CustomMarkerModel]()
    
    var selectedMarker: CustomMarkerModel? = nil 
    
    var showMarker : Bool = false
    var showSearchView: Bool = false
    
    
    init(networkManager: any NetworkService, locationManager: any LocationService) {
        self.networkManager = networkManager
        self.locationManager = locationManager
        
    }
    
    func initializeMarker() async {
        let tempMarker  = CustomMarkerModel.mockData
        markers.append(tempMarker)
        self.selectedMarker = tempMarker
    }
    
    var cameraPosition : MapCameraPosition = MapCameraPosition.region(.init(center: .newYork, latitudinalMeters: 50, longitudinalMeters: 50))
    func updateCameraPosition(new center: CLLocationCoordinate2D) {}
    
    
    /// Sets up the custom marker
    /// - Parameters:
    ///   - coord: The location coordiante
    ///   - setup: Either the first time it is rendered or not
    func configureLocationContent(coord: CLLocationCoordinate2D) async {
        
    }
}
