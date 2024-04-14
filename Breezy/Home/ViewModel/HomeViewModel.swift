//
//  HomeViewModel.swift
//  Breezy
//
//  Created by Kein Li on 3/28/24.
//

import Foundation
import Observation
import CoreLocation

// MARK: - ViewModel protocol using associated types
protocol ViewModel {
    
    associatedtype Network
    associatedtype Location
    associatedtype PlaceData
    
    var networkManager : Network { get set }
    var locationManager: Location { get set }
    
    init(networkManager: Network, locationManager: Location)
    
    var places : [(AirQuality,PlaceData)] { get set }
    var currentLocationAQ : (AirQuality,PlaceData)?  { get set }
    func retrieveLocationAndUpdateData() async -> Void
}


// MARK: - Home View's View Model
@Observable
class HomeViewModel: ViewModel {
   
    
    // Define type alias for the associated type, allowing more flexibility
    // Say some other class wants to conform to this protocol. It can then change its definition of Network and Location
    // I.e maybe we have some other service or implementation we want to use
    typealias Network = NetworkService
    typealias Location = LocationService
    typealias PlaceData = Placemark
    
    var places = [(AirQuality,PlaceData)]()
    var currentLocationAQ : (AirQuality,PlaceData)?
    
    
    var networkManager : NetworkService
    var locationManager: LocationService
    
    required init(networkManager: Network, locationManager: Location ) {
        self.networkManager = networkManager
        self.locationManager = locationManager
    }
    
    
    
    /// Retrieves the current location, updates it with air quality data, and performs geoReverse on that location
    func retrieveLocationAndUpdateData() async {
        guard let currentLocation = locationManager.getLocation() else { return }
        
        do {
            if locationManager.lastUpdated  {
                print("updating aq")
                let (lon,lat) = (currentLocation.coordinate.longitude, currentLocation.coordinate.latitude)
                let airQuality = try await networkManager.getPollutionData(lon: lon, lat: lat)
                guard let placemark = await locationManager.performGeoReverse() else { return }
                self.currentLocationAQ = (airQuality, placemark)
            }
        } catch let error as NetworkErrors  {
            print("error in network call")
        } catch APIErrors.invalidAPIKey {
            print("error in api-key")
        } catch {
            print(error)
        }
    }
    
}



