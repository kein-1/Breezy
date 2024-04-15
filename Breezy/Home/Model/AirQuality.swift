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
    var color: String {
        switch self._aqi {
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
        switch self._aqi {
            case 1:
                "Good"
            case 2:
                "Fair"
            case 3:
                "Moderate"
            case 4:
                "Poor"
            default:
                "Very Poor"
            }
    }
}

struct PrimaryData: Codable {
    let dt: Date
    let main: AQI
    let pollutants: Pollutants
    
    enum CodingKeys: String, CodingKey {
        case dt, main
        case pollutants = "components"
    }
}

struct Coord: Codable {
    let lon: Double
    let lat: Double
}

struct AQI: Codable {
    let aqi: Int
}

struct Pollutants: Codable {
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
    
    var _co: (Double,String) {
        (self.list[0].pollutants.co, "co")
    }
    
    var _no2:  (Double,String) {
        (self.list[0].pollutants.no2,"no2")
    }
    
    var _pm10:  (Double,String) {
        (self.list[0].pollutants.pm10, "pm10")
    }
    
    var _pm25:  (Double,String) {
        (self.list[0].pollutants.pm25,"pm2.5")
    }
    
    var _o3:  (Double,String) {
        (self.list[0].pollutants.o3,"o3")
    }
    
    var _so2:  (Double,String) {
        (self.list[0].pollutants.so2, "so2")
    }
    
    var _aqi :  (Double,String) {
        (self.list[0].main.aqi, "AQI")
    }
}

// MARK: - Thresholds
extension AirQuality {
    var _coThreshold: (Double,Double) {
        switch self._aqi {
        case 1:
            (0,4400)
        case 2:
            (4400,9400)
        case 3:
            (9400,12400)
        case 4:
            (12400,15400)
        default:
            (15400,25000)
        }
    }
    
    var _no2Threshold: (Double, Double) {
        switch self._aqi {
        case 1:
            return (0, 40)
        case 2:
            return (40, 70)
        case 3:
            return (70, 150)
        case 4:
            return (150, 200)
        default:
            return (200, 300)
        }
    }
    
    var _pm10Threshold: (Double, Double) {
        switch self._aqi {
        case 1:
            return (0, 20)
        case 2:
            return (20, 50)
        case 3:
            return (50, 100)
        case 4:
            return (100, 200)
        default:
            return (200, 220)
        }
    }

    var _pm25Threshold: (Double, Double) {
        switch self._aqi {
        case 1:
            return (0, 20)
        case 2:
            return (20, 50)
        case 3:
            return (25, 50)
        case 4:
            return (50, 75)
        default:
            return (75, 85)
        }
    }
        
    var _o3Threshold: (Double, Double) {
        switch self._aqi {
        case 1:
            return (0, 10)
        case 2:
            return (10, 25)
        case 3:
            return (25, 50)
        case 4:
            return (140, 180)
        default:
            return (180, 200)
        }
    }
    
    var _so2Threshold: (Double, Double) {
        switch self._aqi {
        case 1:
            return (0, 60)
        case 2:
            return (60, 100)
        case 3:
            return (100, 140)
        case 4:
            return (140, 180)
        default:
            return (180, 200)
        }
    }
}


// MARK: - Mock Data
extension AirQuality {
    static var mockAQ: Self =
        AirQuality(
            coord: Coord(lon: 50.0, lat: 50.0),
            list: [
                PrimaryData(
                    dt: Date(),
                    main: AQI(aqi: 3),
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
}





//
//{
//  "coord":[
//    50,
//    50
//  ],
//  "list":[
//    {
//      "dt":1605182400,
//      "main":{
//        "aqi":1
//      },
//      "components":{
//        "co":201.94053649902344,
//        "no":0.01877197064459324,
//        "no2":0.7711350917816162,
//        "o3":68.66455078125,
//        "so2":0.6407499313354492,
//        "pm2_5":0.5,
//        "pm10":0.540438711643219,
//        "nh3":0.12369127571582794
//      }
//    }
//  ]
//}


