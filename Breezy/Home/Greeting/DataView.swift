//
//  DataView.swift
//  Breezy
//
//  Created by Kein Li on 5/14/24.
//

import SwiftUI

struct DataView<L: Locateable, T: HistoricalDataProtocol> : View {
    
    @Bindable var homeVM: L
    @Bindable var historyVM: T
    
    var body: some View {
        ScrollView {
            LazyVStack {
                PlaceCard(place: homeVM._currPlaceData, date: homeVM._currAQData._date)
                GaugeCard(aq: homeVM._currAQData)
                DescriptionCard(description: homeVM._currAQData.description)
                ActivitiesView(aq: homeVM._currAQData)
                PollutantCard(aq: homeVM._currAQData)
                HistoricalCard(historyVM: historyVM)
            }
        }
    }
}
