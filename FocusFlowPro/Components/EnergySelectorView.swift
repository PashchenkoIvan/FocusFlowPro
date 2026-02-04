//
//  EnergySelectorView.swift
//  FocusFlowPro
//
//  Created by Пащенко Иван on 04.02.2026.
//


import SwiftUI

struct EnergySelectorView: View {

    @Binding var selected: EnergyLevel

    var body: some View {
        HStack(spacing: 16) {
            energyButton(.low, "😴")
            energyButton(.medium, "😐")
            energyButton(.high, "🔥")
        }
    }

    private func energyButton(_ level: EnergyLevel, _ emoji: String) -> some View {
        Button {
            withAnimation(.spring()) {
                selected = level
            }
        } label: {
            Text(emoji)
                .font(.largeTitle)
                .padding()
                .background(
                    Circle()
                        .fill(selected == level
                              ? AppTheme.cardBackground
                              : Color.clear)
                )
        }
    }
}