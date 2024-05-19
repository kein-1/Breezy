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





