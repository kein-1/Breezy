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
        HStack(spacing: 20) {
            ForEach(Tab.allCases, id: \.self) { tab in
                Image(systemName: tab.rawValue)
                    .font(.system(size: 16))
                    .scaleEffect(selectedTab == tab ? 1.25 : 1)
                    .onTapGesture {
                        withAnimation {
                            selectedTab = tab
                        }
                    }
                    .padding()
                    .background {
                        Circle()
                            .foregroundStyle(selectedTab == tab ? .teal.opacity(0.6) : .clear)
                    }
                    
            }
        }
        .background {
            Capsule()
                .fill(.ultraThickMaterial)
        }
    }
}

#Preview {
    CustomTabBar(selectedTab: .constant(.house))
}
