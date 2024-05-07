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
    var color: Color {
        switch primaryData.main.aqi {
            case 1,2:
                Color.green
            case 3:
                Color.orange
            case 4:
                Color.purple
            default:
                Color.red
        }
    }
    
    var body : some ChartContent {
        BarMark(
            x: .value("Date", primaryData.dt.formatted(
                .dateTime // specify only to show day and month
                    .day(.twoDigits)
                    .month(.twoDigits))),
            y: .value("Pollutants", primaryData.main.aqi)
        )
        .foregroundStyle(color.gradient.opacity(0.7))
        .cornerRadius(10)
    }
}
//
//#Preview {
//    CustomBarMarkView()
//}
