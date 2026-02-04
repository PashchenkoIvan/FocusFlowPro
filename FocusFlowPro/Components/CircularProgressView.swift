//
//  CircularProgressView.swift
//  FocusFlowPro
//
//  Created by Пащенко Иван on 04.02.2026.
//


import SwiftUI

struct CircularProgressView: View {

    let progress: Double

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.secondary.opacity(0.25), lineWidth: 12)

            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    AppTheme.accentGradient,
                    style: StrokeStyle(lineWidth: 12, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeOut, value: progress)

            Text("\(Int(progress * 100))%")
                .font(.title.bold())
                .foregroundColor(AppTheme.textPrimary)
        }
        .frame(width: 140, height: 140)
    }
}