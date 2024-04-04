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
    
    var networkManager : Network { get set }
    var locationManager: Location { get set }
    
    init(networkManager: Network, locationManager: Location)
}


// MARK: - Home View's View Model
@Observable
class HomeViewModel: ViewModel {
   
    
    // Define type alias for the associated type, allowing more flexibility
    // Say some other class wants to conform to this protocol. It can then change its definition of Network and Location
    // I.e maybe we have some other service or implementation we want to use
    typealias Network = NetworkService
    typealias Location = LocationService
    
    var places = [AirQuality]()
    var currentLocationAQ : AirQuality? {
        didSet {
            print("changed")
        }
    }
    var networkManager : NetworkService
    var locationManager: LocationService
    
    required init(networkManager: Network, locationManager: Location ) {
        self.networkManager = networkManager
        self.locationManager = locationManager
    }
    
    
    func getData(lon: Double, lat: Double, updateCurrentLocation: Bool) async {
        do {
            let airQuality = try await networkManager.getPollutionData(lon: lon, lat: lat)
            if updateCurrentLocation {
                currentLocationAQ = airQuality
            } else {
                places.append(airQuality)
            }
        }  catch let error as NetworkErrors  {
            print("error in network call")
        } catch APIErrors.invalidAPIKey {
            print("error in api-key")
        } catch {
            print(error)
        }
    }
    
    
    /// Update user's current location and data
    func retrieveLocationAndUpdate() async {
        
        guard let locationData = locationManager.getCurrentLocation() else {
            print("not available")
            return
        }
        let (lon,lat) = (locationData.coordinate.longitude, locationData.coordinate.latitude)
        await getData(lon: lon, lat: lat, updateCurrentLocation: true)
        print("home")
    }
    
}



