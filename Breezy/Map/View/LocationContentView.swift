//
//  LocationContent.swift
//  Breezy
//
//  Created by Kein Li on 5/18/24.
//

import SwiftUI

struct LocationContentView: View {
    
    
    let content : CustomMarkerModel
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Label("AQI: \(content.aq._aqi.0)", systemImage: "aqi.low")
            
            Group {
                HStack {
                    Image(systemName: "location")
                    if let locality = content.placeMark.locality {
                        Text(locality + ", " + (content.placeMark.administrativeArea ?? ""))
                    } else {
                        Text((content.placeMark.administrativeArea ?? "") + ", " + (content.placeMark.country ?? ""))
                    }
                }
            }
            .font(.system(size: 16).bold())
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 15)
                .strokeBorder(ColorHelper.aqiColor(aqi: content.aq._aqi.0).opacity(0.7), lineWidth: 5)
        }
        .presentationCompactAdaptation(.popover)
        .presentationBackgroundInteraction(.enabled)
    }
    
}
//
//#Preview {
//    LocationContentView(content: .mockData)
//}
