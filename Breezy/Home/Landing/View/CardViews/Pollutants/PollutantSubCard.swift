//
//  PollutantSubCard.swift
//  Breezy
//
//  Created by Kein Li on 4/15/24.
//

import SwiftUI

struct PollutantSubCard: View {
    
    let pollutant: PollutantDescription
    let value: Double
    var colorStr : String
    
    var color: Color {
        switch colorStr {
            case "Green":
                Color.green
            case "Teal":
                Color.teal
            case "Orange":
                Color.orange
            case "Purple":
                Color.purple
            default:
                Color.red
        }
    }
    
    @State var showText = false
    
    var body: some View {
        HStack {
            HStack {
                Text(pollutant.name.0)
                    .font(.system(size: 14))
                Text(pollutant.name.1).font(.system(size: 12))
                    .offset(x:-7, y:5)
                    .overlay {
                        Popover(showText: $showText, info: pollutant.description)
                    }
                    .onTapGesture {
                        showText.toggle()
                    }
            }
            .frame(minWidth: 50, maxWidth: .infinity)
            
            ProgressView(value: value)
                .tint(self.color)
                .progressViewStyle(.myCustomStyle)
                .frame(minWidth: 0, maxWidth: .infinity)
            Text(String(format: "%.0f", value))
                .frame(minWidth: 40, maxWidth: .infinity)
                .font(.system(size: 14))
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .strokeBorder(.black, lineWidth: 1)
        }
    }
}

#Preview {
    PollutantSubCard(pollutant: PollutantDescription.pm25, value: 200, colorStr: "Green")
}
