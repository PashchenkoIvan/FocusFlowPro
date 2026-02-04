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
            
            VStack(spacing: 12) {
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
                        .padding()
                    }
                }
            }
            
            Button {
                showAddTask = true
                HapticService.impact(.light)
            } label: {
                Image(systemName: "plus")
                    .font(.title)
                    .foregroundColor(.black)
                    .frame(width: 56, height: 56)
                    .background(Color.white)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .padding()
            }
        }
        .sheet(isPresented: $showAddTask) {
            AddTaskView()
                .environmentObject(appState)
        }
    }
    
    // MARK: - Empty State
    
    private var emptyState: some View {
        VStack(spacing: 12) {
            Image(systemName: "checklist")
                .font(.system(size: 40))
                .foregroundColor(.gray)
            
            Text("No tasks yet")
                .font(.headline)
                .foregroundColor(.white)
            
            Text("Create your first task to start focusing")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding(.top, 60)
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
                .font(.caption)
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(selected ? AppTheme.cardBackground : Color.clear)
                .cornerRadius(16)
                .foregroundColor(.white)
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
