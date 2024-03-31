//
//  ContentView.swift
//  Breezy
//
//  Created by Kein Li on 3/26/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var tagVal = 0
    var body: some View {
        TabView {
            HomeView()
                .tag(0)
                .tabItem {
                    Label("Home", systemImage: "tray.and.arrow.down.fill")
                }
            
            Text("some other")
                .tag(1)
                .tabItem {
                    Label("Received", systemImage: "tray.and.arrow.down.fill")
                }
        }
    }
}

#Preview {
    ContentView()
}
