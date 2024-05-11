//
//  AQIMarkerView.swift
//  Breezy
//
//  Created by Kein Li on 5/11/24.
//

import SwiftUI

struct AQIMarkerView: View {
    
    let marker : CustomMarkerModel
    var body: some View {
        
        Text(marker.aq._aqi.0, format: .number)
            .foregroundStyle(.primary)
            .padding()
            .background {
                Circle()
                    .strokeBorder(ColorHelper.color(aqi: marker.aq._aqi.0), lineWidth: 5)
            }
    }
}

#Preview {
    AQIMarkerView(marker: CustomMarkerModel.mockData)
}
