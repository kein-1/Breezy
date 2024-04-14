//
//  HomeView.swift
//  Breezy
//
//  Created by Kein Li on 3/28/24.
//

import SwiftUI
import CoreLocation

struct HomeView : View {
    
    @State var homeViewModel = HomeViewModel(networkManager: NetworkManager(), locationManager: LocationManager.shared)
    
    
    var body: some View {
        ScrollView {
            LazyVStack {
                if homeViewModel.places.isEmpty {
                    VStack{
                        
                        Button("Get current location") {
                            Task {
                                await homeViewModel.retrieveLocationAndUpdateData()
                            }
                        }
                        if homeViewModel.currentLocationAQ != nil {
                            Text(homeViewModel.currentLocationAQ?.1.name ?? "")
                            Text(homeViewModel.currentLocationAQ?.1.administrativeArea ?? "")
                            Text(homeViewModel.currentLocationAQ?.1.country ?? "")
                            Text(homeViewModel.currentLocationAQ?.1.locality ?? "")
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

//
//#Preview {
//   HomeView()
//}
