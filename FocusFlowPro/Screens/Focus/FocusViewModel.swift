//
//  FocusViewModel.swift
//  FocusFlowPro
//
//  Created by Пащенко Иван on 04.02.2026.
//


import Foundation
import Combine
import SwiftUI

final class FocusViewModel: ObservableObject {

    @Published var remainingTime: TimeInterval
    @Published var isRunning = false
    @Published var didFinish = false   // 🔥 ВАЖНО
    @Published var totalTime: TimeInterval
    private var timer: AnyCancellable?

    init(minutes: Int = 25) {
        let initial = TimeInterval(minutes * 60)
        self.totalTime = initial
        self.remainingTime = initial
    }

    func start() {
        isRunning = true
        didFinish = false

        timer = Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.tick()
            }
    }

    func pause() {
        isRunning = false
        timer?.cancel()
    }

    func reset() {
        pause()
        remainingTime = totalTime
    }

    func setDuration(minutes: Int) {
        guard !isRunning else { return }
        let newTotal = TimeInterval(minutes * 60)
        totalTime = newTotal
        remainingTime = newTotal
        didFinish = false
    }

    private func tick() {
        guard remainingTime > 0 else {
            complete()
            return
        }

        remainingTime -= 1

        if Int(remainingTime) % 60 == 0 {
            HapticService.impact(.light)
        }
    }

    private func complete() {
        pause()
        didFinish = true              // 🔥 СИГНАЛ
        HapticService.notification(.success)
    }
}
