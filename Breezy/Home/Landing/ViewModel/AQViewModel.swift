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
    
    var networkManager : any NetworkService { get }
    var locationManager: any LocationService { get }
    
    init(networkManager: NetworkService, locationManager: LocationService )
    
    var currAQ : (AirQuality,Placemark)?  { get }
    
    var _currAQData: AirQuality { get }
    var _currPlaceData: Placemark { get }
    
    func retrieveLocationAndUpdateData() async -> Void
}


// MARK: - Home View's View Model
@Observable
class AQViewModel: Locateable {
    
    // Use "any" to define this is an Existential Type (protocol as the type)
    let networkManager : any NetworkService
    let locationManager: any LocationService
    
    required init(networkManager: any NetworkService, locationManager: any LocationService) {
        self.networkManager = networkManager
        self.locationManager = locationManager
    }
    
    
    
    private (set) var currAQ : (AirQuality,Placemark)?
    private (set) var historicalData : AirQuality?
    
    var _currAQData: AirQuality {
        currAQ?.0 ?? AirQuality.mockAQ
    }
    
    var _currPlaceData: Placemark {
        currAQ?.1 ?? Placemark.mockPlacemark
    }
    
    /// Retrieves the current location, updates it with air quality data, and performs geoReverse on that location
    func retrieveLocationAndUpdateData() async {
        guard let currentLocation = locationManager.manager.location else {
            print("error")
            return
        }
        do {
            if locationManager.shouldUpdate  {
                print("updating aq")
                let (lon,lat) = (currentLocation.coordinate.longitude, currentLocation.coordinate.latitude)
                
                let airQuality = try await networkManager.getPollutionData(lon: lon, lat: lat)
                
                guard let placemark = await locationManager.performGeoReverse() else {
                    print("error in geo")
                    return
                }
                
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
