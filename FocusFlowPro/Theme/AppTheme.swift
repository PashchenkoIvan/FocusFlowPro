//
//  AppTheme.swift
//  FocusFlowPro
//
//  Created by Пащенко Иван on 04.02.2026.
//


import SwiftUI

enum AppTheme {

    static let background = Color(hex: "#0B0E14")

    static let accentGradient = LinearGradient(
        colors: [
            Color(hex: "#6A5CFF"),
            Color(hex: "#00E5FF")
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let cardBackground = Color.white.opacity(0.08)
}