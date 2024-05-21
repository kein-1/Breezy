//
//  SearchableView.swift
//  Breezy
//
//  Created by Kein Li on 5/19/24.
//

import SwiftUI
import MapKit

struct SearchableView: View {
    
    
    @Environment (\.dismiss) var dismiss
    @Environment (\.airQualityVM) var homeVM
    @Environment (\.historyVM) var historyVM
    
    let searchRequest = MKLocalSearch.Request()
    
    
    var body: some View {
        Button("press me ") {
            dismiss() // dismiss itself
            homeVM.currAirQualityPlacemark = AirQualityPlacemark(aq: .mockAQ, placemark: .mockPlacemark)
        }
    }
}
//
//#Preview {
//    SearchableView()
//}
