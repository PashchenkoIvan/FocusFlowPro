//
//  GradientBackground.swift
//  FocusFlowPro
//
//  Created by Пащенко Иван on 04.02.2026.
//


import SwiftUI

struct GradientBackground: View {

    var body: some View {
        AppTheme.accentGradient
            .ignoresSafeArea()
    }
}