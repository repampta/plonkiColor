//
//  TabBar.swift


import UIKit

class TabBar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().unselectedItemTintColor = .white.withAlphaComponent(0.5)
        UITabBar.appearance().tintColor = .white
        UITabBar.appearance().backgroundColor = .black
        
        let profileVC = ProfileVC()
        buildConfig(profileVC, title: "Profile", imageName: "btnProfile")

        let ratingVC = RatingVC()
        buildConfig(ratingVC, title: "Rating", imageName: "btnInfo")

        let homeVC = HomeVC()
        buildConfig(homeVC, title: "Home", imageName: "btnHome")
                         
        let bonusVC = BonusVC()
        buildConfig(bonusVC, title: "Bonus", imageName: "btnBonus")
        
        let chapterVC = ChapterVC()
        buildConfig(chapterVC, title: "Chapter", imageName: "btnHome")
        
        viewControllers = [profileVC, ratingVC, homeVC, bonusVC, chapterVC]
        selectedViewController = homeVC
    }

    private func buildConfig(_ vc: UIViewController, title: String, imageName: String) {
        vc.tabBarItem.title = title
        vc.tabBarItem.image = UIImage(named: imageName)
        vc.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0)
    }
}


