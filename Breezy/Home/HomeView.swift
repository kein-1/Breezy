//
//  HomeView.swift
//  Breezy
//
//  Created by Kein Li on 3/28/24.
//

import SwiftUI
import CoreLocation

struct HomeView : View {
    
    
//    
//    @State var homeVM = AQViewModel(networkManager: NetworkManager(), locationManager: LocationManager.shared)
//        @State var historyVM = HistoryDataViewModel(networkManager: NetworkManager(), locationManager: LocationManager.shared)
    @State var homeVM = MockHomeViewModel(networkManager: NetworkManager(), locationManager:  LocationManager.shared)
    @State var historyVM = MockHistoryDataViewModel(networkManager: NetworkManager(), locationManager: LocationManager.shared)
    
    var body: some View {
        ScrollView {
            LazyVStack {
                if homeVM.currAQ == nil {
                    VStack{
                        Button("Get current location") {
                            Task {
                                await homeVM.retrieveLocationAndUpdateData()
                            }
                        }
                        
                    }
                } else {
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
}


#Preview {
   HomeView()
}
