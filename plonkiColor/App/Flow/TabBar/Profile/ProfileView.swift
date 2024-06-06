//
//  ProfileView.swift

import Foundation
import UIKit
import SnapKit

class ProfileView: UIView, UITextFieldDelegate {
    
    private (set) var bgImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .bgHome
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private (set) var infoBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .blue
        btn.layer.cornerRadius = 22
        btn.setTitle("I", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()

    private (set) var writeBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .red
        btn.layer.cornerRadius = 22
        btn.setTitle("W", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    
    private (set) var rateBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .gray
        btn.layer.cornerRadius = 22
        btn.setTitle("R", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    
    private (set) var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Profile"
        label.textColor = .white
        label.font = .systemFont(ofSize: 24)
        return label
    }()
    
    private(set) lazy var profileTextField: UITextField = {
        let textField = UITextField()
        let font = UIFont.systemFont(ofSize: 24)
        let fontSize = CGFloat(32)
        
        // Атрибуты для placeholder
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.white.withAlphaComponent(0.5),
            .kern: fontSize * 0.02
        ]
        
        let placeholderText = NSAttributedString(string: "User Name", attributes: placeholderAttributes)
        textField.attributedPlaceholder = placeholderText

        if let savedUserName = Memory.shared.userID {
            textField.placeholder = "user#\(savedUserName)"
        }
        
        let textAttributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.white,
            .kern: fontSize * 0.04
        ]
        textField.font = UIFont.systemFont(ofSize: 24)
        textField.textColor = .white
        textField.backgroundColor = .clear
        textField.textAlignment = .left
        textField.delegate = self
        textField.returnKeyType = .done
        return textField
    }()
    
    private(set) lazy var chosePhotoBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(.imgUserDefolt, for: .normal)
        button.layer.cornerRadius = 60
        button.clipsToBounds = true
        return button
    }()
    
    private(set) lazy var editBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(.editBtn, for: .normal)
        return button
    }()
    
    private(set) var subTitleLabel: UILabel = {
        let label = UILabel()
        let text = "Analytics"
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 18),
            .foregroundColor: UIColor.red,
            .kern: 2.88,  // Добавление кернинга
            .paragraphStyle: {
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.paragraphSpacing = 0
                paragraphStyle.lineHeightMultiple = 0.83
                return paragraphStyle
            }()
        ]
        label.attributedText = NSAttributedString(string: text, attributes: attributes)
        return label
    }()
    
    private(set) var achiLabel: UILabel = {
        let label = UILabel()
        let text = "Achievements"
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 18),
            .foregroundColor: UIColor.red,
            .kern: 2.88,  // Добавление кернинга
            .paragraphStyle: {
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.paragraphSpacing = 0
                paragraphStyle.lineHeightMultiple = 0.83
                return paragraphStyle
            }()
        ]
        label.attributedText = NSAttributedString(string: text, attributes: attributes)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        saveName()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {

        [bgImage, infoBtn, rateBtn, writeBtn, titleLabel, chosePhotoBtn, profileTextField, editBtn, subTitleLabel, achiLabel] .forEach(addSubview(_:))

    }
    
    private func setupConstraints() {
        
        bgImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        infoBtn.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(24)
            make.right.equalToSuperview().offset(-10)
            make.size.equalTo(44)
        }
        
        rateBtn.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(24)
            make.left.equalToSuperview().offset(10)
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
        
        chosePhotoBtn.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20.autoSize)
            make.left.equalToSuperview().offset(20.autoSize)
            make.size.equalTo(120)
        }
        
        editBtn.snp.makeConstraints { make in
            make.top.equalTo(chosePhotoBtn.snp.top)
            make.right.equalToSuperview().offset(-20.autoSize)
        }
        
        profileTextField.snp.makeConstraints { make in
            make.centerY.equalTo(chosePhotoBtn)
            make.left.equalTo(chosePhotoBtn.snp.right).offset(20)
            make.width.equalTo(200)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(chosePhotoBtn.snp.bottom).offset(32.autoSize)
            make.centerX.equalToSuperview()
        }
        
        achiLabel.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(32.autoSize)
            make.centerX.equalToSuperview()
        }
    }
    
    private func saveName() {
        if let savedUserName = Memory.shared.userName {
            profileTextField.text = savedUserName
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
