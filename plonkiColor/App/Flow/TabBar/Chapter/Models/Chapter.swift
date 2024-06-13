import Foundation

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

extension Chapter {
    var levels: [LevelProtocol] {
        switch self {
        case .colorHarmony:
            return ColorHarmonyLevel.allCases
        default:
            return []
        }
    }
    
    var isOpen: Bool {
        UserDefaults.chaptersAndLevels.keys.contains(self.rawValue)
    }
}
