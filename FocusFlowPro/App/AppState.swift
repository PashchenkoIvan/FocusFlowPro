//
//  AppState.swift
//  FocusFlowPro
//
//  Created by Пащенко Иван on 04.02.2026.
//


import Foundation
import SwiftUI
import Combine

final class AppState: ObservableObject {

    // MARK: - UI
    @Published var selectedTab: Tab = .dashboard
    @Published var isDarkMode: Bool = true
    @Published var hapticsEnabled: Bool = true

    // MARK: - Data
    @Published var tasks: [Task] = [] {
        didSet {
            PersistenceService.save(tasks, to: tasksFile)
        }
    }

    @Published var focusSessions: [FocusSession] = [] {
        didSet {
            PersistenceService.save(focusSessions, to: sessionsFile)
        }
    }

    @Published var energyEntries: [EnergyEntry] = [] {
        didSet {
            PersistenceService.save(energyEntries, to: energyFile)
        }
    }

    // MARK: - Files
    private let tasksFile = "tasks.json"
    private let sessionsFile = "sessions.json"
    private let energyFile = "energy.json"

    // MARK: - Init
    init() {
        load()
    }

    // MARK: - Load
    private func load() {
        tasks = PersistenceService.load([Task].self, from: tasksFile) ?? []
        focusSessions = PersistenceService.load([FocusSession].self, from: sessionsFile) ?? []
        energyEntries = PersistenceService.load([EnergyEntry].self, from: energyFile) ?? []
    }
}
