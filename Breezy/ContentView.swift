//
//  ContentView.swift
//  Breezy
//
//  Created by Kein Li on 3/26/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var selectedTab : Tab = .house
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            HomeView()
                .tag(Tab.house)
            
            MapView()
                .tag(Tab.map)
            
            RankingView()
                .tag(Tab.chart)
        }
        .border(.blue)
        .overlay {
            CustomTabBar(selectedTab: $selectedTab)
        }
        
    }
}

#Preview {
    ContentView()
}




    
