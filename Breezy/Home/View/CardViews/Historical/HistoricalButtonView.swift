//
//  HistoricalButtonView.swift
//  Breezy
//
//  Created by Kein Li on 5/2/24.
//

import SwiftUI

struct HistoricalButtonView<_ViewModel:ViewModel> : View {
    
    @Bindable var homeVM: _ViewModel
    let time: Historical
    let title: String
    
    var body: some View {
        Button {
            Task {
                withAnimation {
                    homeVM.currentHistory = time
                }
                await homeVM.retrieveHistoricalData()
            }
        } label: {
            Text(title)
                .foregroundStyle(homeVM.currentHistory == time ? .white : .black)
                .font(.system(size: 14))
                .padding()
                .background {
                    Capsule()
                        .fill(homeVM.currentHistory == time ? .mint : .clear)
                }
        }
    }
}
//
//#Preview {
//    HistoricalButtonView()
//}
