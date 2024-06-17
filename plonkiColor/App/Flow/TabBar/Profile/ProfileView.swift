//
//  ProfileView.swift

import Foundation
import UIKit
import SnapKit

class ProfileView: UIView, UITextFieldDelegate {
    
    private (set) var bgImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .bgClassic
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private (set) var infoBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(.btnInfo, for: .normal)
        btn.setImage(.btnInfoTapped, for: .highlighted)
        btn.layer.shadowColor = UIColor.black.withAlphaComponent(0.6).cgColor
        btn.layer.shadowOpacity = 1
        btn.layer.shadowRadius = 4
        btn.layer.shadowOffset = CGSize(width: 0, height: 2)
        return btn
    }()
    
    private (set) var writeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(.btnWriteUs, for: .normal)
        btn.setImage(.btnWriteUsTapped, for: .highlighted)
        btn.layer.shadowColor = UIColor.black.withAlphaComponent(0.6).cgColor
        btn.layer.shadowOpacity = 1
        btn.layer.shadowRadius = 4
        btn.layer.shadowOffset = CGSize(width: 0, height: 2)
        return btn
    }()
    
    private (set) var rateBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(.btnRateUs, for: .normal)
        btn.setImage(.btnRateUsTapped, for: .highlighted)
        btn.layer.shadowColor = UIColor.black.withAlphaComponent(0.6).cgColor
        btn.layer.shadowOpacity = 1
        btn.layer.shadowRadius = 4
        btn.layer.shadowOffset = CGSize(width: 0, height: 2)
        return btn
    }()
    
    private (set) var titleLabel: UILabel = {
        let label = UILabel.createLabel(withText: "Profile", font: .customFont(font: .kleeOne, style: .semiBold, size: 36), textColor: .cGradOne, lineHeightMultiple: 0.83)
        return label
    }()
    
    private(set) lazy var subProfileView: UIView = {
        let view = UIView()
        view.backgroundColor = .cGradTwo
        return view
    }()
    
    private(set) lazy var chosePhotoBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(.btnCheckPhoto, for: .normal)
        button.layer.cornerRadius = 20
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 12
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.clipsToBounds = true
        return button
    }()
    
    private(set) lazy var profileTextField: UITextField = {
        let textField = UITextField()
        let font = UIFont.customFont(font: .kleeOne, style: .semiBold, size: 24)
        
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.cDarkPurple
        ]
        
        let placeholderText = NSAttributedString(string: "User Name", attributes: placeholderAttributes)
        textField.attributedPlaceholder = placeholderText
        
        if let savedUserName = Memory.shared.userID {
            textField.placeholder = "user#\(savedUserName)"
        }
        
        let textAttributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.cDarkPurple,
        ]
        textField.font = UIFont.customFont(font: .kleeOne, style: .semiBold, size: 24)
        textField.textColor = .cDarkPurple
        textField.backgroundColor = .clear
        textField.textAlignment = .left
        textField.delegate = self
        textField.returnKeyType = .done
        return textField
    }()
    
    private(set) var inGameLabel: UILabel = {
        let label = UILabel.createLabel(withText: "In game since", font: .customFont(font: .chivo, style: .regular, size: 14), textColor: .white, lineHeightMultiple: 1)
        return label
    }()
    
    
    private (set) var imgCalendar: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .imgCalendar
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private (set) var dateLabel: UILabel = {
        let label = UILabel.createLabel(withText: "20.07.1992", font: .customFont(font: .chivo, style: .regular, size: 14), textColor: .white, lineHeightMultiple: 1)
        return label
    }()
    
    private(set) lazy var editBtn: UIButton = {
        let button = UIButton()
        button.configureButton(withTitle: "EDIT", font: .customFont(font: .kleeOne, style: .semiBold, size: 16), titleColor: .cDarkPurple, normalImage: .btnYellow, highlightedImage: .btnYellowTapped, kern: 0.64)
        button.layer.shadowColor = UIColor.black.withAlphaComponent(0.6).cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 8
        button.layer.shadowOffset = CGSize(width: 0, height: 8)
        return button
    }()
    
    private(set) var analyticsLabel: UILabel = {
        let label = UILabel.createLabel(withText: "Analytics", font: .customFont(font: .kleeOne, style: .semiBold, size: 24), textColor: .cLight, lineHeightMultiple: 0.83)
        return label
    }()
    
    private(set) lazy var analyticsView: UIView = {
        let view = UIView()
        view.backgroundColor = .cBlue.withAlphaComponent(0.4)
        return view
    }()
    
    private (set) var imgLevel: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .imgLevelsCompleted
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private(set) var levelLabel: UILabel = {
        let label = UILabel.createLabel(withText: "Number of levels\ncompleted", font: .customFont(font: .chivo, style: .regular, size: 16), textColor: .cLight, lineHeightMultiple: 1)
        label.textAlignment = .center
        return label
    }()
    
    private (set) var imgContainerLevel: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .imgContainerCount
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private(set) var countCompletedLevelsLabel: UILabel = {
        let label = UILabel.createLabel(withText: "0", font: .customFont(font: .chivo, style: .regular, size: 16), textColor: .cLight, lineHeightMultiple: 1)
        return label
    }()
    
    private(set) var achiLabel: UILabel = {
        let label = UILabel.createLabel(withText: "Achievements", font: .customFont(font: .kleeOne, style: .semiBold, size: 24), textColor: .cLight, lineHeightMultiple: 0.83)
        return label
    }()
    
    private (set) var imgChapter: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .imgChapterOpened
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private(set) var chapterLabel: UILabel = {
        let label = UILabel.createLabel(withText: "Number of \nchapters opened", font: .customFont(font: .chivo, style: .regular, size: 16), textColor: .cLight, lineHeightMultiple: 1)
        label.textAlignment = .center
        return label
    }()
    
    private (set) var imgContainerChapter: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .imgContainerCount
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private(set) var countCompletedChapterLabel: UILabel = {
        let label = UILabel.createLabel(withText: "0", font: .customFont(font: .chivo, style: .regular, size: 16), textColor: .cLight, lineHeightMultiple: 1)
        return label
    }()
    
    private(set) lazy var achievementsView: UIView = {
        let view = UIView()
        view.backgroundColor = .cBlue.withAlphaComponent(0.4)
        return view
    }()
    
    private(set) lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private(set) lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .center
        return stackView
    }()
    
    private(set) lazy var achiOneView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private (set) var achiOneImg: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .imgAchiOne
        imageView.contentMode = .scaleAspectFill
        imageView.layer.shadowColor = UIColor.yellow.withAlphaComponent(0.6).cgColor
        imageView.layer.shadowOpacity = 1
        imageView.layer.shadowRadius = 24
        imageView.layer.shadowOffset = CGSize(width: 0, height: 0)
        return imageView
    }()
    
    private(set) var achiOneLabel: UILabel = {
        let label = UILabel.createLabel(withText: "Color\nNovice", font: .customFont(font: .chivo, style: .regular, size: 16), textColor: .cLight, lineHeightMultiple: 1)
        label.textAlignment = .center
        return label
    }()
    
    private(set) lazy var achiTwoView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private (set) var achiTwoImg: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .imgAchiTwo
        imageView.contentMode = .scaleAspectFill
        imageView.layer.shadowColor = UIColor.yellow.withAlphaComponent(0.6).cgColor
        imageView.layer.shadowOpacity = 1
        imageView.layer.shadowRadius = 24
        imageView.layer.shadowOffset = CGSize(width: 0, height: 0)
        return imageView
    }()
    
    private(set) var achiTwoLabel: UILabel = {
        let label = UILabel.createLabel(withText: "Pattern\nExplorer", font: .customFont(font: .chivo, style: .regular, size: 16), textColor: .cLight, lineHeightMultiple: 1)
        label.textAlignment = .center
        return label
    }()
    
    private(set) lazy var achiThreeView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private (set) var achiThreeImg: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .imgAchiThree
        imageView.contentMode = .scaleAspectFill
        imageView.layer.shadowColor = UIColor.yellow.withAlphaComponent(0.6).cgColor
        imageView.layer.shadowOpacity = 1
        imageView.layer.shadowRadius = 24
        imageView.layer.shadowOffset = CGSize(width: 0, height: 0)
        return imageView
    }()
    
    private(set) var achiThreeLabel: UILabel = {
        let label = UILabel.createLabel(withText: "Color\nApprentice", font: .customFont(font: .chivo, style: .regular, size: 16), textColor: .cLight, lineHeightMultiple: 1)
        label.textAlignment = .center
        return label
    }()
    
    private(set) lazy var achiFourView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private (set) var achiFourImg: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .imgAchiFour
        imageView.contentMode = .scaleAspectFill
        imageView.layer.shadowColor = UIColor.yellow.withAlphaComponent(0.6).cgColor
        imageView.layer.shadowOpacity = 1
        imageView.layer.shadowRadius = 24
        imageView.layer.shadowOffset = CGSize(width: 0, height: 0)
        return imageView
    }()
    
    private(set) var achiFourLabel: UILabel = {
        let label = UILabel.createLabel(withText: "Harmonious\nMastery", font: .customFont(font: .chivo, style: .regular, size: 16), textColor: .cLight, lineHeightMultiple: 1)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        saveName()
        displayFirstLaunchDate()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(bgImage)
        addSubview(infoBtn)
        addSubview(rateBtn)
        addSubview(writeBtn)
        addSubview(titleLabel)
        addSubview(subProfileView)
        addSubview(chosePhotoBtn)
        addSubview(profileTextField)
        addSubview(inGameLabel)
        addSubview(imgCalendar)
        addSubview(dateLabel)
        addSubview(editBtn)
        addSubview(scrollView)
        
        scrollView.addSubview(contentStackView)
        
        contentStackView.addArrangedSubview(analyticsLabel)
        contentStackView.addArrangedSubview(analyticsView)
        contentStackView.addArrangedSubview(achiLabel)
        contentStackView.addArrangedSubview(achievementsView)
        
        analyticsView.addSubview(imgContainerLevel)
        analyticsView.addSubview(levelLabel)
        analyticsView.addSubview(imgLevel)
        imgContainerLevel.addSubview(countCompletedLevelsLabel)
        
        analyticsView.addSubview(imgContainerChapter)
        analyticsView.addSubview(chapterLabel)
        analyticsView.addSubview(imgChapter)
        imgContainerChapter.addSubview(countCompletedChapterLabel)
        
        achievementsView.addSubview(achiOneView)
        achievementsView.addSubview(achiTwoView)
        achievementsView.addSubview(achiThreeView)
        achievementsView.addSubview(achiFourView)
        
        achiOneView.addSubview(achiOneImg)
        achiOneView.addSubview(achiOneLabel)
        
        achiTwoView.addSubview(achiTwoImg)
        achiTwoView.addSubview(achiTwoLabel)
        
        achiThreeView.addSubview(achiThreeImg)
        achiThreeView.addSubview(achiThreeLabel)
        
        achiFourView.addSubview(achiFourImg)
        achiFourView.addSubview(achiFourLabel)
    }
    
    private func setupConstraints() {
        
        bgImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        infoBtn.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(24)
            make.right.equalToSuperview().offset(-16)
            make.size.equalTo(44)
        }
        
        rateBtn.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(24)
            make.left.equalToSuperview().offset(16)
            make.size.equalTo(44)
        }
        
        writeBtn.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(24)
            make.left.equalTo(rateBtn.snp.right).offset(10)
            make.size.equalTo(44)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(writeBtn.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        subProfileView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
            make.height.equalTo(176.autoSize)
        }
        
        chosePhotoBtn.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(16)
            make.size.equalTo(136)
        }
        
        profileTextField.snp.makeConstraints { make in
            make.top.equalTo(chosePhotoBtn.snp.top)
            make.left.equalTo(chosePhotoBtn.snp.right).offset(20)
            make.width.equalTo(200)
        }
        
        inGameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileTextField.snp.bottom).offset(8)
            make.left.equalTo(chosePhotoBtn.snp.right).offset(20)
        }
        
        imgCalendar.snp.makeConstraints { make in
            make.top.equalTo(inGameLabel.snp.bottom).offset(2)
            make.left.equalTo(chosePhotoBtn.snp.right).offset(20)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(imgCalendar)
            make.left.equalTo(imgCalendar.snp.right).offset(4)
        }
        
        editBtn.snp.makeConstraints { make in
            make.top.equalTo(imgCalendar.snp.bottom).offset(16)
            make.left.equalTo(chosePhotoBtn.snp.right).offset(20)
            make.height.equalTo(40.autoSize)
            make.width.equalTo(126.autoSize)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(subProfileView.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        contentStackView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
        
        analyticsLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
        }
        
        analyticsView.snp.makeConstraints { make in
            make.height.equalTo(150.autoSize)
            make.left.right.equalToSuperview()
        }
        
        imgContainerLevel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-12)
            make.right.equalTo(analyticsView.snp.centerX).offset(-20)
            make.width.equalTo(140.autoSize)
            make.height.equalTo(27.autoSize)
        }
        
        imgLevel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.centerX.equalTo(imgContainerLevel)
        }
        
        levelLabel.snp.makeConstraints { make in
            make.top.equalTo(imgLevel.snp.bottom).offset(8)
            make.centerX.equalTo(imgContainerLevel)
        }
        
        countCompletedLevelsLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        achiLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
        }
        
        imgContainerChapter.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-12)
            make.left.equalTo(analyticsView.snp.centerX).offset(20)
            make.width.equalTo(140.autoSize)
            make.height.equalTo(27.autoSize)
        }
        
        imgChapter.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.centerX.equalTo(imgContainerChapter)
        }
        
        chapterLabel.snp.makeConstraints { make in
            make.top.equalTo(imgChapter.snp.bottom).offset(8)
            make.centerX.equalTo(imgContainerChapter)
        }
        
        countCompletedChapterLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        achievementsView.snp.makeConstraints { make in
            make.height.equalTo(250.autoSize)
            make.left.right.equalToSuperview()
        }
        
        achiOneView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.right.equalTo(achievementsView.snp.centerX).offset(-20)
            make.height.equalTo(106.autoSize)
            make.width.equalTo(100.autoSize)
        }
        
        achiOneImg.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        achiOneLabel.snp.makeConstraints { make in
            make.top.equalTo(achiOneImg.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        achiTwoView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.equalTo(achievementsView.snp.centerX).offset(20)
            make.height.equalTo(106.autoSize)
            make.width.equalTo(100.autoSize)
        }
        
        achiTwoImg.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        achiTwoLabel.snp.makeConstraints { make in
            make.top.equalTo(achiTwoImg.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        achiThreeView.snp.makeConstraints { make in
            make.top.equalTo(achiOneView.snp.bottom).offset(12)
            make.right.equalTo(achievementsView.snp.centerX).offset(-20)
            make.height.equalTo(106.autoSize)
            make.width.equalTo(100.autoSize)
        }
        
        achiThreeImg.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        achiThreeLabel.snp.makeConstraints { make in
            make.top.equalTo(achiThreeImg.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        achiFourView.snp.makeConstraints { make in
            make.top.equalTo(achiTwoView.snp.bottom).offset(12)
            make.left.equalTo(achievementsView.snp.centerX).offset(20)
            make.height.equalTo(106.autoSize)
            make.width.equalTo(100.autoSize)
        }
        
        achiFourImg.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        achiFourLabel.snp.makeConstraints { make in
            make.top.equalTo(achiFourImg.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
    }
    
    private func saveName() {
        if let savedUserName = Memory.shared.userName {
            profileTextField.text = savedUserName
        }
    }
    
    private func displayFirstLaunchDate() {
        if let firstLaunchDate = Memory.shared.firstLaunchDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            dateLabel.text = dateFormatter.string(from: firstLaunchDate)
        }
    }
    
    internal func textFieldDidEndEditing(_ textField: UITextField) {
        Memory.shared.userName = textField.text
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
