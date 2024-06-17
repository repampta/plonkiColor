import SwiftUI
import UniformTypeIdentifiers

struct LevelView: View {
    @Environment(\.safeAreaInsets) private var safeArea
    @Environment(\.dismiss) private var dismiss
    
    @StateObject private var levelViewModel: LevelViewModel
    
    @State private var chosenBalls: [Int] = []
    @State private var isShowingWinModalView = false
    @State private var dragging: Ball?
    @State private var isShwoingDragging = false
    
    var gridItems: [GridItem] {
        (1...levelViewModel.vGridColumns).map { _ in
            GridItem(.fixed(44), spacing: 1)
        }
    }
    
    init(viewModel: LevelViewModel) {
        self._levelViewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack {
            navBar
            LazyVGrid(columns: gridItems, spacing: 1) {
                ForEach(Array(levelViewModel.balls.enumerated()), id: \.0) {
                    index,
                    ball in
                    BallView(ball: ball)
                        .opacity(dragging?.id == ball.id
                                 && isShwoingDragging == true ? 0.01 : 1
                        )
                        .contentShape(.dragPreview, Circle())
                        .onDrag {
                            self.dragging = ball
                            return NSItemProvider(object: ball.id as NSString)
                        }
                        .onDrop(
                            of: [UTType.text],
                            delegate: DragRelocateDelegate(
                                listData: $levelViewModel.level.balls,
                                current: $dragging,
                                isDragging: $isShwoingDragging,
                                item: ball
                            ) { from, to in
                                levelViewModel.changeBalls(first: from, second: to)
                            }
                        )
                }
            }
            .frame(maxHeight: .infinity, alignment: .center)
        }
        .background(.white)
        .ignoresSafeArea(edges: .top)
        .frame(maxHeight: .infinity, alignment: .top)
        .onAppear { levelViewModel.createGame() }
        .onChange(of: levelViewModel.isFinished) { isFinished in
            if isFinished { showModalWinView() }
        }
        .modalViewDim { hideModelWinView() }
        .modalView(isShowingModalView: $isShowingWinModalView) {
            GameWinModalView()
                .goHome {
                    hideModelWinView()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                        dismiss()
                    }
                }
                .next {
                    withAnimation { levelViewModel.nextLevel() }
                    hideModelWinView()
                }
        }
    }
    
    private var navBar: some View {
        HStack {
            Image(.gameBack)
                .onTapGesture { dismiss() }
            Spacer()
            Image(.gameRestart)
                .onTapGesture { restartGame() }
            Spacer()
            Image(.gameRules)
        }
        .shadow(color: .black.opacity(0.6), radius: 4, y: 2)
        .padding(.horizontal, 20)
        .padding(.bottom, 24)
        .padding(.top, safeArea.top)
        .background {
            Color.darkPurple
                .shadow(color: .black.opacity(0.6), radius: 12, y: 4)
        }
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
    
    private func restartGame() {
        withAnimation {
            levelViewModel.restartGame()
        }
    }
    
    private func nexLevel() {
        withAnimation {
            levelViewModel.nextLevel()
        }
    }
    
    private func showModalWinView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation(.linear(duration: 0.3)) {
                isShowingWinModalView = true
            }
        }
    }
    
    private func hideModelWinView() {
        withAnimation(.linear(duration: 0.3)) {
            isShowingWinModalView = false
        }
    }
}

#Preview {
    LevelView(viewModel: LevelViewModel(level: Level(
        level: ColorHarmonyLevel.eight,
        id: ColorHarmonyLevel.eight.rawValue
    )))
}
