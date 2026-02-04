//
//  AddTaskView.swift
//  FocusFlowPro
//
//  Created by Пащенко Иван on 04.02.2026.
//


import SwiftUI

struct AddTaskView: View {
    
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) private var dismiss
    
    @State private var title = ""
    @State private var category: TaskCategory = .work
    @State private var priority: TaskPriority = .medium
    @State private var difficulty = 1
    
    /// Discrete effort levels used in the Effort selector.
    private struct EffortLevel: Identifiable {
        let id: Int
        let label: String
    }
    
    private let effortLevels: [EffortLevel] = [
        EffortLevel(id: 1, label: "Light"),
        EffortLevel(id: 2, label: "Standard"),
        EffortLevel(id: 3, label: "Deep")
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                AppTheme.background.ignoresSafeArea()
                BlurredBackground()
                    .ignoresSafeArea()
                
                VStack(spacing: 24) {
                    
                    // Header
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("New Task")
                                .font(.title.bold())
                                .foregroundColor(AppTheme.textPrimary)
                            Text("Write down what deserves your focus")
                                .font(.subheadline)
                                .foregroundColor(AppTheme.textSecondary)
                        }
                        Spacer()
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .font(.subheadline.weight(.semibold))
                                .foregroundColor(AppTheme.textSecondary)
                                .padding(8)
                                .background(AppTheme.cardBackground)
                                .clipShape(Circle())
                        }
                    }
                    .padding(.top, 8)
                    
                    ScrollView {
                        VStack(spacing: 16) {
                            
                            // Title
                            GlassCard {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Title")
                                        .font(.caption.smallCaps())
                                        .foregroundColor(AppTheme.textSecondary)
                                    
                                    TextField("Task title", text: $title)
                                        .font(.body)
                                        .foregroundColor(AppTheme.textPrimary)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 10)
                                        .background(Color.white.opacity(0.02))
                                        .cornerRadius(10)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(AppTheme.cardStroke, lineWidth: 1)
                                        )
                                }
                            }
                            
                            // Category
                            GlassCard {
                                VStack(alignment: .leading, spacing: 12) {
                                    Text("Category")
                                        .font(.caption.smallCaps())
                                        .foregroundColor(AppTheme.textSecondary)
                                    
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack(spacing: 8) {
                                            ForEach(TaskCategory.allCases, id: \.self) { item in
                                                selectionChip(
                                                    title: item.rawValue.capitalized,
                                                    selected: category == item
                                                ) {
                                                    category = item
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            
                            // Priority
                            GlassCard {
                                VStack(alignment: .leading, spacing: 12) {
                                    Text("Priority")
                                        .font(.caption.smallCaps())
                                        .foregroundColor(AppTheme.textSecondary)
                                    
                                    HStack(spacing: 8) {
                                        ForEach(TaskPriority.allCases, id: \.self) { item in
                                            selectionChip(
                                                title: item.rawValue.capitalized,
                                                selected: priority == item
                                            ) {
                                                priority = item
                                            }
                                        }
                                    }
                                }
                            }
                            
                            // Difficulty
                            GlassCard {
                                VStack(alignment: .leading, spacing: 12) {
                                    Text("Effort")
                                        .font(.caption.smallCaps())
                                        .foregroundColor(AppTheme.textSecondary)
                                    
                                    HStack(spacing: 8) {
                                        ForEach(effortLevels) { level in
                                            selectionChip(
                                                title: level.label,
                                                selected: difficulty == level.id
                                            ) {
                                                difficulty = level.id
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.top, 8)
                        .padding(.bottom, 8)
                    }
                    
                    Button(action: addTask) {
                        Text("Add Task")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                    }
                    .buttonStyle(PrimaryButtonStyle())
                    .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    .opacity(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 0.5 : 1.0)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
            }
            .navigationBarHidden(true)
        }
    }
    
    private func addTask() {
        let task = Task(
            title: title,
            category: category,
            priority: priority,
            difficulty: difficulty
        )
        
        appState.tasks.append(task)
        HapticService.impact(.medium)
        dismiss()
    }
    
    // MARK: - UI Helpers
    
    private func selectionChip(
        title: String,
        selected: Bool,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Text(title)
                .font(.caption.weight(.semibold))
                .foregroundColor(AppTheme.textPrimary.opacity(0.9))
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(selected ? AppTheme.chipSelectedBackground : AppTheme.chipBackground)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(AppTheme.cardStroke, lineWidth: selected ? 1.2 : 0.8)
                )
                .cornerRadius(16)
        }
        .buttonStyle(.plain)
    }
}
