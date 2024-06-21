//
//  HomeCell.swift

import Foundation
import UIKit
import SnapKit

class HomeCell: UICollectionViewCell {
    
    static let reuseId = String(describing: HomeCell.self)

    private(set) lazy var imageViewLevels: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.configureButton(withTitle: "Play".uppercased(), font: .customFont(font: .kleeOne, style: .semiBold, size: 24), titleColor: .cDarkPurple, normalImage: .btnActivity, highlightedImage: .btnActivityTapped, kern: 4.8)
        button.layer.shadowColor = UIColor.black.withAlphaComponent(0.6).cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 8
        button.layer.shadowOffset = CGSize(width: 0, height: 8)
        return button
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
        contentView.addSubview(imageViewLevels)
        contentView.addSubview(button)
    }
    
    private func setupConstraints() {
        
        imageViewLevels.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
            make.height.equalTo(256.autoSize)
            make.width.equalTo(192.autoSize)
        }
        
        button.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-24)
            make.centerX.equalToSuperview()
            make.height.equalTo(48)
            make.width.equalTo(244)
        }
    }

}
