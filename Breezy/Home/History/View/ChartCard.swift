//
//  ChartCard.swift
//  Breezy
//
//  Created by Kein Li on 5/2/24.
//

import SwiftUI
import Charts


struct ChartCard<_ViewModel: HistoryDataViewModel> : View {
    
    @Bindable var historyVM: _ViewModel
    var body: some View {
        Chart(historyVM._currHistoricalData, id: \.self) { data in
            
            BarMark(
                x: .value("Date", data.dt.formatted(date: .numeric, time: .omitted)),
                y: .value("Pollutants", data.main.aqi)
            )
        }
        .chartScrollableAxes(.horizontal)
        .chartXVisibleDomain(length: 7)
    }
}

//#Preview {
//    @State var historyVM = MockHomeViewModel(networkManager: NetworkManager(), locationManager: LocationManager.shared)
//    
//    return ChartCard(historyVM: historyVM)
//}
