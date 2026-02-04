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

    let totalTime: TimeInterval
    private var timer: AnyCancellable?

    init(minutes: Int = 25) {
        self.totalTime = TimeInterval(minutes * 60)
        self.remainingTime = self.totalTime
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
