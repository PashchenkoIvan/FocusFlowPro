//
//  TasksView.swift
//  FocusFlowPro
//
//  Created by Пащенко Иван on 04.02.2026.
//

import SwiftUI

struct TasksView: View {
    
    @EnvironmentObject var appState: AppState
    
    @State private var selectedCategory: TaskCategory? = nil
    @State private var selectedPriority: TaskPriority? = nil
    @State private var showAddTask = false
    
    // MARK: - Filtering
    
    private var filteredTasks: [Task] {
        appState.tasks.filter { task in
            (selectedCategory == nil || task.category == selectedCategory) &&
            (selectedPriority == nil || task.priority == selectedPriority)
        }
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            
            VStack(spacing: 16) {
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Tasks")
                            .font(.largeTitle.bold())
                            .foregroundColor(AppTheme.textPrimary)
                        
                        Text("Lightweight list for what matters today")
                            .font(.subheadline)
                            .foregroundColor(AppTheme.textSecondary)
                    }
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 8)
                
                filterBar
                
                ScrollView {
                    if filteredTasks.isEmpty {
                        emptyState
                    } else {
                        VStack(spacing: 12) {
                            ForEach(filteredTasks) { task in
                                TaskRowView(task: task)
                                    .contextMenu {
                                        startFocusButton
                                        completeButton(for: task)
                                    }
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 24)
                    }
                }
            }
            
            Button {
                showAddTask = true
                HapticService.impact(.light)
            } label: {
                Image(systemName: "plus")
                    .font(.title2.weight(.bold))
                    .foregroundColor(AppTheme.textPrimary)
                    .frame(width: 56, height: 56)
                    .background(AppTheme.accentGradient)
                    .clipShape(Circle())
                    .shadow(color: AppTheme.shadow, radius: 20, x: 0, y: 10)
                    .padding()
            }
        }
        .sheet(isPresented: $showAddTask) {
            AddTaskView()
                .environmentObject(appState)
        }
        .background(
            ZStack {
                AppTheme.background.ignoresSafeArea()
                BlurredBackground()
                    .ignoresSafeArea()
            }
        )
    }
    
    // MARK: - Empty State
    
    private var emptyState: some View {
        GlassCard {
            VStack(spacing: 10) {
                Image(systemName: "checklist")
                    .font(.system(size: 40))
                    .foregroundColor(.gray)
                Text("No tasks yet")
                    .font(.headline)
                    .foregroundColor(AppTheme.textPrimary)
                Text("Add a first task to give your focus a target")
                    .font(.caption)
                    .foregroundColor(AppTheme.textSecondary)
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, 20)
        .padding(.top, 40)
    }
    
    // MARK: - Filter Bar
    
    private var filterBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                
                filterChip(
                    title: "All",
                    selected: selectedCategory == nil
                ) {
                    selectedCategory = nil
                }
                
                ForEach(TaskCategory.allCases, id: \.self) { category in
                    filterChip(
                        title: category.rawValue.capitalized,
                        selected: selectedCategory == category
                    ) {
                        selectedCategory = category
                    }
                }
            }
            .padding(.horizontal)
        }
    }
    
    private func filterChip(
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
    }
    
    // MARK: - Context Menu Actions
    
    private var startFocusButton: some View {
        Button("Start Focus") {
            HapticService.impact(.light)
            appState.selectedTab = .focus
        }
    }
    
    private func completeButton(for task: Task) -> some View {
        Button("Complete") {
            complete(task)
        }
    }
    
    // MARK: - Actions
    
    private func complete(_ task: Task) {
        guard let index = appState.tasks.firstIndex(where: { $0.id == task.id }) else { return }
        
        withAnimation(.spring()) {
            appState.tasks[index].status = .done
            appState.tasks[index].completedAt = Date()
        }
        
        HapticService.impact(.medium)
    }
}

