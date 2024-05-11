//
//  SwiftUIView.swift
//  Breezy
//
//  Created by Kein Li on 5/4/24.
//

import SwiftUI
import CoreLocationUI


struct GreetingView<_ViewModel: Locateable>: View {
    @Bindable var homeVM : _ViewModel
    var body: some View {
        VStack {
            Text("Breezy")
            Image("Weather")
                .interpolation(.none)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
            Text("Where are you located? To get an accurate reading of your air quality, we recommend entering your exact location")
            
            Button("press me"){
                Task {
                    await homeVM.retrieveLocationAndUpdateData()
                }
            }
        }
        .padding()
    }
}

#Preview {
    @State var homeVM = MockAQViewModel(networkManager: NetworkManager(), locationManager: LocationManager.shared)
    return GreetingView(homeVM: homeVM)
}
