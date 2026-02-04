//
//  Task.swift
//  FocusFlowPro
//
//  Created by Пащенко Иван on 04.02.2026.
//


import Foundation

struct Task: Identifiable, Codable {

    let id: UUID
    var title: String
    var category: TaskCategory
    var priority: TaskPriority
    var difficulty: Int // ⚡️1–3
    var status: TaskStatus

    let createdAt: Date
    var completedAt: Date?

    init(
        id: UUID = UUID(),
        title: String,
        category: TaskCategory,
        priority: TaskPriority,
        difficulty: Int,
        status: TaskStatus = .planned,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.title = title
        self.category = category
        self.priority = priority
        self.difficulty = difficulty
        self.status = status
        self.createdAt = createdAt
    }
}
