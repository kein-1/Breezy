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
    typealias LocationName = String
    
    var networkManager : Network { get set }
    var locationManager: Location { get set }
    
    init(networkManager: Network, locationManager: Location)
    
    var places : [(AirQuality,LocationName)] { get set }
    var currentLocationAQ : (AirQuality,LocationName)?  { get set }
    func retrieveLocationAndUpdate() async -> Void
}


// MARK: - Home View's View Model
@Observable
class HomeViewModel: ViewModel {
   
    
    // Define type alias for the associated type, allowing more flexibility
    // Say some other class wants to conform to this protocol. It can then change its definition of Network and Location
    // I.e maybe we have some other service or implementation we want to use
    typealias Network = NetworkService
    typealias Location = LocationService
    
    
    var places = [(AirQuality,LocationName)]()
    var currentLocationAQ : (AirQuality,LocationName)?
    
    
    var networkManager : NetworkService
    var locationManager: LocationService
    
    required init(networkManager: Network, locationManager: Location ) {
        self.networkManager = networkManager
        self.locationManager = locationManager
    }
    
    var location : CLLocation? {
        return locationManager.currLocation ?? nil
    }
    
    
    
    func getData(lon: Double, lat: Double) async -> AirQuality? {
        do {
            let airQuality = try await networkManager.getPollutionData(lon: lon, lat: lat)
            return airQuality
        }  catch let error as NetworkErrors  {
            print("error in network call")
        } catch APIErrors.invalidAPIKey {
            print("error in api-key")
        } catch {
            print(error)
        }
        return nil
    }
    
    
    
    /// Retrieve user's prev/curr location, then make network call if either prev location is null or the distance between the curr and last is more than the threshold
    func retrieveLocationAndUpdate() async {
        guard let currentLocation = locationManager.getLocation() else { return }
        
        print(locationManager.lastUpdated)
        if locationManager.lastUpdated  {
            print("updating aq")
            let (lon,lat) = (currentLocation.coordinate.longitude, currentLocation.coordinate.latitude)
            guard let airQuality = await getData(lon: lon, lat: lat) else { return }
            self.currentLocationAQ = (airQuality, "")
        }
        return
    }
    
    
    
}



