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
            } header: {
                HeaderLine(title: "Pollutants")
            }
        }
        .padding()
    }
}
