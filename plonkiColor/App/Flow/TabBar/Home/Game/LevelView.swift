import SwiftUI

struct LevelView: View {
    @StateObject private var levelViewModel: LevelViewModel
    
    @State private var chosenBalls: [Int] = []
    
    var gridItems: [GridItem] {
        (1...levelViewModel.vGridColumns).map { _ in
            GridItem(.fixed(44), spacing: 1)
        }
    }
    
    init(levelType: LevelProtocol) {
        let levelViewModel = LevelViewModel(levelType: levelType)
        self._levelViewModel = StateObject(wrappedValue: levelViewModel)
    }

    var body: some View {
        VStack {
            LazyVGrid(columns: gridItems, spacing: 1) {
                ForEach(Array(levelViewModel.balls.enumerated()), id: \.0) { index, ball in
                    BallView(ball: ball)
                        .onTapGesture {
                            if !ball.isFixed {
                                selectBall(index: index)
                            }
                        }
                }
            }
        }
        .onAppear { levelViewModel.createGame() }
        
    }
    
    private func selectBall(index: Int) {
        if !chosenBalls.contains(index) {
            chosenBalls.append(index)
        }
        
        if chosenBalls.count == 2 {
            withAnimation() {
                levelViewModel.changeBalls(first: chosenBalls[0], second: chosenBalls[1])
            }
            chosenBalls = []
        }
    }
}

#Preview {
    LevelView(levelType: ColorHarmonyLevel.eight)
}
