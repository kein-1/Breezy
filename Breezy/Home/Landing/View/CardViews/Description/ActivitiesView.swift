//
//  ActivitiesView.swift
//  Breezy
//
//  Created by Kein Li on 4/24/24.
//

import SwiftUI

struct ActivitiesView: View {
    
    let aq: AirQuality
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
                            .fill(color)
                    }
            }
        }
        .padding()
    }
}

#Preview {
    ActivitiesView(aq: AirQuality.mockAQ)
}
