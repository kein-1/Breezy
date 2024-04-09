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
                                await homeViewModel.retrieveLocationAndUpdate()
                            }
                        }
                        if homeViewModel.currentLocationAQ != nil {
                            Text("not nil")
                            
                        } else {
                            Text("sometjhing else")
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
