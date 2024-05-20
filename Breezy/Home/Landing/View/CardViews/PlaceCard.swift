//
//  PlaceCard.swift
//  Breezy
//
//  Created by Kein Li on 4/24/24.
//

import SwiftUI

struct PlaceCard: View {
    
    
    let aqPM: AirQualityPlacemark
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Label(aqPM.placemark.name ?? "", systemImage: "mappin.circle")
                .font(.system(size: 24))
            
            Group {
                if let locality = aqPM.placemark.locality {
                    Text(locality + ", " + (aqPM.placemark.administrativeArea ?? ""))
                } else {
                    Text((aqPM.placemark.administrativeArea ?? "") + ", " + (aqPM.placemark.country ?? ""))
                }
            }
            .font(.system(size: 16))
            
            Text(aqPM.aq._date.formatted(date: .abbreviated, time: .omitted))
                .foregroundStyle(.gray)
                .font(.system(size: 14))
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
