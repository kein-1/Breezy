//
//  SearchableButtonView.swift
//  Breezy
//
//  Created by Kein Li on 5/20/24.
//

import SwiftUI

struct MapButtonsView<T: MapViewProtocol> : View {
    
    @Bindable var mapVM : T
    
    var body: some View {
        
        VStack {
            Button {
                mapVM.selectedMarker = nil
                mapVM.showSearchView = true
            } label: {
                Image(systemName: "magnifyingglass.circle")
                    .resizable()
                    .scaledToFit()
            }
            .padding(10)
            
            Color.gray.frame(height: 0.5)
            
            Button {
                mapVM.selectedMarker = nil
                mapVM.resetToCurr()
            } label: {
                Image(systemName: "mappin.circle")
                    .resizable()
                    .scaledToFit()
            }
            .padding(10)
        }
        .frame(width: 45)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
        }
        .padding()
    }
}


