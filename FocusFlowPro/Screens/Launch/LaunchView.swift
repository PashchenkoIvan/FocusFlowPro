//
//  LaunchView.swift
//  FocusFlowPro
//
//  Created by Пащенко Иван on 04.02.2026.
//


import SwiftUI

struct LaunchView: View {

    @Binding var showMainApp: Bool

    @State private var scale: CGFloat = 0.8
    @State private var opacity: Double = 0.0

    var body: some View {
        ZStack {
            GradientBackground()

            VStack(spacing: 16) {
                Image(systemName: "bolt.fill")
                    .font(.system(size: 72))
                    .foregroundStyle(AppTheme.accentGradient)

                Text("FocusFlow Pro")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
            }
            .scaleEffect(scale)
            .opacity(opacity)
        }
        .onAppear {
            withAnimation(.easeOut(duration: 1.2)) {
                scale = 1.0
                opacity = 1.0
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
                withAnimation {
                    showMainApp = true
                }
            }
        }
    }
}
