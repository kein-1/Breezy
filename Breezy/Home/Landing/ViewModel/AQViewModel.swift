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
    
    var currAirQualityPlacemark : AirQualityPlacemark?  { get }
    var currAirQuality: AirQuality { get }
    var currPlacemark: Placemark { get }
    
    var showCurrentLocationData: Bool { get set }
    var searchedAQ: AirQualityPlacemark? { get set}
    
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
    
    var currAirQualityPlacemark: AirQualityPlacemark?
    
    var currAirQuality : AirQuality {
        currAirQualityPlacemark?.aq ?? AirQuality.mockAQ
    }
    
    var currPlacemark: Placemark {
        currAirQualityPlacemark?.placemark ?? Placemark.mockPlacemark
    }
    
    var showCurrentLocationData: Bool = false
    var searchedAQ: AirQualityPlacemark?
    
    /// Retrieves the current location, updates it with air quality data, and performs geoReverse on that location
    func retrieveLocationAndUpdateData() async {
        guard let currentLocation = locationManager.manager.location else {
            print("error")
            return
        }
        
        do {
            if locationManager.shouldUpdate  {
                print("updating aq")
                let (lat,lon) = (currentLocation.coordinate.latitude,currentLocation.coordinate.longitude)
                
                async let airQuality = networkManager.getPollutionData(lat: lat,lon: lon)
                async let placemark = locationManager.performGeoReverse(lat: lat, lon: lon)
                
                let (aq,place) = try await (airQuality, placemark)
                
                self.currAirQualityPlacemark = AirQualityPlacemark(aq: aq, placemark: place)
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
