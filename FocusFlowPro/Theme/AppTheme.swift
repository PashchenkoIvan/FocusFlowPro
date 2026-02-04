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

    // Glass / surfaces
    static let cardBackground = Color.white.opacity(0.08)
    static let cardStroke = Color.white.opacity(0.12)

    // Text
    static let textPrimary = Color.white
    static let textSecondary = Color.white.opacity(0.6)

    // Controls
    static let tint = Color(hex: "#6A5CFF")
    static let chipBackground = Color.white.opacity(0.06)
    static let chipSelectedBackground = Color.white.opacity(0.14)

    // Shadows
    static let shadow = Color.black.opacity(0.35)
}
