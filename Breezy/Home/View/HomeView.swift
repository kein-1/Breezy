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
                if !homeViewModel.locationManager.userApprovedStatus {
                    Text("i am approved!")
                } else {
                    Button("Press me ") {
                        print(homeViewModel.locationManager.userApprovedStatus)
                        Task {
                            await homeViewModel.getData(lon:"40.712776", lat: "-74.005974")
                        }
                    }
                }
            }
        }
        
    }
}


#Preview {
   HomeView()
}
