//
//  ColorHelper.swift
//  Breezy
//
//  Created by Kein Li on 5/11/24.
//

import SwiftUI

class ColorHelper {
    
    static func color(aqi: Int) -> Color  {
        
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
}
