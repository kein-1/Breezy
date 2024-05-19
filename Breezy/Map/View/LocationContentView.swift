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
            .font(.system(size: 16))
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 15)
                .stroke(.red, lineWidth: 3)
        }
    }
}

#Preview {
    LocationContentView(content: .mockData)
}
