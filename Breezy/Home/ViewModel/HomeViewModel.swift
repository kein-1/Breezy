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
protocol ViewModel : Observable, AnyObject {
    
    associatedtype Network
    associatedtype Location
    
    var networkManager : Network { get }
    var locationManager: Location { get }
    
    init(networkManager: Network, locationManager: Location)
    
    var places : [(AirQuality,Placemark)] { get }
    var currAQ : (AirQuality,Placemark)?  { get }
    var historicalData : AirQuality? { get }
    
    var _currAQData: AirQuality { get }
    var _currPlaceData: Placemark { get }
    var _currHistoricalData: [PrimaryData] { get }
    
    var currentHistory: Historical { get set }
    var timeDifference: (TimeInterval, TimeInterval) { get }
    
    func retrieveLocationAndUpdateData() async -> Void
    func retrieveHistoricalData() async -> Void
}


// MARK: - Home View's View Model
@Observable
class HomeViewModel: ViewModel {
   
    
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
    
    var _currHistoricalData: [PrimaryData] {
        guard let _historicalData = historicalData else { return [PrimaryData]() }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-dd-MM"
        
        var set = Set<String>()
        var primaryData = [PrimaryData]()
        for data in _historicalData.list {
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
                
                await retrieveHistoricalData()
            }
        } catch let error as NetworkErrors  {
            print("error in network call")
        } catch APIErrors.invalidAPIKey {
            print("error in api-key")
        } catch {
            print(error)
        }
    }
    
    
    func retrieveHistoricalData() async {
        guard let currentLocation = locationManager.getLocation() else { return }
        do {
            let (lon,lat) = (currentLocation.coordinate.longitude, currentLocation.coordinate.latitude)
            let airQuality = try await networkManager.getHistoricalData(lon: lon, lat: lat, start: self.timeDifference.0, end: self.timeDifference.1)
            self.historicalData = airQuality
        } catch NetworkErrors.invalidRequest {
            print("error in network call")
        } catch APIErrors.invalidAPIKey {
            print("error in api-key")
        } catch {
            print(error)
        }
    }
    
}
