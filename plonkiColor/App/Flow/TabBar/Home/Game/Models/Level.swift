import Foundation

struct Level: LevelProtocol {
    let id: Int
    var balls: [Ball] = []
    var colors: [String]
    let fixedPositions: [[Int]]
    let columns: Int
    let rows: Int
    var isOpen: Bool
    
    init(level: LevelProtocol) {
        self.id = level.id
        self.colors = level.colors
        self.fixedPositions = level.fixedPositions
        self.columns = level.columns
        self.rows = level.rows
        self.isOpen = level.isOpen
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
        balls.swapAt(first, second)
        checkForCompletion()
    }
    
    mutating func checkForCompletion() {
        let allSatisty = colors.indices.allSatisfy { index  in
            balls[index].color == colors[index]
        }
        
        if allSatisty { print("Game is finished") }
    }
}
