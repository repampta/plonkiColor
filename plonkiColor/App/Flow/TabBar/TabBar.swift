
import UIKit

final class TabBar: UITabBarController {
    
    private let profile = ProfileVC()
    private let rating = RatingVC()
    private let home = HomeVC()
    private let bonus = BonusVC()
    private let chapter = ChapterVC()
    
    private lazy var btn1 = getButton(icon: "btnProfile", selectedIcon: "btnProfileTapped", tag: 0, action: action)
    private lazy var btn2 = getButton(icon: "btnRating", selectedIcon: "btnRatingTapped", tag: 1, action: action)
    private lazy var btn3 = getButton(icon: "btnHome", selectedIcon: "btnHomeTapped", tag: 2, action: action)
    private lazy var btn4 = getButton(icon: "btnBonus", selectedIcon: "btnBonusTapped", tag: 3, action: action)
    private lazy var btn5 = getButton(icon: "btnChapter", selectedIcon: "btnChapterTapped", tag: 4, action: action)

    lazy var action = UIAction { [weak self] sender in
        guard
            let sender = sender.sender as? UIButton,
            let self = self
        else { return }
        
        self.updateSelectedButton(sender.tag)
        self.selectedIndex = sender.tag
    }

    private lazy var customBar: UIStackView = {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.alignment = .center
        $0.backgroundColor = .cDarkPurple
        $0.frame = CGRect(x: 0, y: view.frame.height - 90, width: view.frame.width, height: 90)
        $0.addArrangedSubview(btn1)
        $0.addArrangedSubview(btn2)
        $0.addArrangedSubview(btn3)
        $0.addArrangedSubview(btn4)
        $0.addArrangedSubview(btn5)
        return $0
    }(UIStackView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().backgroundColor = .cDarkPurple

        profile.title = "Profile"
        rating.title = "Rating"
        home.title = "Home"
        bonus.title = "Bonus"
        chapter.title = "Chapter"
        view.addSubview(customBar)
        tabBar.isHidden = true
        setViewControllers([profile, rating ,home, bonus, chapter], animated: true)
        selectedViewController = home
        updateSelectedButton(2)  // Set initial selection
    }
    
    private func getButton(icon: String, selectedIcon: String, tag: Int, action: UIAction) -> UIButton {
        return {
            let image = UIImage(named: icon)?.withRenderingMode(.alwaysOriginal)
            $0.setImage(image, for: .normal)
            $0.tag = tag
            $0.accessibilityIdentifier = icon
            $0.accessibilityHint = selectedIcon
            $0.layer.shadowColor = UIColor.black.withAlphaComponent(0.6).cgColor
            $0.layer.shadowOpacity = 1
            $0.layer.shadowRadius = 12
            $0.layer.shadowOffset = CGSize(width: 0, height: -14)
            return $0
        }(UIButton(primaryAction: action))
    }
    
    private func updateSelectedButton(_ selectedIndex: Int) {
        let buttons = [btn1, btn2, btn3, btn4, btn5]
        
        for (index, button) in buttons.enumerated() {
            let icon = button.accessibilityIdentifier ?? ""
            let selectedIcon = button.accessibilityHint ?? ""
            
            if icon.isEmpty || selectedIcon.isEmpty {
                print("Icon or selectedIcon is empty for button at index \(index)")
                continue
            }
            
            if index == selectedIndex {
                let selectedImage = UIImage(named: selectedIcon)?.withRenderingMode(.alwaysOriginal)
                button.setImage(selectedImage, for: .normal)
            } else {
                let image = UIImage(named: icon)?.withRenderingMode(.alwaysOriginal)
                button.setImage(image, for: .normal)
            }
        }
    }
    
    func selectTab(at index: Int) {
        guard let button = customBar.arrangedSubviews.first(where: { ($0 as? UIButton)?.tag == index }) as? UIButton else { return }
        button.sendActions(for: .touchUpInside)
    }
}

