//
//  CircularTimerView.swift
//  FocusFlowPro
//
//  Created by Пащенко Иван on 04.02.2026.
//


import SwiftUI

struct CircularTimerView: View {

    let progress: Double
    let time: TimeInterval

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.white.opacity(0.1), lineWidth: 14)

            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    AppTheme.accentGradient,
                    style: StrokeStyle(lineWidth: 14, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .animation(.linear, value: progress)

            Text(format(time))
                .font(.system(size: 36, weight: .bold))
                .foregroundColor(.white)
        }
        .frame(width: 220, height: 220)
    }

    private func format(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}