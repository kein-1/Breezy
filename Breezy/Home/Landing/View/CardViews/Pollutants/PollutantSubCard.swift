//
//  PollutantSubCard.swift
//  Breezy
//
//  Created by Kein Li on 4/15/24.
//

import SwiftUI

struct PollutantSubCard: View {
    
    let pollutantDetail : PollutantDetail
        
    @State var showText = false
    
    var body: some View {
        HStack {
            HStack {
                Text(pollutantDetail.pollutantDescription.name.0)
                    .font(.system(size: 14))
                Text(pollutantDetail.pollutantDescription.name.1).font(.system(size: 12))
                    .offset(x:-7, y:5)
                    .overlay {
                        Popover(showText: $showText, info: pollutantDetail.pollutantDescription.summary)
                    }
                    .onTapGesture {
                        showText.toggle()
                    }
            }
            .frame(minWidth: 50, maxWidth: .infinity)
            
            ProgressView(value: pollutantDetail.value, total: pollutantDetail.value + 1)
                .tint(ColorHelper.pollutantColor(colorString: pollutantDetail.colorStr))
                .progressViewStyle(.myCustomStyle)
                .frame(minWidth: 0, maxWidth: .infinity)
                      
            Text(String(format: "%.0f", pollutantDetail.value))
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
