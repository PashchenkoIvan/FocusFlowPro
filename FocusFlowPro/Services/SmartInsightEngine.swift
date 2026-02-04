//
//  SmartInsightEngine.swift
//  FocusFlowPro
//
//  Created by Пащенко Иван on 04.02.2026.
//


import Foundation

enum SmartInsightEngine {

    static func generate(
        tasks: [Task],
        sessions: [FocusSession]
    ) -> String {

        guard !tasks.isEmpty else {
            return "Add your first task to start building momentum 🚀"
        }

        let completed = tasks.filter { $0.status == .done }.count
        let rate = Double(completed) / Double(tasks.count)

        if rate > 0.7 {
            return "🔥 Great job! You complete most of your tasks."
        } else if rate > 0.4 {
            return "⚡️ You’re making progress. Stay consistent."
        } else {
            return "⏳ Focus on finishing smaller tasks first."
        }
    }
}