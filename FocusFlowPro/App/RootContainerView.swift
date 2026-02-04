//
//  RootContainerView.swift
//  FocusFlowPro
//
//  Created by Пащенко Иван on 04.02.2026.
//


import SwiftUI

struct RootContainerView: View {

    @State private var showMainApp = false

    var body: some View {
        ZStack {
            if showMainApp {
                MainTabView()
            } else {
                LaunchView(showMainApp: $showMainApp)
            }
        }
    }
}
