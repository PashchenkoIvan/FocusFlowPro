//
//  InsightCardView.swift
//  FocusFlowPro
//
//  Created by Пащенко Иван on 04.02.2026.
//


import SwiftUI

struct InsightCardView: View {

    let insight: String

    var body: some View {
        GlassCard {
            VStack(alignment: .leading, spacing: 8) {
                Text("Insight")
                    .font(.headline)
                    .foregroundColor(.white)

                Text(insight)
                    .foregroundColor(.gray)
            }
        }
    }
}