//
//  CalendarHeatmapView.swift
//  FocusFlowPro
//
//  Created by Пащенко Иван on 04.02.2026.
//


import SwiftUI

struct CalendarHeatmapView: View {

    @EnvironmentObject var appState: AppState

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 6), count: 7)

    var body: some View {
        LazyVGrid(columns: columns, spacing: 6) {
            ForEach(last30Days(), id: \.self) { date in
                Circle()
                    .fill(color(for: date))
                    .frame(height: 12)
            }
        }
    }

    private func last30Days() -> [Date] {
        (0..<30).compactMap {
            Calendar.current.date(byAdding: .day, value: -$0, to: Date())
        }.reversed()
    }

    private func color(for date: Date) -> Color {
        let sessions = appState.focusSessions.filter {
            Calendar.current.isDate($0.startTime, inSameDayAs: date)
        }

        switch sessions.count {
        case 0: return Color.white.opacity(0.05)
        case 1...2: return Color.cyan.opacity(0.4)
        default: return Color.cyan
        }
    }
}