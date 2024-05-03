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
struct HistoricalCard<_ViewModel:ViewModel> : View {
    
    @Bindable var homeVM: _ViewModel
    var body: some View {
        VStack {
            Section {
                HStack (spacing: 5){
                    HistoricalButtonView(homeVM: homeVM, time: .week, title: "Week")
                    HistoricalButtonView(homeVM: homeVM, time: .month, title: "Month")
                    HistoricalButtonView(homeVM: homeVM, time: .year, title: "Year")
                }
                
                .padding()
                .frame(maxWidth: .infinity, alignment: .trailing)
            } header: {
                HeaderLine(title: "Past Air Quality")
            }
            Section {
                ChartCard(homeVM: homeVM)
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
