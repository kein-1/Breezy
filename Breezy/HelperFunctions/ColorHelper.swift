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
            case 1:
                color = Color.levelOneColor
            case 2:
                color = Color.levelTwoColor
            case 3:
                color = Color.levelThreeColor
            case 4:
                color = Color.levelFourColor
            default:
                color = Color.levelFiveColor
        }
        return color
    }
}
