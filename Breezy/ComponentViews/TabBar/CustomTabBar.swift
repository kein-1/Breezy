//
//  CustomTabBar.swift
//  Breezy
//
//  Created by Kein Li on 5/7/24.
//

import SwiftUI

struct CustomTabBar: View {
    
    @Binding var selectedTab : Tab
    
    var body: some View {
        HStack {
            ForEach(Tab.allCases, id: \.self) { tab in
                Spacer()
                Image(systemName: tab.rawValue)
                    .scaleEffect(selectedTab == tab ? 1.25 : 1)
                    .onTapGesture {
                        withAnimation {
                            selectedTab = tab
                        }
                    }
                    .padding()
                    .background {
                        Circle()
                            .foregroundStyle(selectedTab == tab ? .blue : .clear)
                    }
                Spacer()
            }
        }
        
        .frame(maxWidth: .infinity)
        .padding()
        .background {
            Capsule()
                .fill(.thinMaterial)
        }
        .padding()
    }
}
//
//#Preview {
//    CustomTabBar(selectedTab: .constant(.house))
//}
