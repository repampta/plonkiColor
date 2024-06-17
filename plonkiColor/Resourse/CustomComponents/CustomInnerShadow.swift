import SwiftUI

struct CustomInnerShadow<S: Shape>: ViewModifier {
    var shape: S
    var radius: CGFloat
    var lineWidth: CGFloat
    var yOffset: CGFloat
    var color: Color

    func body(content: Content) -> some View {
        content
            .overlay(
                shape
                    .stroke(lineWidth: lineWidth)
                    .foregroundStyle(color)
                    .blur(radius: radius)
                    .offset(y: yOffset)
                    .clipped()
                    .clipShape(shape)
            )
    }
}

extension View {
    func customInnerShadow<S: Shape>(shape: S, lineWidth: CGFloat, yOffset: CGFloat, radius: CGFloat, color: Color) -> some View {
        self.modifier(CustomInnerShadow(shape: shape, radius: radius, lineWidth: lineWidth, yOffset: yOffset, color: color))
    }
}
