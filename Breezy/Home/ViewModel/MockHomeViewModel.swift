//
//  MockHomeViewModel.swift
//  Breezy
//
//  Created by Kein Li on 4/24/24.
//

import Foundation


// MARK: - Home View's View Model
@Observable
class MockHomeViewModel: ViewModel {
    
   
    typealias Network = NetworkService
    typealias Location = LocationService
    
    var places = [(AirQuality,Placemark)]()
    private (set) var currAQ : (AirQuality,Placemark)? = (AirQuality.mockAQ, Placemark.mockPlacemark)
    private (set) var historicalData: AirQuality?
    
    var _currAQData: AirQuality {
        AirQuality.mockAQ
    }
    
    var _currPlaceData: Placemark{
        Placemark.mockPlacemark
    }
    
    var _currHistoricalData: [PrimaryData] {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-dd-MM"
        
        var set = Set<String>()
        var primaryData = [PrimaryData]()
        for data in AirQuality.mockHistoricalAQ.list {
            let dateStr = dateFormatter.string(from: data.dt)
            let (result, _ ) = set.insert(dateStr)
            if result { primaryData.append(data) }
        }
        return primaryData.sorted(by: { $0.dt < $1.dt })
    }
    
    var currentHistory: Historical = .week
    var timeDifference: (TimeInterval, TimeInterval) {
        let end  = Date()
        switch currentHistory {
            case .week:
                let start = Calendar.current.date(byAdding: .day, value: -7, to: end)!
                return (start.timeIntervalSince1970, end.timeIntervalSince1970)
            case .month:
                let start = Calendar.current.date(byAdding: .month, value: -1, to: end)!
                return (start.timeIntervalSince1970, end.timeIntervalSince1970)
            case .sixMonths:
                let start = Calendar.current.date(byAdding: .month, value: -6, to: end)!
                return (start.timeIntervalSince1970, end.timeIntervalSince1970)
            case .year:
                let start = Calendar.current.date(byAdding: .year, value: -1, to: end)!
                return (start.timeIntervalSince1970, end.timeIntervalSince1970)
        }
    }
    
    var networkManager : NetworkService
    var locationManager: LocationService
    
    required init(networkManager: Network, locationManager: Location ) {
        self.networkManager = networkManager
        self.locationManager = locationManager
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
    
    func retrieveHistoricalData() async { 
        guard let currentLocation = locationManager.getLocation() else { return }
        
        do {
            let (lon,lat) = (currentLocation.coordinate.longitude, currentLocation.coordinate.latitude)
//            let reuslt = try await
        } catch {
            
        }
        
        
    }
}
