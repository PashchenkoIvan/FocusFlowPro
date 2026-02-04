//
//  FocusSession.swift
//  FocusFlowPro
//
//  Created by Пащенко Иван on 04.02.2026.
//


import Foundation

struct FocusSession: Identifiable, Codable {

    let id: UUID
    let taskId: UUID?
    let startTime: Date
    let duration: TimeInterval
    let energyLevel: EnergyLevel

    init(
        id: UUID = UUID(),
        taskId: UUID?,
        startTime: Date,
        duration: TimeInterval,
        energyLevel: EnergyLevel
    ) {
        self.id = id
        self.taskId = taskId
        self.startTime = startTime
        self.duration = duration
        self.energyLevel = energyLevel
    }
}
