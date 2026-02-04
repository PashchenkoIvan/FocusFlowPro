//
//  SectionHeaderView.swift
//  FocusFlowPro
//
//  Created by Пащенко Иван on 04.02.2026.
//


import SwiftUI

struct SectionHeaderView: View {

    let title: String

    var body: some View {
        HStack(spacing: 12) {
            Text(title.uppercased())
                .font(.caption.smallCaps())
                .foregroundColor(AppTheme.textSecondary)
            
            Spacer()
        }
        .padding(.top, 4)
    }
}