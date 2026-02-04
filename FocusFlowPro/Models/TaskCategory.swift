//
//  TaskCategory.swift
//  FocusFlowPro
//
//  Created by Пащенко Иван on 04.02.2026.
//


import Foundation

enum TaskCategory: String, CaseIterable, Codable {
    case work, personal, health
}

enum TaskPriority: String, CaseIterable, Codable {
    case low, medium, high
}

enum TaskStatus: String, Codable {
    case planned
    case inProgress
    case done
}
