import Foundation

protocol LevelProtocol {
    var id: Int { get }
    var isOpen: Bool { get }
    var colors: [String] { get }
    var fixedPositions: [[Int]] { get }
    var columns: Int { get }
    var rows: Int { get }
}
