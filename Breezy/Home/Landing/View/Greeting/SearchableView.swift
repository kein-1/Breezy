//
//  SearchableView.swift
//  Breezy
//
//  Created by Kein Li on 5/19/24.
//

import SwiftUI

struct SearchableView: View {
    
    
    @Environment (\.dismiss) var dismiss
    @Environment (\.airQualityVM) var homeVM
    @Environment (\.historyVM) var historyVM
    
    var body: some View {
        Button("press me ") {
            dismiss() // dismiss itself
        }
    }
}
//
//#Preview {
//    SearchableView()
//}
