//
//  Map.swift
//  Breezy
//
//  Created by Kein Li on 5/7/24.
//

import SwiftUI
import MapKit
//
//struct MapViewOld: View {
//    
//    
//    @State var mapVM = MapViewModel(networkManager: NetworkManager(), locationManager: LocationManager.shared)
//    
//    var body: some View {
//        MapReader { reader in
//            Map(initialPosition: mapVM.retrievePosition()) {
//                ForEach(mapVM.markers, id:\.self) { marker in
//                    Annotation("", coordinate: marker.coord) {
//                        AQIMarkerView(marker: marker)
//                    }
//                }
//            }
//            .mapStyle(.standard)
//            
//            .onTapGesture(perform : { coord in
//                guard let point = reader.convert(coord, from: .local) else {
//                    return
//                }
//                Task {
//                    await mapVM.addCoordinate(coord: point)
//                }
//            })
//            
//        }
//    }
//    
//}
