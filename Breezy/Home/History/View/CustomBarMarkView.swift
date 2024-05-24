//
//  CustomBarMarkView.swift
//  Breezy
//
//  Created by Kein Li on 5/5/24.
//

import SwiftUI
import Charts

// MARK: - A custom bar view that conforms to ChartContent protocol with specific colors
struct CustomBarMarkView: ChartContent {
    
    let primaryData: PrimaryData
    
    var body : some ChartContent {
        BarMark(
            x: .value("Date", primaryData.dt.formatted(
                .dateTime // specify only to show day and month
                    .day(.twoDigits)
                    .month(.twoDigits))),
            y: .value("Pollutants", primaryData.main.aqi)
        )
        .foregroundStyle(ColorHelper.aqiColor(aqi: primaryData.main.aqi))
        .cornerRadius(10)
    }
}
//
//#Preview {
//    CustomBarMarkView()
//}
