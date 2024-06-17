import Foundation

class LevelViewModel: ObservableObject {
    @Published var level: Level
    
    var isFinished: Bool { level.isFinished }
    var balls: [Ball] { level.balls }
    var vGridColumns: Int { return level.columns }
    
    init(level: Level) {
        self.level = level
    }
    
    func changeBalls(first: Int, second: Int) {
        level.changeBalls(first: first, second: second)
        level.checkForCompletion()
        if isFinished { openNextLevel() }
    }
    
    func createGame() {
        level.generateBalls()
    }
    
    func restartGame() {
        level.generateBalls()
    }
    
    func nextLevel() {
        let levels = UserDefaults.currentChapter.levels
        if let indexOfCurrentLevel = levels.firstIndex(where: { $0.id == level.id }) {
            if levels.indices.contains(indexOfCurrentLevel + 1) {
                self.level = levels[indexOfCurrentLevel + 1]
            }
        }
        createGame()
    }
    
    private func openNextLevel() {
        let currentChapter = UserDefaults.currentChapter
        let levels = UserDefaults.currentChapter.levels
        
        if let indexOfCurrentLevel = levels.firstIndex(where: { $0.id == level.id }) {
            if levels.indices.contains(indexOfCurrentLevel + 1) {
                UserDefaults.chaptersAndLevels[currentChapter.rawValue]?.insert(indexOfCurrentLevel + 1)
            } else {
                openNewChapter()
            }
        }
    }
    
    private func openNewChapter() {
        let currentChapter = UserDefaults.currentChapter
        let allChapters = Chapter.allCases
        
        if let currentChapterIndex = allChapters.firstIndex(where: { $0 == currentChapter }) {
            if allChapters.indices.contains(currentChapterIndex + 1) {
                let nextChapter = allChapters[currentChapterIndex + 1]
                UserDefaults.chaptersAndLevels[nextChapter.rawValue] = [0]
            }
        }
    }
}


