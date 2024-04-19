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
            case .co: return ("CO","")
            case .no2: return ("NO", "2")
            case .pm10: return ("PM", "10")
            case .pm25: return ("PM", "2.5")
            case .o3: return ("O", "3")
            case .so2: return ("SO", "2")
        }
    }
}

//"Particulate Matter (2.5µm)"
