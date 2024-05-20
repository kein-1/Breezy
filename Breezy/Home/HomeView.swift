//
//  HomeView.swift
//  Breezy
//
//  Created by Kein Li on 3/28/24.
//

import SwiftUI
import CoreLocation

struct HomeView : View {
    
    @State var homeVM = AQViewModel(networkManager: NetworkManager(), locationManager: LocationManager.shared)
    @State var historyVM = HistoryDataViewModel(networkManager: NetworkManager(), locationManager: LocationManager.shared)
    
//    @State var homeVM = MockAQViewModel(networkManager: NetworkManager(), locationManager:  LocationManager.shared)
//    @State var historyVM = MockHistoryDataViewModel(networkManager: NetworkManager(), locationManager: LocationManager.shared)
    
    var body: some View {
        NavigationStack{
            VStack {
                GreetingView()
                    .environment(\.airQualityVM, homeVM)
            }
            .navigationDestination(item: $homeVM.currAirQualityPlacemark) { airQuality in
                ScrollView {
                    LazyVStack {
                        PlaceCard(aqPM: airQuality)
                        GaugeCard(aqPM: airQuality)
                        DescriptionCard(description: airQuality.aq.description)
                        ActivitiesView(aqPM: airQuality)
                        PollutantCard(aqPM: airQuality)
                        HistoricalCard()
                    }
                }
                .environment(\.airQualityVM, homeVM)
                .environment(\.historyVM, historyVM)
            }
            .navigationDestination(item: $homeVM.searchedAQ) { data in
                Text(data.aq.description)
            }
        }
    }
}


#Preview {
   HomeView()
}
