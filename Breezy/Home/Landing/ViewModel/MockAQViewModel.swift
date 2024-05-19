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
   
    
    let networkManager : any NetworkService
    let locationManager: any LocationService
    
    
    required init(networkManager: any NetworkService, locationManager: any LocationService ) {
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
    
 
    
    /// Mock Retrieves the current location, updates it with air quality data, and performs geoReverse on that location
    func retrieveLocationAndUpdateData() async {
        guard let currentLocation = locationManager.manager.location else { return }
        
    }
}
