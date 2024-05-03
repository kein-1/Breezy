//
//  ChartsViewModel.swift
//  Breezy
//
//  Created by Kein Li on 5/2/24.
//

import Foundation


// MARK: - Historical content view model protocol
protocol HistoricalVMProtocol : Observable, AnyObject {
    associatedtype Network
    associatedtype Location
    
    var networkManager : Network { get }
    var locationManager: Location { get }
    
    init(networkManager: Network, locationManager: Location)
    
    var historicalData : AirQuality? { get }
    
    var currentHistory: Historical { get set }
    var timeDifference: (TimeInterval, TimeInterval) { get }
    
    func retrieveHistoricalData() async -> Void
    
}

@Observable
class HistoricalViewModel : HistoricalVMProtocol {
    
    typealias Network = NetworkService
    typealias Location = LocationService
    
    private (set) var historicalData : AirQuality?
    var networkManager : NetworkService
    var locationManager: LocationService
    
    required init(networkManager: Network, locationManager: Location ) {
        self.networkManager = networkManager
        self.locationManager = locationManager
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
