//
//  EnergyCheckInView.swift
//  FocusFlowPro
//
//  Created by Пащенко Иван on 04.02.2026.
//


import SwiftUI

struct EnergyCheckInView: View {

    @EnvironmentObject var appState: AppState
    @State private var selected: EnergyLevel = .medium

    var body: some View {
        VStack(spacing: 24) {
            Text("How’s your energy today?")
                .font(.largeTitle.bold())
                .foregroundColor(.white)

            EnergySelectorView(selected: $selected)

            Button {
                save()
            } label: {
                Text("Save")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(AppTheme.accentGradient)
                    .cornerRadius(16)
            }

            Spacer()
        }
        .padding()
        .background(AppTheme.background.ignoresSafeArea())
    }

    private func save() {
        let entry = EnergyEntry(date: Date(), level: selected)
        appState.energyEntries.append(entry)
        HapticService.notification(.success)
    }
}