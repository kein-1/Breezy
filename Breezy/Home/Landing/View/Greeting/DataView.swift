//
//  DataView.swift
//  Breezy
//
//  Created by Kein Li on 5/14/24.
//

import SwiftUI

struct DataView : View {
    
    @Environment (\.airQualityVM) private var homeVM
    
    var body: some View {
        ScrollView {
            LazyVStack {
                PlaceCard(place: homeVM.currPlacemark, date: homeVM.currAirQuality._date)
                GaugeCard(aq: homeVM.currAirQuality)
                DescriptionCard(description: homeVM.currAirQuality.description)
                ActivitiesView(aq:homeVM.currAirQuality)
                PollutantCard(aq: homeVM.currAirQuality)
                HistoricalCard()
            }
        }
    }
}
