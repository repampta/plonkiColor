import SwiftUI

struct BallView: View {
    var ball: Ball
    
    var body: some View {
        Circle()
            .fill(Color(hex: ball.color))
            .overlay {
                if ball.isFixed {
                    Circle()
                        .fill(.black)
                        .frame(width: 5, height: 5)
                }
            }
            .frame(width: 44, height: 44)
    }
}
