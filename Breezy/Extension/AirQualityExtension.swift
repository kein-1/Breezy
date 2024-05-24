//
//  Coordinates.swift
//  Breezy
//
//  Created by Kein Li on 5/9/24.
//

import Foundation
import MapKit




// MARK: - Primary data extension
extension PrimaryData:  Hashable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(dt)
    }
    
    static func == (lhs: PrimaryData, rhs: PrimaryData) -> Bool {
        lhs.dt == rhs.dt
    }
}


// MARK: - AirQuality extensions



// MARK: - AirQuality extra properties
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
    
    var pollutantDetail : [PollutantDetail] {
        [
            PollutantDetail(pollutantDescription: .pm25, value: self._pm25, aqi: self._aqi.0),
            PollutantDetail(pollutantDescription: .pm10, value: self._pm10, aqi: self._aqi.0),
            PollutantDetail(pollutantDescription: .so2, value: self._so2, aqi: self._aqi.0),
            PollutantDetail(pollutantDescription: .no2, value: self._no2, aqi: self._aqi.0),
            PollutantDetail(pollutantDescription: .o3, value: self._o3, aqi: self._aqi.0),
            PollutantDetail(pollutantDescription: .co, value: self._co, aqi: self._aqi.0)
        ]
    }
}


// MARK: - AirQuality Hashable

extension AirQuality : Hashable {
    
    static func == (lhs: AirQuality, rhs: AirQuality) -> Bool {
        lhs.list == rhs.list
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(list)
    }
    
}



// MARK: - AirQuality mock data
extension AirQuality {
    static var mockAQ: Self =
        AirQuality(
            coord: Coord(lon: 40.73, lat: -73.93),
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
    
    static var mockPrimaryData: PrimaryData =
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
    
    static var mockHistoricalAQ : Self =
        AirQuality(
            coord: Coord(lon: -122.0089, lat: 37.3347),
            list: [
                PrimaryData(
                        dt: Date(timeIntervalSince1970: 1713752907),
                        main: AQI(aqi: 5),
                        pollutants: Pollutants(
                            co: 223.64,
                            no: 0.62,
                            no2: 2.63,
                            o3: 101.57,
                            so2: 1.01,
                            pm25: 0.92,
                            pm10: 2.05,
                            nh3: 0.22
                        )
                    ),
                PrimaryData(
                        dt: Date(timeIntervalSince1970: 1713839307),
                        main: AQI(aqi: 2),
                        pollutants: Pollutants(
                            co: 223.64,
                            no: 0.62,
                            no2: 2.63,
                            o3: 101.57,
                            so2: 1.01,
                            pm25: 0.92,
                            pm10: 2.05,
                            nh3: 0.22
                        )
                    ),
                PrimaryData(
                        dt: Date(timeIntervalSince1970: 1713925707),
                        main: AQI(aqi: 1),
                        pollutants: Pollutants(
                            co: 223.64,
                            no: 0.62,
                            no2: 2.63,
                            o3: 101.57,
                            so2: 1.01,
                            pm25: 0.92,
                            pm10: 2.05,
                            nh3: 0.22
                        )
                    ),
                PrimaryData(
                        dt: Date(timeIntervalSince1970: 1714012107),
                        main: AQI(aqi: 4),
                        pollutants: Pollutants(
                            co: 223.64,
                            no: 0.62,
                            no2: 2.63,
                            o3: 101.57,
                            so2: 1.01,
                            pm25: 0.92,
                            pm10: 2.05,
                            nh3: 0.22
                        )
                    ),
                    PrimaryData(
                        dt: Date(timeIntervalSince1970: 1714158260),
                        main: AQI(aqi: 3),
                        pollutants: Pollutants(
                            co: 223.64,
                            no: 0.61,
                            no2: 2.44,
                            o3: 101.57,
                            so2: 0.98,
                            pm25: 1.0,
                            pm10: 2.25,
                            nh3: 0.19
                        )
                    ),
                    PrimaryData(
                        dt: Date(timeIntervalSince1970: 1714244660),
                        main: AQI(aqi: 3),
                        pollutants: Pollutants(
                            co: 220.3,
                            no: 0.55,
                            no2: 2.31,
                            o3: 101.57,
                            so2: 0.94,
                            pm25: 1.05,
                            pm10: 2.38,
                            nh3: 0.16
                        )
                    ),
                    PrimaryData(
                        dt: Date(timeIntervalSince1970: 1714331060),
                        main: AQI(aqi: 2),
                        pollutants: Pollutants(
                            co: 220.3,
                            no: 0.52,
                            no2: 2.59,
                            o3: 98.71,
                            so2: 0.89,
                            pm25: 1.11,
                            pm10: 2.5,
                            nh3: 0.15
                        )
                    ),
                    PrimaryData(
                        dt: Date(timeIntervalSince1970: 1714417460),
                        main: AQI(aqi: 2),
                        pollutants: Pollutants(
                            co: 223.64,
                            no: 0.49,
                            no2: 3.34,
                            o3: 97.27,
                            so2: 0.86,
                            pm25: 1.15,
                            pm10: 2.49,
                            nh3: 0.16
                        )
                    ),
                    PrimaryData(
                        dt: Date(timeIntervalSince1970: 1714503860),
                        main: AQI(aqi: 3),
                        pollutants: Pollutants(
                            co: 223.64,
                            no: 0.62,
                            no2: 2.63,
                            o3: 101.57,
                            so2: 1.01,
                            pm25: 0.92,
                            pm10: 2.05,
                            nh3: 0.22
                        )
                    ),
                    PrimaryData(
                        dt: Date(timeIntervalSince1970: 1714590260),
                        main: AQI(aqi: 3),
                        pollutants: Pollutants(
                            co: 223.64,
                            no: 0.61,
                            no2: 2.44,
                            o3: 101.57,
                            so2: 0.98,
                            pm25: 1.0,
                            pm10: 2.25,
                            nh3: 0.19
                        )
                    )
            ]
        )

}





