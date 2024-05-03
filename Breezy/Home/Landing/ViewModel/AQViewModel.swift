//
//  HomeViewModel.swift
//  Breezy
//
//  Created by Kein Li on 3/28/24.
//

import Foundation
import Observation
import CoreLocation

// MARK: - ViewModel protocol. AnyObject to allow @Bindable since it expects a class
protocol Locateable : Observable, AnyObject {
    
    associatedtype Network
    associatedtype Location
    
    var networkManager : Network { get }
    var locationManager: Location { get }
    
    init(networkManager: Network, locationManager: Location)
    
    var places : [(AirQuality,Placemark)] { get }
    var currAQ : (AirQuality,Placemark)?  { get }
    
    var _currAQData: AirQuality { get }
    var _currPlaceData: Placemark { get }
    
    func retrieveLocationAndUpdateData() async -> Void
}


// MARK: - Home View's View Model
@Observable
class AQViewModel: Locateable {
   
    // Define type alias for the associated type, allowing more flexibility
    // Say some other class wants to conform to this protocol. It can then change its definition of Network and Location
    // I.e maybe we have some other service or implementation we want to use
    typealias Network = NetworkService
    typealias Location = LocationService
    
    var places = [(AirQuality,Placemark)]()
    private (set) var currAQ : (AirQuality,Placemark)?
    private (set) var historicalData : AirQuality?
    
    var _currAQData: AirQuality {
        currAQ?.0 ?? AirQuality.mockAQ
    }
    
    var _currPlaceData: Placemark{
        currAQ?.1 ?? Placemark.mockPlacemark
    }
    
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
            if locationManager.shouldUpdate  {
                print("updating aq")
                let (lon,lat) = (currentLocation.coordinate.longitude, currentLocation.coordinate.latitude)
                let airQuality = try await networkManager.getPollutionData(lon: lon, lat: lat)
                guard let placemark = await locationManager.performGeoReverse() else { return }
                self.currAQ = (airQuality, placemark)
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
