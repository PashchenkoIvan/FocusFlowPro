//
//  MainTabView.swift
//  FocusFlowPro
//
//  Created by Пащенко Иван on 04.02.2026.
//


import SwiftUI

struct MainTabView: View {

    @EnvironmentObject var appState: AppState

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                switch appState.selectedTab {
                case .dashboard:
                    DashboardView()
                case .tasks:
                    TasksView()
                case .focus:
                    FocusView()
                case .analytics:
                    AnalyticsView()
                case .settings:
                    SettingsView()
                }
            }

            CustomTabBar()
        }
    }
}
