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
                
                VStack(alignment: .leading, spacing: 6) {
                    Text("Analytics")
                        .font(.largeTitle.bold())
                        .foregroundColor(AppTheme.textPrimary)
                    
                    Text("See how your focus adds up")
                        .font(.subheadline)
                        .foregroundColor(AppTheme.textSecondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 8)
                
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
            .padding(.horizontal, 20)
            .padding(.bottom, 24)
        }
        .background(
            ZStack {
                AppTheme.background.ignoresSafeArea()
                BlurredBackground()
                    .ignoresSafeArea()
            }
        )
    }
    
    @ViewBuilder private func statCard(title: String, value: String, icon: String) -> some View {
        GlassCard {
            HStack {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(.cyan)
                
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.subheadline)
                        .foregroundColor(AppTheme.textSecondary)
                    Text(value)
                        .font(.title2.bold())
                        .foregroundColor(AppTheme.textPrimary)
                }
                Spacer()
            }
        }
    }
    
    private func analyticsInsight() -> String {
        if focusMinutes > 120 {
            return "🔥 Strong focus streak — keep it going."
        } else if completedTasks > 5 {
            return "⚡️ You’re shipping tasks consistently."
        } else {
            return "⏳ Start with short sessions to build momentum."
        }
    }
}

