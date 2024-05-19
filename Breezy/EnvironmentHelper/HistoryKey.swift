//
//  HistoryKey.swift
//  Breezy
//
//  Created by Kein Li on 5/19/24.
//

import Foundation
import SwiftUI


// MARK: - Defining custom environment key
///Workaround for using @Observable and the new @Environment, which only accepts concrete, conforming types and not protocols
private struct HistoricalKey: EnvironmentKey {
    static let defaultValue: any HistoricalDataProtocol = MockHistoryDataViewModel(networkManager: NetworkManager(), locationManager: LocationManager.shared)
}


extension EnvironmentValues {
    var historyVM: any HistoricalDataProtocol {
        get { self[HistoricalKey.self] }
        set { self[HistoricalKey.self] = newValue }
    }
}
