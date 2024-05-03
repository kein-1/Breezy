//
//  HistoricalCard.swift
//  Breezy
//
//  Created by Kein Li on 4/25/24.
//

import SwiftUI


/// Generics for a protocol binding
/// Cannot apply PropertyWrappers to protocols and extensions
///
struct HistoricalCard<_ViewModel: HistoricalDataProtocol> : View {
    
    @Bindable var historyVM : _ViewModel
    var body: some View {
        VStack {
            Section {
                HStack (spacing: 5){
                    HistoricalButtonView(historyVM: historyVM, time: .week, title: "Week")
                    HistoricalButtonView(historyVM: historyVM, time: .month, title: "Month")
                    HistoricalButtonView(historyVM: historyVM, time: .year, title: "Year")
                }
                
                .padding()
                .frame(maxWidth: .infinity, alignment: .trailing)
            } header: {
                HeaderLine(title: "Past Air Quality")
            }
            Section {
                ChartCard(historyVM: historyVM)
            }
        }
        .padding()
        .frame(minHeight: 400, maxHeight: .infinity)
    }
}

#Preview {
    @State var homeVM = MockHomeViewModel(networkManager: NetworkManager(), locationManager: LocationManager.shared)
    
    return HistoricalCard(homeVM: homeVM)
}











// MARK: - Important Resources
// resource : https://stackoverflow.com/questions/59503399/how-to-define-a-protocol-as-a-type-for-a-observedobject-property
//
// https://tanaschita.com/20230807-migrating-to-observation/
