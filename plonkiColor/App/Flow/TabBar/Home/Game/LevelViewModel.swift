import Foundation

class LevelViewModel: ObservableObject {
    @Published var level: Level
    
    var balls: [Ball] {
        level.balls
    }
    
    var vGridColumns: Int {
        return level.columns
    }
    
    init(levelType: LevelProtocol) {
        self.level = Level(level: levelType)
    }
    
    func changeBalls(first: Int, second: Int) {
        level.changeBalls(first: first, second: second)
    }
    
    func createGame() {
        level.generateBalls()
    }
}


