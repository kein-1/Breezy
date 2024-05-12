//
//  NetworkManager.swift
//  Breezy
//
//  Created by Kein Li on 3/26/24.
//

import Foundation

// MARK: - Protocol for Network Services
protocol NetworkService {
    
    var decoder: JSONDecoder { get }
    
    func getPollutionData(lat: Double, lon: Double) async throws -> AirQuality
    func getHistoricalData(lat: Double, lon: Double, start: TimeInterval, end: TimeInterval) async throws -> AirQuality
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
    
    lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }()
    
    func getPollutionData(lat: Double, lon: Double) async throws -> AirQuality {
        
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
        
        let airQuality = try decoder.decode(AirQuality.self, from: data)
        return airQuality
    }
    
    func getHistoricalData(lat: Double, lon: Double, start: TimeInterval, end: TimeInterval) async throws -> AirQuality {
        
        guard let key = ProcessInfo.processInfo.environment["API_KEY"] else {
            throw APIErrors.invalidAPIKey
        }
        
        let start = Int(start)
        let end = Int(end)
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/air_pollution/history?lat=\(lat)&lon=\(lon)&start=\(start)&end=\(end)&appid=\(key)") else {
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
