//
//  Memory.swift

import Foundation
class Memory {
    
    static let shared = Memory()
    
    let defaults = UserDefaults.standard
    
    var scoreCoints: Int {
        get {
            return defaults.integer(forKey: "scoreCoints", defaultValue: 1500)
        }
        set {
            defaults.set(newValue, forKey: "scoreCoints")
        }
    }
    
    var levelComleted: Int {
        get {
            return defaults.integer(forKey: "levelComleted", defaultValue: 1)
        }
        set {
            defaults.set(newValue, forKey: "levelComleted")
        }
    }
    
    var chapterComleted: Int {
        get {
            return defaults.integer(forKey: "chapterComleted", defaultValue: 0)
        }
        set {
            defaults.set(newValue, forKey: "chapterComleted")
        }
    }
    
    var lastBonusDate: Date? {
        get {
            return defaults.object(forKey: "lastBonusDate") as? Date
        }
        set {
            defaults.set(newValue, forKey: "lastBonusDate")
        }
    }
    
    var userName: String? {
        get {
            return defaults.string(forKey: "userName")
        }
        set {
            defaults.set(newValue, forKey: "userName")
        }
    }
    
    var userID: Int? {
        get {
            return defaults.object(forKey: "userID") as? Int
        }
        set {
            defaults.set(newValue, forKey: "userID")
        }
    }
    
    var case0ImgTwo: Bool {
        get {
            return defaults.bool(forKey: "case0ImgTwo")
        }
        set {
            defaults.set(newValue, forKey: "case0ImgTwo")
        }
    }
    
    var firstLaunchDate: Date? {
        get {
            return defaults.object(forKey: "firstLaunchDate") as? Date
        }
        set {
            defaults.set(newValue, forKey: "firstLaunchDate")
        }
    }
}

extension UserDefaults {
    func integer(forKey key: String, defaultValue: Int) -> Int {
        return self.object(forKey: key) as? Int ?? defaultValue
    }
}
