import SwiftUI

// MARK: - Primary Button Style
struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundColor(.white)
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(AppTheme.accentGradient)
            .clipShape(Capsule())
            .overlay(
                Capsule()
                    .stroke(Color.white.opacity(0.12), lineWidth: 1)
            )
            .shadow(color: AppTheme.shadow, radius: 18, x: 0, y: 10)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(.spring(response: 0.25, dampingFraction: 0.7), value: configuration.isPressed)
    }
}

// MARK: - Blurred Background Decorations
struct BlurredBackground: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(AppTheme.accentGradient)
                .frame(width: 260, height: 260)
                .blur(radius: 80)
                .opacity(0.25)
                .offset(x: -140, y: -180)

            Circle()
                .fill(
                    LinearGradient(
                        colors: [Color.purple.opacity(0.7), Color.blue.opacity(0.7)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 220, height: 220)
                .blur(radius: 90)
                .opacity(0.20)
                .offset(x: 120, y: -220)

            Circle()
                .fill(
                    LinearGradient(
                        colors: [Color.cyan.opacity(0.7), Color.blue.opacity(0.6)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 280, height: 280)
                .blur(radius: 100)
                .opacity(0.18)
                .offset(x: 80, y: 260)
        }
        .allowsHitTesting(false)
    }
}

#Preview("Design Components") {
    ZStack {
        AppTheme.background.ignoresSafeArea()
        BlurredBackground().ignoresSafeArea()
        Button("Primary") {}
            .buttonStyle(PrimaryButtonStyle())
    }
}

