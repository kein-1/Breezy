//
//  ColorHelper.swift
//  Breezy
//
//  Created by Kein Li on 5/11/24.
//

import SwiftUI

class ColorHelper {
    
    static func aqiColor(aqi: Int) -> Color  {
        
        var color : Color
        
        switch aqi {
            case 1,2:
                color = Color.green
            case 3:
                color = Color.orange
            case 4:
                color = Color.purple
            default:
                color = Color.red
        }
        return color
    }
    
    static func pollutantColor(colorString: String) -> Color {
        switch colorString {
            case "Green":
                Color.green
            case "Teal":
                Color.teal
            case "Orange":
                Color.orange
            case "Purple":
                Color.purple
            default:
                Color.red
        }
    }
    
}
