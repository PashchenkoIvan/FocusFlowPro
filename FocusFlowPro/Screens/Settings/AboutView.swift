//
//  AboutView.swift
//  FocusFlowPro
//
//  Created by Пащенко Иван on 04.02.2026.
//


import SwiftUI

struct AboutView: View {
    var body: some View {
        ZStack {
            AppTheme.background.ignoresSafeArea()
            BlurredBackground()
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 24) {
                    VStack(spacing: 12) {
                        Text("FocusFlow Pro")
                            .font(.largeTitle.bold())
                            .foregroundColor(AppTheme.textPrimary)

                        Text("Minimal focus companion\nCrafted with SwiftUI")
                            .multilineTextAlignment(.center)
                            .font(.subheadline)
                            .foregroundColor(AppTheme.textSecondary)
                    }

                    GlassCard {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Why this app")
                                .font(.headline)
                                .foregroundColor(AppTheme.textPrimary)
                            Text("Lightweight focus sessions, quick task capture and simple energy check‑ins — without noisy dashboards.")
                                .font(.subheadline)
                                .foregroundColor(AppTheme.textSecondary)
                        }
                    }

                    GlassCard {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Design")
                                .font(.headline)
                                .foregroundColor(AppTheme.textPrimary)
                            Text("Optimized for both dark and light mode with a glassmorphism‑inspired look.")
                                .font(.subheadline)
                                .foregroundColor(AppTheme.textSecondary)
                        }
                    }

                    Spacer(minLength: 16)
                }
                .padding(.horizontal, 20)
                .padding(.top, 32)
                .padding(.bottom, 24)
            }
        }
    }
}