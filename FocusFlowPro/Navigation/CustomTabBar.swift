//
//  CustomTabBar.swift
//  FocusFlowPro
//
//  Created by Пащенко Иван on 04.02.2026.
//


import SwiftUI

struct CustomTabBar: View {

    @EnvironmentObject var appState: AppState

    var body: some View {
        HStack {
            tabButton(.dashboard, "house.fill")
            tabButton(.tasks, "checklist")
            tabButton(.focus, "timer")
            tabButton(.analytics, "chart.xyaxis.line")
            tabButton(.settings, "gearshape.fill")
        }
        .padding()
        .background(.ultraThinMaterial)
    }

    private func tabButton(_ tab: Tab, _ icon: String) -> some View {
        Button {
            withAnimation(.spring()) {
                appState.selectedTab = tab
            }
        } label: {
            Image(systemName: icon)
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(
                    appState.selectedTab == tab ? .cyan : .gray
                )
                .frame(maxWidth: .infinity)
        }
    }
}
