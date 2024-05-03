//
//  PlaceCard.swift
//  Breezy
//
//  Created by Kein Li on 4/24/24.
//

import SwiftUI

struct PlaceCard: View {
    let place : Placemark
    let date: Date
    var body: some View {
        VStack(alignment: .leading) {
            
            Label(place.name ?? "", systemImage: "mappin.circle")
                .font(.system(size: 24))
            
            Group {
                if let locality = place.locality {
                    Text(locality + ", " + (place.administrativeArea ?? ""))
                } else {
                    Text((place.administrativeArea ?? "") + ", " + (place.country ?? ""))
                }
            }
            .font(.system(size: 16))
            
            Text(date.formatted(date: .abbreviated, time: .omitted))
                .foregroundStyle(.gray)
                .font(.system(size: 14))
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
