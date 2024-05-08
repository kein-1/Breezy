//
//  MockHomeViewModel.swift
//  Breezy
//
//  Created by Kein Li on 4/24/24.
//

import Foundation


// MARK: - Home View's View Model
@Observable
class MockAQViewModel: Locateable {
    
    typealias Network = NetworkService
    typealias Location = LocationService
    
    var networkManager : any NetworkService
    var locationManager: any LocationService
    
    var places = [(AirQuality,Placemark)]()
    
    required init(networkManager: any Network, locationManager: any Location ) {
        self.networkManager = networkManager
        self.locationManager = locationManager
    }
    
    private (set) var currAQ : (AirQuality,Placemark)? = (AirQuality.mockAQ, Placemark.mockPlacemark)
    
    var _currAQData: AirQuality {
        AirQuality.mockAQ
    }
    
    var _currPlaceData: Placemark{
        Placemark.mockPlacemark
    }
    
    
    /// Mock Retrieves the current location, updates it with air quality data, and performs geoReverse on that location
    func retrieveLocationAndUpdateData() async {
        guard let currentLocation = locationManager.getLocation() else { return }
//
//        do {
//            if locationManager.lastUpdated  {
//                print("updating aq")
//                let (lon,lat) = (currentLocation.coordinate.longitude, currentLocation.coordinate.latitude)
//                let airQuality = try await networkManager.getPollutionData(lon: lon, lat: lat)
//                guard let placemark = await locationManager.performGeoReverse() else { return }
//                self.currAQ = (airQuality, placemark)
//            }
//        } catch let error as NetworkErrors  {
//            print("error in network call")
//        } catch APIErrors.invalidAPIKey {
//            print("error in api-key")
//        } catch {
//            print(error)
//        }
        
    }
}
