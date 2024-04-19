//
//  PollutantCard.swift
//  Breezy
//
//  Created by Kein Li on 4/15/24.
//

import SwiftUI

struct PollutantCard: View {
    
    let aq : AirQuality
    
    let columns : [GridItem] = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    var body: some View {
            
        LazyVGrid(columns: columns, spacing: 20) {
            Section {
                PollutantSubCard(name: PollutantDescription.pm25.name.0, nameSub: PollutantDescription.pm25.name.1, value: aq._pm25, colorStr: aq.color)
                PollutantSubCard(name: PollutantDescription.pm10.name.0, nameSub: PollutantDescription.pm10.name.0, value: aq._pm10, colorStr: aq.color)
                PollutantSubCard(name: PollutantDescription.so2.name.0, nameSub: PollutantDescription.so2.name.1, value: aq._so2, colorStr: aq.color)
                PollutantSubCard(name: PollutantDescription.no2.name.0, nameSub: PollutantDescription.no2.name.1, value: aq._no2, colorStr: aq.color)
                PollutantSubCard(name: PollutantDescription.o3.name.0, nameSub: PollutantDescription.no2.name.1, value: aq._o3, colorStr: aq.color)
                PollutantSubCard(name: PollutantDescription.co.name.0, nameSub: PollutantDescription.co.name.1, value: aq._co, colorStr: aq.color)
            } header: {
                HeaderLine(title: "Pollutants")
            }
        }
        .padding()
    }
}

#Preview {
    PollutantCard(aq: AirQuality.mockAQ)
}
