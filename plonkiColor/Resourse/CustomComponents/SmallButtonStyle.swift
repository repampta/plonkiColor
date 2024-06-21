import Foundation
import SwiftUI

struct SmallButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .blending(color: configuration.isPressed ? .cGradTwo : .white)
            .fixedSize()
            .shadow(color: .black.opacity(0.6), radius: 2, y: 2)
    }
}

extension View {
    func smallButtonStyle() -> some View {
        buttonStyle(SmallButtonStyle())
    }
}
