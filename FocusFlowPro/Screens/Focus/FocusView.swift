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
        VStack(spacing: 32) {
            
            Text("Focus Session")
                .font(.largeTitle.bold())
                .foregroundColor(.white)
            
            CircularTimerView(
                progress: viewModel.remainingTime / viewModel.totalTime,
                time: viewModel.remainingTime
            )
            
            EnergySelectorView(selected: $selectedEnergy)
            
            HStack(spacing: 24) {
                Button(action: toggle) {
                    Text(viewModel.isRunning ? "Pause" : "Start")
                        .font(.headline)
                        .frame(width: 120, height: 44)
                        .background(AppTheme.accentGradient)
                        .cornerRadius(22)
                }
                
                Button(action: reset) {
                    Image(systemName: "arrow.counterclockwise")
                        .font(.title2)
                        .foregroundColor(.white)
                }
            }
            
            Spacer()
        }
        .onChange(of: viewModel.didFinish) { finished in
            if finished {
                saveSession()
            }
        }
        .padding()
        .background(AppTheme.background.ignoresSafeArea())
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
