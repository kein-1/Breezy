//
//  Popover.swift
//  Breezy
//
//  Created by Kein Li on 4/19/24.
//

import SwiftUI

struct Popover: View {
    
    @Binding var showText: Bool
    var info : String
    
    var body: some View {
        Label("", systemImage: "questionmark.circle")
            .font(.system(size: 12))
            .offset(x:3, y:-9)
            .foregroundStyle(.gray)
            .popover(isPresented: $showText, attachmentAnchor: .point(.top)) {
                Text(info)
                    .font(.system(size: 11))
                    .padding()
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .presentationCompactAdaptation(.popover)
            }
    }
}

// Note : .popover is for ios 16.4+. We can achieve modal/sheet/fullscreen covers with this and .presentationCompactAdaptation, similar to how we used .sheet or .fullScreenCover. Seems to be the new way SwiftUI wants to go
