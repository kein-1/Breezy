//
//  HistoricalButtonView.swift
//  Breezy
//
//  Created by Kein Li on 5/2/24.
//

import SwiftUI

struct HistoricalButtonView : View {
    
    @Environment (\.historyVM) private var historyVM
    let time : TimeFrame
    let title : String
    
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
                        .fill(historyVM.currentHistory == time ? .teal.opacity(0.6) : .clear)
                }
        }
    }
}

// Old view with binding and generics :
//struct HistoricalButtonView<T: HistoricalDataProtocol> : View {
//    
//    @Bindable var historyVM : T
//    let time: Historical
//    let title: String
//    
//    var body: some View {
//        Button {
//            Task {
//                withAnimation {
//                    historyVM.currentHistory = time
//                }
//                await historyVM.retrieveHistoricalData()
//            }
//        } label: {
//            Text(title)
//                .foregroundStyle(historyVM.currentHistory == time ? .white : .black)
//                .font(.system(size: 14))
//                .padding()
//                .background {
//                    Capsule()
//                        .fill(historyVM.currentHistory == time ? .teal.opacity(0.6) : .clear)
//                }
//        }
//    }
//}
//
//#Preview {
//    HistoricalButtonView()
//}
