//
//  PollutantCard.swift
//  Breezy
//
//  Created by Kein Li on 4/15/24.
//

import SwiftUI

struct PollutantCard: View {
    
    let aq : AirQuality
    
    var color: Color {
        switch aq.color {
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
    
    var body: some View {
        VStack {
            Text("\(aq._co)")
            Text("\(aq._no2)")
            Text("\(aq._pm10)")
            Text("\(aq._pm25)")
            Text("\(aq._o3)")
            Text("\(aq._so2)")
            Text("\(aq._aqi)")
        }
        .foregroundStyle(self.color)
    }
    
    
}

#Preview {
    PollutantCard(aq: AirQuality.mockAQ)
}
