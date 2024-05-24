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
    
    @State private var isChanged = false
    
    var body: some View {
        VStack {
            Text(marker.aq._aqi.0, format: .number)
                .foregroundStyle(.white)
                .font(.system(size: 22).bold())
                .padding()
                .background {
                    Circle()
                        .fill(ColorHelper.aqiColor(aqi: marker.aq._aqi.0))
                        
                }
                .onTapGesture {
                    mapVM.selectedMarker = marker
                    isChanged.toggle()
                }
                .phaseAnimator([false, true,false,true,false], trigger: isChanged) { content, phase in
                    content.offset(y: phase ? -40.0 : 0.0)
                }
        }
    }
}
//
//#Preview {
//    AQIMarkerView(marker: CustomMarkerModel.mockData)
//}

//
//    .popover(item: $mapVM.selectedMarker) { marker in // bind sheet to show based on selected value
//        LocationContentView(content: marker)
//        
//    }
