//
//  FocusFlowProApp.swift
//  FocusFlowPro
//
//  Created by Пащенко Иван on 04.02.2026.
//

import SwiftUI

@main
struct FocusFlowProApp: App {

    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            RootContainerView()
                .environmentObject(appState)
                .preferredColorScheme(appState.isDarkMode ? .dark : .light)
        }
    }
}
