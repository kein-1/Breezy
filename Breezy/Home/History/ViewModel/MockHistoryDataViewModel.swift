//
//  MockHistoryDataViewModel.swift
//  Breezy
//
//  Created by Kein Li on 5/3/24.
//

import Foundation

// MARK: - Mock history view model
@Observable
class MockHistoryDataViewModel : HistoricalDataProtocol {
    
    typealias Network = NetworkService
    typealias Location = LocationService
    
    
    var networkManager : any NetworkService
    var locationManager: any LocationService
    
    required init(networkManager: Network, locationManager: Location ) {
        self.networkManager = networkManager
        self.locationManager = locationManager
        self.historicalData = AirQuality.mockAQ
    }
    
    private (set) var historicalData : AirQuality?
    var currHistoricalData: [PrimaryData] {
        guard let _historicalData = historicalData else { return [PrimaryData]() }
        
        var set = Set<String>()
        var primaryData = [PrimaryData]()
        for data in AirQuality.mockHistoricalAQ.list {
            let dateStr = data.dt.formatted(.dateTime.day().month().year())
            if set.insert(dateStr).inserted { primaryData.append(data) }
        }
        return primaryData.sorted(by: { $0.dt < $1.dt })
    }
    
    var currentHistory: Historical = .week

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
        guard let currentLocation = locationManager.getLocation() else { return }
//        do {
//            let (lon,lat) = (currentLocation.coordinate.longitude, currentLocation.coordinate.latitude)
//            let airQuality = try await networkManager.getHistoricalData(lon: lon, lat: lat, start: self.timeDifference.0, end: self.timeDifference.1)
//            self.historicalData = airQuality
//        } catch NetworkErrors.invalidRequest {
//            print("error in network call")
//        } catch APIErrors.invalidAPIKey {
//            print("error in api-key")
//        } catch {
//            print(error)
//        }
    }
    
}
