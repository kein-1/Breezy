//
//  ChartCard.swift
//  Breezy
//
//  Created by Kein Li on 5/2/24.
//

import SwiftUI
import Charts


struct ChartCard<_ViewModel: ViewModel> : View {
    
    @Bindable var homeVM: _ViewModel
    var body: some View {
        Chart(homeVM._currHistoricalData, id: \.self) { data in
            
            BarMark(
                x: .value("Date", data.dt.formatted(date: .numeric, time: .omitted)),
                y: .value("Pollutants", data.main.aqi)
            )
        }
        .chartScrollableAxes(.horizontal)
        .chartXVisibleDomain(length: 7)
    }
}

#Preview {
    @State var homeVM = MockHomeViewModel(networkManager: NetworkManager(), locationManager: LocationManager.shared)
    
    return ChartCard(homeVM: homeVM)
}
