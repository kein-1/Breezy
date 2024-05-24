//
//  ChartCard.swift
//  Breezy
//
//  Created by Kein Li on 5/2/24.
//

import SwiftUI
import Charts


struct ChartCard : View {
    
    let historyData : [PrimaryData]
    var body: some View {
        Chart {
            ForEach(historyData, id: \.self) { primaryData in
                CustomBarMarkView(primaryData: primaryData)
            }
        }
        .frame(minHeight: 300, maxHeight: .infinity)
        .chartScrollableAxes(.horizontal) // horizontal scrolling
        .chartXVisibleDomain(length: 7) // how many elements to show on x axis
        .chartYScale(domain: 0...5) // customize the range in the y axis
        .chartYAxis {
            AxisMarks(values: .automatic(desiredCount: 6))
        }
        .chartScrollPosition(initialX: 3)
    }
       
}
//
//#Preview {
//    @State var historyVM = MockHistoryDataViewModel(networkManager: NetworkManager(), locationManager: LocationManager.shared)
//    
//    return ChartCard(historyVM: historyVM)
//}


