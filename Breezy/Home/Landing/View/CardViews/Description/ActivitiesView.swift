//
//  ActivitiesView.swift
//  Breezy
//
//  Created by Kein Li on 4/24/24.
//

import SwiftUI

struct ActivitiesView: View {
    
    let aqPM: AirQualityPlacemark
    
    let activities = ["Outdoor sports", "Bring baby out", "Eating outside"]
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(activities, id: \.self) { activity in
                Text(activity)
                    .font(.caption2.bold())
                    .padding()
                    .foregroundStyle(.white)
                    .background {
                        Capsule()
                            .fill(ColorHelper.aqiColor(aqi: aqPM.aq._aqi.0))
                    }
            }
        }
        .padding()
    }
}
