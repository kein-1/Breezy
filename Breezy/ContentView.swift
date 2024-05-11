//
//  ContentView.swift
//  Breezy
//
//  Created by Kein Li on 3/26/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var selectedTab : Tab = .house
    
    
    init() {
        // TabView creates some space that we don't need so use this
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        VStack {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tag(Tab.house)
                MapView()
                    .tag(Tab.map)
                RankingView()
                    .tag(Tab.chart)
            }
            Spacer()
            CustomTabBar(selectedTab: $selectedTab)
        }
        
    }
}

#Preview {
    ContentView()
}




    
