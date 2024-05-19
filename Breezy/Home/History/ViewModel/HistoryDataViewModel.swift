//
//  ChartsViewModel.swift
//  Breezy
//
//  Created by Kein Li on 5/2/24.
//

import Foundation


// MARK: - Historical content view model protocol
protocol HistoricalDataProtocol : Observable, AnyObject {
    
    var networkManager : any NetworkService { get }
    var locationManager: any LocationService { get }
    
    init(networkManager: any NetworkService, locationManager: any LocationService )
    
    var historicalData : AirQuality? { get }
    var currHistoricalData: [PrimaryData] { get }
    var currentHistory: TimeFrame { get set }
    var timeDifference: (start: TimeInterval, end: TimeInterval) { get }
    
    func retrieveHistoricalData() async -> Void
}

@Observable
class HistoryDataViewModel : HistoricalDataProtocol {
    
    private (set) var historicalData : AirQuality? // weekly,monthly,yearly
    var networkManager : any NetworkService
    var locationManager: any LocationService
    
    required init(networkManager: any NetworkService, locationManager: any LocationService ) {
        self.networkManager = networkManager
        self.locationManager = locationManager
    }
    
    var currHistoricalData: [PrimaryData] {
        guard let _historicalData = historicalData else { return [PrimaryData]() }
        
        var set = Set<String>()
        var primaryData = [PrimaryData]()
        for data in _historicalData.list {
            let dateStr = data.dt.formatted(.dateTime.day().month().year())
            if set.insert(dateStr).inserted { primaryData.append(data) }
        }
        return primaryData.sorted(by: { $0.dt < $1.dt })
    }
    
    var currentHistory: TimeFrame = .week
    
    var timeDifference: (start: TimeInterval, end: TimeInterval) {
        let end  = Date()
        let start : Date
        switch currentHistory {
            case .week:
                start = Calendar.current.date(byAdding: .day, value: -7, to: end)!
            case .month:
                start = Calendar.current.date(byAdding: .month, value: -1, to: end)!
            case .year:
                start = Calendar.current.date(byAdding: .year, value: -1, to: end)!
        }
        return (start.timeIntervalSince1970, end.timeIntervalSince1970)
    }
    
    
    func retrieveHistoricalData() async {
        guard let currentLocation = locationManager.manager.location else { return }
        do {
            let (lat, lon) = (currentLocation.coordinate.latitude, currentLocation.coordinate.longitude)
            let airQuality = try await networkManager.getHistoricalData(lat: lat, lon: lon, start: self.timeDifference.0, end: self.timeDifference.1)
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
