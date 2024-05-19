//
//  UserServiceKey.swift
//  Breezy
//
//  Created by Kein Li on 5/19/24.
//

import Foundation
import SwiftUI


// MARK: - Defining custom environment key
///Workaround for using @Observable and the new @Environment, which only accepts concrete, conforming types and not protocols
private struct LocateableKey: EnvironmentKey {
//    typealias Value = any Locateable - can be omitted since it is inferred
    static let defaultValue: any Locateable = MockAQViewModel(networkManager: NetworkManager(), locationManager: LocationManager.shared)
}



extension EnvironmentValues {
    var airQualityVM: any Locateable {
        get { self[LocateableKey.self] }
        set { self[LocateableKey.self] = newValue }
    }
}
