
import UIKit

class TabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        UITabBar.appearance().unselectedItemTintColor = .white.withAlphaComponent(0.5)
        UITabBar.appearance().tintColor = .white
        
        // Убираем фоновый цвет, чтобы градиент был виден
        UITabBar.appearance().backgroundColor = .clear
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()

        addGradientToTabBar()

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

    private func addGradientToTabBar() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = tabBar.bounds
        gradientLayer.colors = [UIColor.cGradOne.cgColor, UIColor.cGradTwo.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)

        if let image = getImageFrom(gradientLayer) {
            let gradientImageView = UIImageView(image: image)
            gradientImageView.frame = tabBar.bounds
            gradientImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            tabBar.insertSubview(gradientImageView, at: 0)
        }
    }

    private func getImageFrom(_ gradientLayer: CAGradientLayer) -> UIImage? {
        UIGraphicsBeginImageContext(gradientLayer.frame.size)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        gradientLayer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
