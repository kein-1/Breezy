//
//  PollutantSubCard.swift
//  Breezy
//
//  Created by Kein Li on 4/15/24.
//

import SwiftUI

struct PollutantSubCard: View {
    
    let name: String
    let color: Color
    let value: Double
    
    var body: some View {
        HStack {
            Text(name)
            ProgressView(value: value)
                .tint(self.color)
                .scaleEffect(x:1, y:2, anchor: .center)
            Text(value, format: .number)
            
            
        }
        .padding()
    }
}

#Preview {
    PollutantSubCard(name: "PM2.5", color: Color.teal, value: 80)
}
