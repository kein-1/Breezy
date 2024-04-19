//
//  HeaderLine.swift
//  Breezy
//
//  Created by Kein Li on 4/19/24.
//

import SwiftUI

struct HeaderLine: View {
    
    let title: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
                .frame(height: 1)
                .overlay(.black)
        }
    }
}
