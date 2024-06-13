import Foundation

struct Ball {
    var id = UUID().uuidString
    let color: String
    let isFixed: Bool
}

extension Ball: Identifiable { }
