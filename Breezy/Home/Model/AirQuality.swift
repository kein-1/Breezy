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
                        co: 4500,
                        no: 0.01877197064459324,
                        no2: 40,
                        o3: 68.66455078125,
                        so2: 90,
                        pm25: 15,
                        pm10:35,
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


