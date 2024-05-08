//
//  HistoricalButtonView.swift
//  Breezy
//
//  Created by Kein Li on 5/2/24.
//

import SwiftUI

struct HistoricalButtonView<T: HistoricalDataProtocol> : View {
    
    @Bindable var historyVM : T
    let time: Historical
    let title: String
    
    var body: some View {
        Button {
            Task {
                withAnimation {
                    historyVM.currentHistory = time
                }
                await historyVM.retrieveHistoricalData()
            }
        } label: {
            Text(title)
                .foregroundStyle(historyVM.currentHistory == time ? .white : .black)
                .font(.system(size: 14))
                .padding()
                .background {
                    Capsule()
                        .fill(historyVM.currentHistory == time ? .mint : .clear)
                }
        }
    }
}
//
//#Preview {
//    HistoricalButtonView()
//}
