//
//  LocationContent.swift
//  Breezy
//
//  Created by Kein Li on 5/18/24.
//

import SwiftUI

struct LocationContent: View {
    
    
    let content : CustomMarkerModel
    
    var body: some View {
        
        HStack {
            Text(content.aq._aqi.0, format: .number)
            Group {
                if let locality = content.placeMark.locality {
                    Text(locality + ", " + (content.placeMark.administrativeArea ?? ""))
                } else {
                    Text((content.placeMark.administrativeArea ?? "") + ", " + (content.placeMark.country ?? ""))
                }
            }
            .font(.system(size: 16))
        }
        
    }
}

#Preview {
    LocationContent(content: .mockData)
}
