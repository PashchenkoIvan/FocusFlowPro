//
//  AnalyticsView.swift
//  FocusFlowPro
//
//  Created by Пащенко Иван on 04.02.2026.
//


import SwiftUI

struct AnalyticsView: View {
    
    @EnvironmentObject var appState: AppState
    
    private var completedTasks: Int {
        appState.tasks.filter { $0.status == .done }.count
    }
    
    private var focusMinutes: Int {
        Int(appState.focusSessions.reduce(0) { $0 + $1.duration } / 60)
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                
                Text("Analytics")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                statCard(title: "Completed Tasks",
                         value: "\(completedTasks)",
                         icon: "checkmark.circle.fill")
                
                statCard(title: "Focus Time",
                         value: "\(focusMinutes) min",
                         icon: "timer")
                
                InsightCardView(
                    insight: analyticsInsight()
                )
                
                SectionHeaderView(title: "Last 30 Days")
                CalendarHeatmapView()
            }
            .padding()
        }
        .background(AppTheme.background.ignoresSafeArea())
    }
    
    private func statCard(title: String, value: String, icon: String) -> some View {
        GlassCard {
            HStack {
                Image(systemName: icon)
                    .font(.title)
                    .foregroundColor(.cyan)
                
                VStack(alignment: .leading) {
                    Text(title)
                        .foregroundColor(.gray)
                    Text(value)
                        .font(.title.bold())
                        .foregroundColor(.white)
                }
                Spacer()
            }
        }
    }
    
    private func analyticsInsight() -> String {
        if focusMinutes > 120 {
            return "🔥 You stay focused longer than most users."
        } else if completedTasks > 5 {
            return "⚡️ Consistent progress detected."
        } else {
            return "⏳ Try short focus sessions to build momentum."
        }
    }
}
