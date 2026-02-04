//
//  FocusSummaryCard.swift
//  FocusFlowPro
//
//  Created by Пащенко Иван on 04.02.2026.
//


import SwiftUI

struct FocusSummaryCard: View {

    let progress: Double

    var body: some View {
        GlassCard {
            VStack(spacing: 12) {
                Text("Today Focus")
                    .font(.headline)
                    .foregroundColor(AppTheme.textPrimary)

                CircularProgressView(progress: progress)

                Text("\(Int(progress * 100))% completed")
                    .font(.subheadline)
                    .foregroundColor(AppTheme.textSecondary)
            }
        }
        .animation(
            .spring(response: 0.4, dampingFraction: 0.8),
            value: progress
        )
    }
}
