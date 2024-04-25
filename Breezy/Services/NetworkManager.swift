//
//  NetworkManager.swift
//  Breezy
//
//  Created by Kein Li on 3/26/24.
//

import Foundation

// MARK: - Protocol for Network Services
protocol NetworkService {
    func getPollutionData(lon: Double, lat: Double) async throws -> AirQuality
    func getHistoricalData(lon: Double, lat: Double, start: TimeInterval, end: TimeInterval) async throws -> AirQuality
}
    

enum NetworkErrors: Error {
    case invalidURL
    case invalidRequest
}

enum APIErrors: Error {
    case invalidAPIKey
}

/// Main network manager used to make API calls
class NetworkManager: NetworkService {
    
    func getPollutionData(lon: Double, lat: Double) async throws -> AirQuality {
        
        guard let key = ProcessInfo.processInfo.environment["API_KEY"] else {
            throw APIErrors.invalidAPIKey
        }
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/air_pollution?lat=\(lat)&lon=\(lon)&appid=\(key)") else {
            throw NetworkErrors.invalidURL
        }
        
        let (data,response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkErrors.invalidRequest
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        let airQuality = try decoder.decode(AirQuality.self, from: data)
        return airQuality
    }
    
    func getHistoricalData(lon: Double, lat: Double, start: TimeInterval, end: TimeInterval) async throws -> AirQuality {
        
        guard let key = ProcessInfo.processInfo.environment["API_KEY"] else {
            throw APIErrors.invalidAPIKey
        }
        
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/air_pollution/history?lat=\(lat)&lon=\(lon)&start=\(start)&end=\(end)&appid=\(key)") else {
            throw NetworkErrors.invalidURL
        }
        
        let (data,response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkErrors.invalidRequest
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        let airQuality = try decoder.decode(AirQuality.self, from: data)
        return airQuality
    }
}





let airQualityMock = AirQuality(
    coord: Coord(lon: 50, lat: 50),
    list: [
        PrimaryData(
            dt: Date(),
            main: AQI(aqi: 1),
            pollutants: Pollutants(
                co: 201.94053649902344,
                no: 0.01877197064459324,
                no2: 0.7711350917816162,
                o3: 68.66455078125,
                so2: 0.6407499313354492,
                pm25: 0.5,
                pm10: 0.540438711643219,
                nh3: 0.12369127571582794
            )
        )
    ]
)
