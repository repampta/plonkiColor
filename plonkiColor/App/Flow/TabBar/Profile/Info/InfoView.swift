//
//  InfoView.swift



import Foundation
import UIKit
import SnapKit

class InfoView: UIView {
    
    private (set) var bgImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .bgClassic
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private (set) var backBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(.btnBack, for: .normal)
        btn.setImage(.btnBackTapped, for: .highlighted)
        btn.layer.shadowColor = UIColor.black.withAlphaComponent(0.6).cgColor
        btn.layer.shadowOpacity = 1
        btn.layer.shadowRadius = 4
        btn.layer.shadowOffset = CGSize(width: 0, height: 2)
        return btn
    }()
    
    private (set) var titleLabel: UILabel = {
        let label = UILabel.createLabel(withText: "Welcome to \(Settings.appTitle)!", font: .customFont(font: .kleeOne, style: .semiBold, size: 28), textColor: .cLight, lineHeightMultiple: 0.83)
        return label
    }()
    
    private (set) var centerImg: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .centerImg
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var bodyFieldInfo: UITextView = {
        let textView = UITextView()
        let textStyle = NSMutableParagraphStyle()
        textStyle.lineBreakMode = .byWordWrapping
        textStyle.lineHeightMultiple = 1.08

        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.customFont(font: .chivo, style: .regular, size: 14),
            .foregroundColor: UIColor.white,
            .paragraphStyle: textStyle
        ]
        
        let attributedText = NSAttributedString(string: "Dive into the colorful world of balls and puzzles in \"Ball Color!\" Your goal is to arrange the balls to create harmonious color gradients and patterns across various levels and challenges.\nKey Features:\n- Solve Color Puzzles: Use your creativity and logic to solve intricate color puzzles by arranging balls in the right order.\n- Explore 10 Captivating Chapters: Embark on a journey through 10 unique chapters, each offering different challenges and themes to test your skills.\n- Master 100 Levels: Challenge yourself with over 100 levels of increasing difficulty, ranging from simple color harmonies to complex and mesmerizing patterns.\n- Unlock Achievements: Earn achievements as you progress through the game and showcase your mastery of color and design.\n- Enjoy Beautiful Graphics: Immerse yourself in stunning visuals and vibrant colors designed to captivate your senses and inspire your creativity.\n\nHow to Play:\n1. Drag and drop balls onto the grid to create color patterns.\n2. Arrange the balls in the correct order to form smooth color gradients or complete color puzzles.\n3. Progress through chapters and levels to unlock new challenges and achievements.\nGoodLuck!\n", attributes: attributes)
        textView.attributedText = attributedText
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.showsVerticalScrollIndicator = false
        textView.textColor = .white
        textView.textAlignment = .justified
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {

        [bgImage, backBtn, titleLabel, centerImg, bodyFieldInfo] .forEach(addSubview(_:))

    }
    
    private func setupConstraints() {
        
        bgImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        backBtn.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(44)
            make.width.equalTo(75)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(backBtn.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        centerImg.snp.makeConstraints { make in
            make.top.equalTo(backBtn.snp.bottom)
            make.centerX.equalToSuperview()
            make.size.equalTo(244.autoSize)
        }
        
        bodyFieldInfo.snp.makeConstraints { make in
            make.top.equalTo(centerImg.snp.bottom).offset(-36)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
}
