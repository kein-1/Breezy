//
//  PollutantDescription.swift
//  Breezy
//
//  Created by Kein Li on 4/19/24.
//

import Foundation


enum PollutantDescription{
    case pm25
    case pm10
    case so2
    case no2
    case o3
    case co
    
    var name: (String,String) {
        switch self {
            case .pm25: return ("PM", "2.5")
            case .pm10: return ("PM", "10")
            case .so2: return ("SO", "2")
            case .no2: return ("NO", "2")
            case .o3: return ("O", "3")
            case .co: return ("CO","")
        }
    }
    
    var description: String {
        switch self {
            case .pm25:
                return "PM2.5: Particulate Matter with a diameter of 2.5 micrometers or less. PM2.5 can penetrate deep into the lungs and even enter the bloodstream, posing health risks such as respiratory and cardiovascular issues"
            case .pm10:
                return "PM10: Particulate Matter with a diameter of 10 micrometers or less. PM10 includes larger particles that can irritate the eyes, nose, and throat, and may also exacerbate respiratory conditions"
            case .so2:
                return "SO2: Sulfur Dioxide. SO2 is a gas produced by burning fossil fuels containing sulfur, such as coal and oil. It can cause respiratory problems, especially in individuals with asthma, and contribute to the formation of acid rain"
            case .no2:
                return "NO2: Nitrogen Dioxide. NO2 is a gas emitted from vehicle exhausts, power plants, and industrial facilities. Prolonged exposure to NO2 can aggravate respiratory conditions, lead to lung inflammation, and increase the risk of respiratory infections"
            case .o3:
                return "O3: Ozone. Ground-level ozone is formed when pollutants react with sunlight. High concentrations of ozone can irritate the respiratory system, trigger asthma attacks, and cause lung inflammation"
            case .co:
                return "CO: Carbon Monoxide. CO is a colorless, odorless gas produced by incomplete combustion of carbon-containing fuels. Inhalation of CO can lead to headaches, dizziness, and nausea, and at high levels, it can be life-threatening"
        }
    }
}

//"Particulate Matter (2.5µm)"
