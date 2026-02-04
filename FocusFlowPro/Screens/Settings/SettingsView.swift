//
//  SettingsView.swift
//  FocusFlowPro
//
//  Created by Пащенко Иван on 04.02.2026.
//


import SwiftUI

struct SettingsView: View {

    @EnvironmentObject var appState: AppState

    var body: some View {
        NavigationView {
            List {

                Section(header: Text("Appearance")) {
                    Toggle("Dark Mode", isOn: $appState.isDarkMode)
                }

                Section(header: Text("About")) {
                    NavigationLink("About FocusFlow Pro") {
                        AboutView()
                    }
                }

                Section {
                    Button(role: .destructive) {
                        resetData()
                    } label: {
                        Text("Reset All Data")
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }

    private func resetData() {
        appState.tasks.removeAll()
        appState.focusSessions.removeAll()
        appState.energyEntries.removeAll()
    }
}
