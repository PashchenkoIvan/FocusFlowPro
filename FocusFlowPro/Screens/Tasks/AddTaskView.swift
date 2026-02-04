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

    var body: some View {
        NavigationView {
            Form {
                TextField("Task title", text: $title)

                Picker("Category", selection: $category) {
                    ForEach(TaskCategory.allCases, id: \.self) {
                        Text($0.rawValue.capitalized)
                    }
                }

                Picker("Priority", selection: $priority) {
                    ForEach(TaskPriority.allCases, id: \.self) {
                        Text($0.rawValue.capitalized)
                    }
                }

                Stepper("Difficulty: ⚡️\(difficulty)", value: $difficulty, in: 1...3)
            }
            .navigationTitle("New Task")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        addTask()
                    }
                }
            }
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
}
