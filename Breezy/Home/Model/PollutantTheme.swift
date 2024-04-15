//
//  PollutantRating.swift
//  Breezy
//
//  Created by Kein Li on 4/15/24.
//

import Foundation
import SwiftUI

enum PollutantTheme: Codable {
    
    case one
    case two
    case three
    case four
    case five
    
    var color: Color {
        switch self {
        case .one:
            Color.green
        case .two:
            Color.teal
        case .three:
            Color.orange
        case .four:
            Color.purple
        case .five:
            Color.red
        }
    }
    
}
