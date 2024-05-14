//
//  CustomLabelView.swift
//  Breezy
//
//  Created by Kein Li on 5/14/24.
//

import SwiftUI

struct CustomLabelView: View {
    let title : String
    let sysImg : String
    
    var body: some View {
        Label(title, systemImage: sysImg)
            .font(.system(size: 14).bold())
            .textCase(.uppercase)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity) // take up as much width as possible
            .padding()
            .background(.teal.opacity(0.6))
            .clipShape(.capsule)
    }
}
