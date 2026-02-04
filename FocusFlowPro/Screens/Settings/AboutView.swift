//
//  AboutView.swift
//  FocusFlowPro
//
//  Created by Пащенко Иван on 04.02.2026.
//


import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("FocusFlow Pro")
                .font(.largeTitle.bold())
                .foregroundColor(.white)

            Text("AI-assisted design & development\nBuilt with SwiftUI")
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)

            Spacer()
        }
        .padding()
        .background(AppTheme.background.ignoresSafeArea())
    }
}