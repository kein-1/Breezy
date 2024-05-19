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
struct HistoricalCard : View {
    
    @Environment (\.historyVM) private var historyVM
    
    var body: some View {
        VStack {
            Section {
                HStack (spacing: 5){
                    ForEach(TimeFrame.allCases, id: \.rawValue) { time in
                        HistoricalButtonView(time: time, title: time.rawValue)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .trailing)
            } header: {
                HeaderLine(title: "Past Air Quality")
            }
            Section {
                ChartCard(historyData: historyVM.currHistoricalData)
            }
        }
        .padding()
        .task {
            await historyVM.retrieveHistoricalData()
        }
        
    }
}
//
//#Preview {
//    @State var historyVM = MockHistoryDataViewModel(networkManager: NetworkManager(), locationManager: LocationManager.shared)
//    
//    return HistoricalCard(historyVM: historyVM)
//}
//
//
//








// MARK: - Important Resources
// resource : https://stackoverflow.com/questions/59503399/how-to-define-a-protocol-as-a-type-for-a-observedobject-property
//
// https://tanaschita.com/20230807-migrating-to-observation/
