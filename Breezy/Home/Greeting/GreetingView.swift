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
    @Binding var showData : Bool
    
    var body: some View {
        VStack {
            Spacer()
            Text("Breezy")
                .font(.title.bold())
                .foregroundStyle(.gray)
            Image("Weather")
                .interpolation(.none)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
            
            VStack(spacing:20) {
                Text("WHERE ARE YOU LOCATED?")
                    .font(.system(size: 20).bold())
                    .opacity(0.6)
                Text("To get an accurate reading of your air quality, we recommend entering your exact location")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.teal)
                    .font(.system(size: 16))
            }
            .frame(height: 150)
            .padding([.leading,.trailing])
            
            VStack(spacing: 20) {
                Button {
                    showData.toggle()
                    Task {
                        await homeVM.retrieveLocationAndUpdateData()
                    }
                } label: {
                   CustomLabelView(title: "Get current location", sysImg: "location")
                }
                Button {
                    // TODO:
                } label: {
                    CustomLabelView(title: "Search or enter address", sysImg: "magnifyingglass")
                }
            }
            .fixedSize(horizontal: true, vertical: false) // causes size to be as large as it needs (ideal size) to fit its contents. Ignores frame modifiers
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}
//
//#Preview {
//    @State var homeVM = MockAQViewModel(networkManager: NetworkManager(), locationManager: LocationManager.shared)
//    return GreetingView(homeVM: homeVM, showData: .constant(false))
//}
