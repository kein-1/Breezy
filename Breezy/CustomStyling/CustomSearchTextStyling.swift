//
//  CustomTextFieldStyle.swift
//  Breezy
//
//  Created by Kein Li on 5/21/24.
//

import SwiftUI

struct CustomSearchTextStyling: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .fontDesign(.rounded)
    }
}

extension View {
    func customTextStyle() -> some View {
        modifier(CustomSearchTextStyling())
    }
}
