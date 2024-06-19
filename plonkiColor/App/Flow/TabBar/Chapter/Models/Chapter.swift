import Foundation
import UIKit

enum Chapter: String {
    case colorHarmony
    case gradientChallenges
    case colorContours
    case reflectionsAndSymmetry
    case colorPuzzles
    case curvedPerspectives
    case colorWaves
    case colorMosaics
    case colorCascades
    case mastersOfColor
}

extension Chapter: CaseIterable { }

extension Chapter {
    var levels: [Level] {
        switch self {
        case .colorHarmony:
            return ColorHarmonyLevel.allCases.map {
                Level(level: $0, id: $0.rawValue)
            }
        case .gradientChallenges:
            return ColorHarmonyLevel.allCases.map {
                Level(level: $0, id: $0.rawValue)
            }
        default:
            return []
        }
    }
    
    var isOpen: Bool {
        UserDefaults.chaptersAndLevels.keys.contains(self.rawValue)
    }
    
    static var isOpenChapter: Int {
        Chapter.allCases.filter {
            $0.isOpen
        }.count
    }
    
    var isFinished: Bool {
            UserDefaults.finishedChapters.contains(self.rawValue)
        }

    
    static var currentChapter: Chapter {
        UserDefaults.currentChapter
    }
    
    static var currentLevel: Level {
        /// First look for the biggest index in the open levels for the chapter
        /// Return the level with such id from all the levels for the chapter
        let maxLevelInTheChapter = UserDefaults.chaptersAndLevels[currentChapter.rawValue]?.max()
        if let currentLevel = currentChapter.levels.first(where: { $0.id == maxLevelInTheChapter }) {
            return currentLevel
        }
        /// If there is non return the default level of the first chapter
        return Level(level: ColorHarmonyLevel.one, id: ColorHarmonyLevel.one.rawValue)
    }
    
    var titleChapter: String {
        switch self {
        case .colorHarmony:
             "Color Harmony"
        case .gradientChallenges:
            "Gradient Challenges"
        case .colorContours:
            "Color Contours"

        case .reflectionsAndSymmetry:
            "Reflections And Symmetry"

        case .colorPuzzles:
            "Color Puzzles"

        case .curvedPerspectives:
            "Curved Perspectives"

        case .colorWaves:
            "Color Waves"

        case .colorMosaics:
            "Color Mosaics"

        case .colorCascades:
            "Color Cascades"

        case .mastersOfColor:
            "Masters of Color"

        }
    }
    
    var imagesChapters: UIImage {
        switch self  {
            
        case .colorHarmony:
                .imgChapterOne
        case .gradientChallenges:
                .imgChapterTwo
        case .colorContours:
                .imgChapterThree
        case .reflectionsAndSymmetry:
                .imgChapterFour
        case .colorPuzzles:
                .imgChapterFive
        case .curvedPerspectives:
                .imgChapterSix
        case .colorWaves:
                .imgChapterSeven
        case .colorMosaics:
                .imgChapterEight
        case .colorCascades:
                .imgChapterNine
        case .mastersOfColor:
                .imgChapterTen
        }
    }
}
