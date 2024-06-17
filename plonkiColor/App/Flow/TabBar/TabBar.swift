
import UIKit

class TabBar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().backgroundColor = .cDarkPurple

        let profile = ProfileVC()
        buildConfig(profile, imageName: "btnProfile", selectedImageName: "btnProfileTapped")
        
        let rating = RatingVC()
        buildConfig(rating, imageName: "btnRating", selectedImageName: "btnRatingTapped")

        let home = HomeVC()
        buildConfig(home, imageName: "btnHome", selectedImageName: "btnHomeTapped")

        let bonus = BonusVC()
        buildConfig(bonus, imageName: "btnBonus", selectedImageName: "btnBonusTapped")

        let chapter = ChapterVC()
        buildConfig(chapter, imageName: "btnChapter", selectedImageName: "btnChapterTapped")

        viewControllers = [profile, rating, home, bonus, chapter]
        selectedViewController = home

    }
    
    private func buildConfig(_ vc: UIViewController, imageName: String, selectedImageName: String) {
        let originalImage = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        let selectedImage = UIImage(named: selectedImageName)?.withRenderingMode(.alwaysOriginal)
        
        let screenHeight = UIScreen.main.bounds.height
        let imageInset: UIEdgeInsets
        
        if screenHeight < 852 {
            imageInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        } else {
            imageInset = UIEdgeInsets(top: 0, left: 0, bottom: -14, right: -2)
        }

        originalImage?.imageFlippedForRightToLeftLayoutDirection()
        selectedImage?.imageFlippedForRightToLeftLayoutDirection()
        vc.tabBarItem.imageInsets = imageInset
        
        vc.tabBarItem.image = originalImage
        vc.tabBarItem.selectedImage = selectedImage
    }
}
