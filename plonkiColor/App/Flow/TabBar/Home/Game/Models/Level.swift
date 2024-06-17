import Foundation

struct Level {
    let id: Int
    var balls: [Ball] = []
    var colors: [String]
    let fixedPositions: [[Int]]
    let columns: Int
    let rows: Int
    var isFinished = false
    
    var isOpen: Bool {
        get {
            let currentChapter = UserDefaults.currentChapter
            return (UserDefaults.chaptersAndLevels[currentChapter.rawValue] ?? []).contains(id)
        }
    }
    
    init(level: LevelTypeProtocol, id: Int) {
        self.id = id
        self.colors = level.colors
        self.fixedPositions = level.fixedPositions
        self.columns = level.columns
        self.rows = level.rows
    }
    
    init(
        id: Int,
        colors: [String],
        fixedPositions: [[Int]],
        columns: Int,
        rows: Int
    ) {
        self.id = id
        self.colors = colors
        self.fixedPositions = fixedPositions
        self.columns = columns
        self.rows = rows
    }
    
    mutating func generateBalls() {
        let fixedIndicies = fixedPositions.map { point in
            point[1] + columns * point[0]
        }
        
        var orderedBalls = colors.enumerated().map { index, color in
            Ball(color: color, isFixed: fixedIndicies.contains(index))
        }
        
        let nonFixedIndicies = orderedBalls.enumerated().compactMap {
            if !$1.isFixed { return $0 }
            return nil
        }
        
        var nonFixedBalls = orderedBalls.filter { !$0.isFixed }.shuffled()
        
        nonFixedIndicies.forEach {
            if let poppedBall = nonFixedBalls.popLast() {
                orderedBalls[$0] = poppedBall
            }
        }
        
        self.balls = orderedBalls
    }
    
    mutating func changeBalls(first: Int, second: Int) {
        if !balls[first].isFixed && !balls[second].isFixed {
            balls.swapAt(first, second)
        }
    }
    
    mutating func checkForCompletion() {
        let allSatisty = colors.indices.allSatisfy { index  in
            balls[index].color == colors[index]
        }
        
        if allSatisty { isFinished = true }
    }
}
