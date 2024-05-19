//
//  AirQuality.swift
//  Breezy
//
//  Created by Kein Li on 3/26/24.
//

import Foundation

// MARK: - Air Quality Struct

struct AirQuality: Codable, Hashable {
    
    let coord: Coord
    let list: [PrimaryData]
    
    var color: String {
        switch self._aqi.0 {
            case 1:
                "Green"
            case 2:
                "Teal"
            case 3:
                "Orange"
            case 4:
                "Purple"
            default:
                "Red"
            }
    }
    
    var description: String {
        switch self._aqi.0 {
            case 1:
                "Per USA EPA guidelines, air quality is satisfactory, and air pollution poses little or no risk."
            case 2:
                "Per USA EPA guidelines, air quality is acceptable. However, there may be a risk for some people, particularly those who are unusually sensitive to air pollution."
            case 3:
                "Per USA EPA guidelines, members of sensitive groups may experience health effects. The general public is less likely to be affected."
            case 4:
                "Per USA EPA guidelines, some members of the general public may experience health effects; members of sensitive groups may experience more serious health effects."
            default:
                "Per USA EPA guidelines, this is a health alert: the risk of health effects is increased for everyone."
            }
    }
    
    static func == (lhs: AirQuality, rhs: AirQuality) -> Bool {
        lhs.list == rhs.list
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(list)
    }
    
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


// MARK: - Retrieving properties
extension AirQuality {
    
    var _co: Double {
        self.list[0].pollutants.co
    }
    
    var _no2: Double {
        self.list[0].pollutants.no2
    }
    
    var _pm10:  Double{
        self.list[0].pollutants.pm10
    }
    
    var _pm25: Double {
        self.list[0].pollutants.pm25
    }
    
    var _o3:  Double {
        self.list[0].pollutants.o3
    }
    
    var _so2: Double {
        self.list[0].pollutants.so2
    }
    
    var _aqi :  (Int,String) {
        (self.list[0].main.aqi, "AQI")
    }
    
    var _date : Date {
        self.list[0].dt
    }
}








