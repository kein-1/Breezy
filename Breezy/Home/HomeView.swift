//
//  HomeView.swift
//  Breezy
//
//  Created by Kein Li on 3/28/24.
//

import SwiftUI
import CoreLocation

struct HomeView : View {
    
//    @State var homeVM = AQViewModel(networkManager: NetworkManager(), locationManager: LocationManager.shared)
//    @State var historyVM = HistoryDataViewModel(networkManager: NetworkManager(), locationManager: LocationManager.shared)
    @State var showData = false
    @State var homeVM = MockAQViewModel(networkManager: NetworkManager(), locationManager:  LocationManager.shared)
    @State var historyVM = MockHistoryDataViewModel(networkManager: NetworkManager(), locationManager: LocationManager.shared)
    
    var body: some View {
        NavigationStack{
            VStack {
                GreetingView(homeVM: homeVM, showData: $showData)
            }
            .navigationDestination(isPresented: $showData) {
                DataView(homeVM: homeVM, historyVM: historyVM)
            }
        }
    }
}

//
//#Preview {
//   HomeView()
//}
