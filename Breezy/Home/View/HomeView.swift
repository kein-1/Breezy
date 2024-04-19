//
//  HomeView.swift
//  Breezy
//
//  Created by Kein Li on 3/28/24.
//

import SwiftUI
import CoreLocation

struct HomeView : View {
    
    @State var homeVM = HomeViewModel(networkManager: NetworkManager(), locationManager: LocationManager.shared)
    
    
    var body: some View {
        ScrollView {
            LazyVStack {
                if homeVM.places.isEmpty {
                    VStack{
                        
                        Button("Get current location") {
                            Task {
                                await homeVM.retrieveLocationAndUpdateData()
                            }
                        }
                        if homeVM.currAQ != nil {
                            PollutantCard(aq: homeVM._currAQData)
                        } else {
                           Text("AQ Nil")
                        }
                    }
                } else {
                    
                }
            }
        }
        
        
    }
}


#Preview {
   HomeView()
}
