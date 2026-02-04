//
//  FocusView.swift
//  FocusFlowPro
//
//  Created by Пащенко Иван on 04.02.2026.
//


import SwiftUI

struct FocusView: View {
    
    @EnvironmentObject var appState: AppState
    @StateObject private var viewModel = FocusViewModel()
    
    @State private var selectedEnergy: EnergyLevel = .medium
    
    var body: some View {
        ZStack {
            AppTheme.background.ignoresSafeArea()
            BlurredBackground()
                .ignoresSafeArea()

            VStack(spacing: 28) {
                
                VStack(spacing: 6) {
                    Text("Focus Session")
                        .font(.largeTitle.bold())
                        .foregroundColor(AppTheme.textPrimary)
                    
                    Text("Set a timer and get into flow")
                        .font(.subheadline)
                        .foregroundColor(AppTheme.textSecondary)
                }
                
                CircularTimerView(
                    progress: viewModel.remainingTime / viewModel.totalTime,
                    time: viewModel.remainingTime
                )
                .padding(.top, 8)
                
                EnergySelectorView(selected: $selectedEnergy)
                    .padding(.top, 4)
                
                HStack(spacing: 16) {
                    Button(action: toggle) {
                        Text(viewModel.isRunning ? "Pause" : "Start")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                    }
                    .buttonStyle(PrimaryButtonStyle())

                    Button(action: reset) {
                        Image(systemName: "arrow.counterclockwise")
                            .font(.headline)
                            .foregroundColor(AppTheme.textPrimary)
                            .padding(14)
                            .background(AppTheme.cardBackground)
                            .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(AppTheme.cardStroke, lineWidth: 1)
                            )
                            .cornerRadius(14)
                    }
                }
                .padding(.top, 4)
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 40)
            .padding(.bottom, 24)
        }
        .onChange(of: viewModel.didFinish) { finished in
            if finished {
                saveSession()
            }
        }
    }
    
    private func toggle() {
        viewModel.isRunning ? viewModel.pause() : viewModel.start()
    }
    
    private func reset() {
        viewModel.reset()
    }
    
    private func saveSession() {
        let session = FocusSession(
            taskId: nil,
            startTime: Date().addingTimeInterval(-viewModel.totalTime),
            duration: viewModel.totalTime,
            energyLevel: selectedEnergy
        )
        
        appState.focusSessions.append(session)
    }
}

