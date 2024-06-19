import Foundation

extension UserDefaults {
    static var currentChapter: Chapter {
        get {
            let chapterName = standard.string(forKey: "currentChapter")
            return Chapter(rawValue: chapterName ?? "") ?? .colorHarmony
        }
        
        set { standard.setValue(newValue.rawValue, forKey: "currentChapter") }
    }
    
    static var chaptersAndLevels: [String: Set<Int>] {
        get {
            if let data = UserDefaults.standard.data(forKey: "chaptersAndLevels"),
               let chaptersAndLevels = try? JSONDecoder().decode([String: Set<Int>].self, from: data) {
                return chaptersAndLevels
            }
            return   [Chapter.colorHarmony.rawValue : [0]]
        }
        
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(data, forKey: "chaptersAndLevels")
            }
        }
    }
    
    static var finishedChapters: Array<String> {
            get { return standard.array(forKey: "finishedChapters") as? [String] ?? [] }
            set { standard.setValue(newValue, forKey: "finishedChapters") }
        }
    
    static func openLevel(id: Int) {
        var chaptersAndLevels = UserDefaults.chaptersAndLevels
        chaptersAndLevels[currentChapter.rawValue]?.insert(id)
        UserDefaults.chaptersAndLevels = chaptersAndLevels
    }
}
