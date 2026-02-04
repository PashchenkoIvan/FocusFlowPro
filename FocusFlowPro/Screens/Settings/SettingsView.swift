//
//  SettingsView.swift
//  FocusFlowPro
//
//  Created by Пащенко Иван on 04.02.2026.
//


import SwiftUI

struct SettingsView: View {

    @EnvironmentObject var appState: AppState

    var body: some View {
        NavigationView {
            ZStack {
                AppTheme.background.ignoresSafeArea()
                BlurredBackground()
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 24) {

                        // Header
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Settings")
                                .font(.largeTitle.bold())
                                .foregroundColor(AppTheme.textPrimary)
                            Text("Fine‑tune how FocusFlow behaves")
                                .font(.subheadline)
                                .foregroundColor(AppTheme.textSecondary)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 8)

                        // Appearance
                        GlassCard {
                            VStack(alignment: .leading, spacing: 16) {
                                Text("Appearance")
                                    .font(.caption.smallCaps())
                                    .foregroundColor(AppTheme.textSecondary)

                                HStack(spacing: 12) {
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text("Dark Mode")
                                            .foregroundColor(AppTheme.textPrimary)
                                        Text("Use a darker look that’s easy on the eyes")
                                            .font(.caption)
                                            .foregroundColor(AppTheme.textSecondary)
                                    }
                                    Spacer()
                                    Toggle("", isOn: $appState.isDarkMode)
                                        .labelsHidden()
                                        .toggleStyle(SwitchToggleStyle(tint: AppTheme.tint))
                                }
                            }
                        }

                        // Feedback
                        GlassCard {
                            VStack(alignment: .leading, spacing: 16) {
                                Text("Feedback")
                                    .font(.caption.smallCaps())
                                    .foregroundColor(AppTheme.textSecondary)

                                HStack(spacing: 12) {
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text("Haptics")
                                            .foregroundColor(AppTheme.textPrimary)
                                        Text("Small taps for important actions")
                                            .font(.caption)
                                            .foregroundColor(AppTheme.textSecondary)
                                    }
                                    Spacer()
                                    Toggle("", isOn: $appState.hapticsEnabled)
                                        .labelsHidden()
                                        .toggleStyle(SwitchToggleStyle(tint: AppTheme.tint))
                                }
                            }
                        }

                        // About
                        GlassCard {
                            VStack(alignment: .leading, spacing: 12) {
                                Text("About")
                                    .font(.caption.smallCaps())
                                    .foregroundColor(AppTheme.textSecondary)

                                NavigationLink {
                                    AboutView()
                                } label: {
                                    HStack {
                                        VStack(alignment: .leading, spacing: 2) {
                                            Text("About FocusFlow Pro")
                                                .foregroundColor(AppTheme.textPrimary)
                                            Text("Version info and a short story")
                                                .font(.caption)
                                                .foregroundColor(AppTheme.textSecondary)
                                        }
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .font(.footnote.weight(.semibold))
                                            .foregroundColor(AppTheme.textSecondary)
                                    }
                                }
                            }
                        }

                        // Danger zone
                        GlassCard {
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Danger Zone")
                                    .font(.caption.smallCaps())
                                    .foregroundColor(Color.red.opacity(0.8))

                                Button {
                                    resetData()
                                } label: {
                                    HStack {
                                        Image(systemName: "trash")
                                            .font(.subheadline)
                                        Text("Reset All Data")
                                            .font(.subheadline.weight(.semibold))
                                        Spacer()
                                    }
                                    .foregroundColor(.red)
                                    .padding(.vertical, 6)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 24)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .tint(AppTheme.tint)
        }
    }

    private func resetData() {
        appState.tasks.removeAll()
        appState.focusSessions.removeAll()
        appState.energyEntries.removeAll()
    }
}
