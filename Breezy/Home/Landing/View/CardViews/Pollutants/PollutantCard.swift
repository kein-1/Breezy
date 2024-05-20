//
//  PollutantCard.swift
//  Breezy
//
//  Created by Kein Li on 4/15/24.
//

import SwiftUI

struct PollutantCard: View {
    
    let aqPM : AirQualityPlacemark
    
    let columns : [GridItem] = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    var body: some View {
            
        LazyVGrid(columns: columns, spacing: 20) {
            Section {
                ForEach(aqPM.aq.pollutantDetail, id: \.self) { pollutantDetail in
                    PollutantSubCard(pollutantDetail: pollutantDetail)
                }
//                PollutantSubCard(pollutant: PollutantDescription.pm25, value: aqPM._pm25, colorStr: aq.color)
//                PollutantSubCard(pollutant: PollutantDescription.pm10, value: aq._pm10, colorStr: aq.color)
//                PollutantSubCard(pollutant: PollutantDescription.so2, value: aq._so2, colorStr: aq.color)
//                PollutantSubCard(pollutant: PollutantDescription.no2, value: aq._no2, colorStr: aq.color)
//                PollutantSubCard(pollutant: PollutantDescription.o3, value: aq._o3, colorStr: aq.color)
//                PollutantSubCard(pollutant: PollutantDescription.co, value: aq._co, colorStr: aq.color)
            } header: {
                HeaderLine(title: "Pollutants")
            }
        }
        .padding()
    }
}
