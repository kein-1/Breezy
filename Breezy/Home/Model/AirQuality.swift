//
//  AirQuality.swift
//  Breezy
//
//  Created by Kein Li on 3/26/24.
//

import Foundation

// MARK: - Air Quality Struct

struct AirQuality: Codable {
    
    let coord: Coord
    let list: [PrimaryData]
}

// MARK: - Primary data
struct PrimaryData: Codable {
    
    let dt: Date
    let main: AQI
    let pollutants: Pollutants
    
    enum CodingKeys: String, CodingKey {
        case dt, main
        case pollutants = "components"
    }
   
}

// MARK: - Coord
struct Coord: Codable {
    let lon: Double
    let lat: Double
}

// MARK: - Air quality value
struct AQI: Codable {
    let aqi: Int
}

// MARK: - Pollutants
struct Pollutants: Codable, Identifiable {
    let id = UUID()
    let co: Double
    let no: Double
    let no2: Double
    let o3: Double
    let so2: Double
    let pm25: Double
    let pm10: Double
    let nh3: Double
    
    enum CodingKeys: String, CodingKey {
        case co, no, no2, o3, so2, pm10, nh3
        case pm25 = "pm2_5"
    }
}


