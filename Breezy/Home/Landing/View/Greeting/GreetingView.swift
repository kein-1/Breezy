//
//  SwiftUIView.swift
//  Breezy
//
//  Created by Kein Li on 5/4/24.
//

import SwiftUI
import CoreLocationUI


struct GreetingView : View {
    
    var body: some View {
        VStack {
            Spacer()
            Text("Breezy")
                .font(.title.bold())
                .foregroundStyle(.gray)
            Image("Weather")
                .interpolation(.none)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
            
            VStack(spacing:20) {
                Text("WHERE ARE YOU LOCATED?")
                    .font(.system(size: 20).bold())
                    .opacity(0.6)
                Text("To get an accurate reading of your air quality, we recommend entering your exact location")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.teal)
                    .font(.system(size: 16))
            }
            .frame(height: 150)
            .padding([.leading,.trailing])
            
            ButtonStackView()
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}

#Preview {
    return GreetingView()
}
