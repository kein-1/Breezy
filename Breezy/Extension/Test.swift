//
//  Test.swift
//  Breezy
//
//  Created by Kein Li on 5/23/24.
//

import SwiftUI

struct Test: View {
    var body: some View {
        ScrollView {
            
            VStack {
                
                Text("1")
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .padding()
                    .background {
                        Capsule()
                            .fill(Color.levelOneColor)
                    }
                
                Text("2")
                    .foregroundStyle(.white)
                    .padding()
                    .background {
                        Capsule()
                            .fill(Color.levelTwoColor)
                    }
                
                Text("3")
                    .foregroundStyle(.white)
                    .padding()
                    .background {
                        Capsule()
                            .fill(Color.levelThreeColor)
                    }
                
                Text("4")
                    .foregroundStyle(.white)
                    .padding()
                    .background {
                        Capsule()
                            .fill(Color.levelFourColor)
                    }
                
                Text("5")
                    .foregroundStyle(.white)
                    .padding()
                    .background {
                        Capsule()
                            .fill(Color.levelFiveColor)
                    }
                
            }
        }
    }
}

#Preview {
    Test()
}
