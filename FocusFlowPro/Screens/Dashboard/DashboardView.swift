//
//  DashboardView.swift
//  FocusFlowPro
//
//  Created by Пащенко Иван on 04.02.2026.
//


import SwiftUI

struct DashboardView: View {

    @EnvironmentObject var appState: AppState

    private var completedTasks: Int {
        appState.tasks.filter { $0.status == .done }.count
    }

    private var progress: Double {
        guard !appState.tasks.isEmpty else { return 0 }
        return Double(completedTasks) / Double(appState.tasks.count)
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 24) {

                header
                    .padding(.top, 8)
                
                quickActions

                FocusSummaryCard(progress: progress)

                InsightCardView(insight: SmartInsightEngine.generate(
                    tasks: appState.tasks,
                    sessions: appState.focusSessions
                ))

                SectionHeaderView(title: "Today's Tasks")

                VStack(spacing: 12) {
                    ForEach(appState.tasks.prefix(4)) { task in
                        TaskRowView(task: task)
                    }
                }
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
    
    private var quickActions: some View {
        HStack(spacing: 16) {

            GlassCard {
                VStack {
                    Image(systemName: "timer")
                        .font(.title)
                    Text("Focus session")
                        .font(.caption)
                }
                .foregroundColor(.white)
            }
            .onTapGesture {
                HapticService.impact(.light)
                appState.selectedTab = .focus
            }

            GlassCard {
                VStack {
                    Image(systemName: "bolt.fill")
                        .font(.title)
                    Text("Energy check‑in")
                        .font(.caption)
                }
                .foregroundColor(.white)
            }
            .onTapGesture {
                HapticService.impact(.light)
                appState.selectedTab = .analytics // или отдельный Energy экран
            }
        }
    }

    private var header: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text("Today")
                    .font(.largeTitle.bold())
                    .foregroundColor(AppTheme.textPrimary)

                Text(Date(), style: .date)
                    .font(.subheadline)
                    .foregroundColor(AppTheme.textSecondary)
            }

            Spacer()
        }
    }
}

