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
        ZStack {
            AppTheme.background.ignoresSafeArea()
            BlurredBackground()
                .ignoresSafeArea()

            VStack(spacing: 28) {
                Text("Energy check‑in")
                    .font(.largeTitle.bold())
                    .foregroundColor(AppTheme.textPrimary)

                Text("Quick snapshot of how you feel")
                    .font(.subheadline)
                    .foregroundColor(AppTheme.textSecondary)

                EnergySelectorView(selected: $selected)
                    .padding(.top, 8)

                Button {
                    save()
                } label: {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                }
                .buttonStyle(PrimaryButtonStyle())
                .padding(.top, 12)

                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 40)
            .padding(.bottom, 24)
        }
    }

    private func save() {
        let entry = EnergyEntry(date: Date(), level: selected)
        appState.energyEntries.append(entry)
        HapticService.notification(.success)
    }
}