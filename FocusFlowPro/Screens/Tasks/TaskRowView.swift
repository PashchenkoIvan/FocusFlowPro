//
//  TaskRowView.swift
//  FocusFlowPro
//
//  Created by Пащенко Иван on 04.02.2026.
//


import SwiftUI

struct TaskRowView: View {

    @EnvironmentObject var appState: AppState
    let task: Task

    var body: some View {
        HStack(spacing: 14) {

            Button {
                toggle()
            } label: {
                Image(systemName: task.status == .done
                      ? "checkmark.circle.fill"
                      : "circle")
                    .font(.title2)
                    .foregroundColor(task.status == .done ? .green : .gray)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(task.title)
                    .font(.headline)
                    .foregroundColor(.white)
                    .strikethrough(task.status == .done)

                Text(task.category.rawValue.capitalized)
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Spacer()
        }
        .padding()
        .background(AppTheme.cardBackground)
        .cornerRadius(16)
    }

    private func toggle() {
        guard let index = appState.tasks.firstIndex(where: { $0.id == task.id }) else { return }
        withAnimation(.spring()) {
            appState.tasks[index].status =
                appState.tasks[index].status == .done ? .planned : .done
            appState.tasks[index].completedAt = Date()
        }
        HapticService.impact(.medium)   // 🔥 ВОТ ЗДЕСЬ
    }
}
