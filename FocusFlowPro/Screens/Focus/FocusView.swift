//
//  FocusView.swift
//  FocusFlowPro
//
//  Created by Пащенко Иван on 04.02.2026.
//


import SwiftUI

struct FocusView: View {
    
    @EnvironmentObject var appState: AppState
    @ObservedObject var viewModel: FocusViewModel
    
    @State private var selectedEnergy: EnergyLevel = .medium
    
    private let durations = [15, 25, 50]
    
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
                
                // Duration selector
                HStack(spacing: 8) {
                    ForEach(durations, id: \.self) { minutes in
                        Button {
                            viewModel.setDuration(minutes: minutes)
                        } label: {
                            Text("\(minutes) min")
                                .font(.caption.weight(.semibold))
                                .foregroundColor(AppTheme.textPrimary.opacity(0.9))
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(
                                    selectedDuration == minutes
                                    ? AppTheme.chipSelectedBackground
                                    : AppTheme.chipBackground
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 14)
                                        .stroke(AppTheme.cardStroke, lineWidth: selectedDuration == minutes ? 1.2 : 0.8)
                                )
                                .cornerRadius(14)
                        }
                        .buttonStyle(.plain)
                        .disabled(viewModel.isRunning)
                        .opacity(viewModel.isRunning ? 0.5 : 1.0)
                    }
                }
                .padding(.top, 4)
                
                CircularTimerView(
                    progress: viewModel.remainingTime / max(viewModel.totalTime, 1),
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
    
    private var selectedDuration: Int {
        Int(viewModel.totalTime / 60)
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

