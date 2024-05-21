//
//  SearchView.swift
//  Breezy
//
//  Created by Kein Li on 5/20/24.
//

import SwiftUI
import MapKit

struct MapSearchView: View {
        
    @Environment (\.dismiss) var dismiss
    var body: some View {
        Button("press me ") {
            dismiss() // dismiss itself
        }
        .interactiveDismissDisabled()
        .presentationDetents([.height(150), .large])
        .presentationBackgroundInteraction(.enabled(upThrough: .large))
        .presentationBackground(.regularMaterial)
        .presentationCornerRadius(25)
    }
}
//
//#Preview {
//    MapSearchView()
//}
