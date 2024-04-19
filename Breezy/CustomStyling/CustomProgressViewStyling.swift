//
//  CustomProgressViewStyling.swift
//  Breezy
//
//  Created by Kein Li on 4/18/24.
//

import SwiftUI

struct MyProgressViewStyle: ProgressViewStyle {

  func makeBody(configuration: Configuration) -> some View {
      ProgressView(configuration)
          .frame(height: 8.0)
          .scaleEffect(x: 1, y: 2, anchor: .center)
          .clipShape(RoundedRectangle(cornerRadius: 6))
  }
}


extension ProgressViewStyle where Self == MyProgressViewStyle {
    static var myCustomStyle: MyProgressViewStyle { MyProgressViewStyle() }
}

//// Apple's reccommended syntax way via struct + extension:
///
//struct CrazyButtonStyle: ButtonStyle {
//    func makeBody(configuration: Configuration) -> some View {
//        configuration.label
//            .foregroundColor(.red)
//    }
//}
//
//extension ButtonStyle where Self == CrazyButtonStyle {
//    static var crazy: Self { Self() }
//}
