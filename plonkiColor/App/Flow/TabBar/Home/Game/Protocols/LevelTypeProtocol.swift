import Foundation

protocol LevelTypeProtocol {
    var rows: Int { get }
    var columns: Int { get }
    var colors: [String] { get }
    var fixedPositions: [[Int]] { get }
}
