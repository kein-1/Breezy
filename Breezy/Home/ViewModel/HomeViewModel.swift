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
    func getData(lon: String, lat: String) async
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
    var networkManager : NetworkService
    var locationManager: LocationService
    
    required init(networkManager: Network, locationManager: Location ) {
        self.networkManager = networkManager
        self.locationManager = locationManager
    }
    
    
    func getData(lon: String, lat: String) async {
        do {
            let airQuality = try await networkManager.getPollutionData(lon: lon, lat: lat)
            print(airQuality)
            places.append(airQuality)
        }  catch let error as NetworkErrors  {
            print("error in network call")
        } catch APIErrors.invalidAPIKey {
            print("error in api-key")
        } catch {
            print(error)
        }
    }
    
}



