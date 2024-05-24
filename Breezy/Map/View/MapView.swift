//
//  Map.swift
//  Breezy
//
//  Created by Kein Li on 5/7/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    
    @State var mapVM = MapViewModel(networkManager: NetworkManager(), locationManager: LocationManager.shared)
    
//    @State var mapVM = MockMapViewModel(networkManager: NetworkManager(), locationManager: LocationManager.shared)
    
    
    var body: some View {
        MapReader { reader in
            Map(position: $mapVM.cameraPosition) {
                ForEach(mapVM.markers, id:\.self) { marker in
                    Annotation("", coordinate: marker.coord) {
                        AQIMarkerView(mapVM: mapVM, marker: marker)
                    }
                }
            }
            .mapStyle(.standard)
            .sheet(isPresented: $mapVM.showSearchView) {
                MapSearchView(mapVM: mapVM)
            }
            .overlay(alignment: .topTrailing) {
               MapButtonsView(mapVM: mapVM)
            }
//            .overlay(mapVM.selectedMarker == nil ? nil : LocationContentView(content: mapVM.selectedMarker!))
            
            .sheet(item: $mapVM.selectedMarker) {
                mapVM.selectedMarker = nil
            } content: { marker in
                LocationContentView(content: marker)
            }
        }
        .task {
            await mapVM.initializeMarker()
        }
    }
}

#Preview {
    MapView()
}
//
//.sheet(item: $mapVM.selectedMarker) {
//    mapVM.selectedMarker = nil
//} content: { marker in
//    LocationContentView(content: marker)
//}
