//
//  Popover.swift
//  Breezy
//
//  Created by Kein Li on 4/19/24.
//

import SwiftUI

struct Popover: View {
    
    @Binding var showText: Bool
    
    var body: some View {
        Label("", systemImage: "questionmark.circle")
            .font(.system(size: 12))
            .offset(x:3, y:-9)
            .popover(isPresented: $showText) {
                Text("hello")
                    .font(.system(size: 12))
                    .presentationCompactAdaptation(.popover)
            }
    }
}
