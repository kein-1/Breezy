//
//  DescriptionView.swift
//  Breezy
//
//  Created by Kein Li on 4/24/24.
//

import SwiftUI

struct DescriptionCard: View {
    let description : String
    var body: some View {
        Text(description)
            .font(.system(size: 14))
            .foregroundStyle(.gray)
            .padding(20)
    }
}

#Preview {
    DescriptionCard(description: AirQuality.mockAQ.description)
}
