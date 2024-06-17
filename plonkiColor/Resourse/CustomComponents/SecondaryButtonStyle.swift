import Foundation
import SwiftUI

struct SecondaryButtonStyle: ButtonStyle {
    var width: CGFloat = .infinity
    var height: CGFloat = 40
    var color: Color = .cGradTwo
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(color)
                .frame(height: height)
                .customInnerShadow(
                    shape:  RoundedRectangle(cornerRadius: 8),
                    lineWidth: 5,
                    yOffset: 10,
                    radius: 10,
                    color: configuration.isPressed ?
                        .black.opacity(0.4) : .clear
                )
                .shadow(color: .black.opacity(0.6), radius: 8, y: 8)
            configuration.label
        }
        .frame(maxWidth: width)
    }
}

#Preview {
    Button("GO TO HOME") {
        
    }
    .buttonStyle(SecondaryButtonStyle(width: 244))
    .padding()
}
