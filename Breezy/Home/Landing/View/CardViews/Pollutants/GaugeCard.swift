//
//  GaugeView.swift
//  Breezy
//
//  Created by Kein Li on 4/24/24.
//

import SwiftUI

struct GaugeCard: View {
    
    let aq : AirQuality
    
    var body: some View {
        Gauge(
            value: Double(aq._aqi.0),
            in: 1...5,
            label: {
                
            },
            currentValueLabel: {
                VStack {
                    Text("AQI")
                    Text(aq._aqi.0, format: .number)
                }
                .font(.subheadline)
            }
        )
        .gaugeStyle(.accessoryCircularCapacity)
        .tint(ColorHelper.color(aqi: aq._aqi.0))
        .frame(minWidth: 150, minHeight: 150)
        .scaleEffect(2)
    }
}
//
//#Preview {
//    GaugeView(aq: AirQuality.mockAQ)
//}
