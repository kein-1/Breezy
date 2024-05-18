//
//  AQIMarkerView.swift
//  Breezy
//
//  Created by Kein Li on 5/11/24.
//

import SwiftUI

struct AQIMarkerView<T: MapViewProtocol>: View {
    
    @Bindable var mapVM : T
    let marker : CustomMarkerModel
    
    
    var body: some View {
        VStack {
            Text(marker.aq._aqi.0, format: .number)
                .foregroundStyle(.white)
                .font(.system(size: 22).bold())
                .padding()
                .background {
                    Circle()
                        .fill(ColorHelper.color(aqi: marker.aq._aqi.0))
                }
                .onTapGesture {
                    mapVM.selectedMarker = marker
                }
        }
        
    }
}
//
//#Preview {
//    AQIMarkerView(marker: CustomMarkerModel.mockData)
//}
