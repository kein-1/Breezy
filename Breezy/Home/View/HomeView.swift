//
//  HomeView.swift
//  Breezy
//
//  Created by Kein Li on 3/28/24.
//

import SwiftUI
import CoreLocation

struct HomeView : View {
    
    @State var homeViewModel = HomeViewModel(networkManager: NetworkManager(), locationManager: LocationManager())
    
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
                            Text("i am good!!!")
                            
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
