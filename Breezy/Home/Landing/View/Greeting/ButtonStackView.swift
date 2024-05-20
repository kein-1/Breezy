//
//  SwiftUIView.swift
//  Breezy
//
//  Created by Kein Li on 5/19/24.
//

import SwiftUI

struct ButtonStackView : View {
    
    @Environment (\.airQualityVM) var homeVM
    @State var showSheet = false
    
    var body: some View {
        VStack(spacing: 20) {
            Button {
                homeVM.showCurrentLocationData.toggle()
                Task {
                    await homeVM.retrieveLocationAndUpdateData()
                }
            } label: {
               CustomLabelView(title: "Get current location", sysImg: "location")
            }
            Button {
                // TODO:
                showSheet.toggle()
                
            } label: {
                CustomLabelView(title: "Search or enter address", sysImg: "magnifyingglass")
            }
        }
        .fixedSize(horizontal: true, vertical: false) // causes size to be as large as it needs (ideal size) to fit its contents. Ignores frame modifiers
        .sheet(isPresented: $showSheet) {
            SearchableView()
        }
    }
}
//
//#Preview {
//    ButtonStackView()
//}
