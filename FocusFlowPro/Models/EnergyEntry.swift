//
//  EnergyEntry.swift
//  FocusFlowPro
//
//  Created by Пащенко Иван on 04.02.2026.
//


import Foundation

struct EnergyEntry: Identifiable, Codable {
    let id: UUID
    let date: Date
    let level: EnergyLevel

    init(
        id: UUID = UUID(),
        date: Date,
        level: EnergyLevel
    ) {
        self.id = id
        self.date = date
        self.level = level
    }
}