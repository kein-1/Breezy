//
//  SearchableButtonView.swift
//  Breezy
//
//  Created by Kein Li on 5/20/24.
//

import SwiftUI

struct SearchableButtonView<T: MapViewProtocol> : View {
    
    @Bindable var mapVM : T
    
    var body: some View {
        Button {
            mapVM.selectedMarker = nil
            mapVM.showSearchView = true
        } label: {
            Image(systemName: "magnifyingglass.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.white)
                }
        }
        .padding()
    }
}
