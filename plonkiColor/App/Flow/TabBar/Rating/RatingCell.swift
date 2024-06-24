//
//  RatingCell.swift


import Foundation
import UIKit
import SnapKit

class RatingCell: UITableViewCell {
    
    static let reuseId = String(describing: RatingCell.self)

    private(set) lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .customFont(font: .chivo, style: .regular, size: 16)
        label.textColor = .cDarkPurple
        return label
    }()

    private(set) lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.font = .customFont(font: .chivo, style: .black, size: 24)
        label.textColor = .cDarkPurple
        return label
    }()
    
    private(set) lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.font = .customFont(font: .chivo, style: .regular, size: 16)
        label.textColor = .cDarkPurple
        return label
    }()
    
    private(set) lazy var userImage: UIImageView = {
        let iv = UIImageView()
        iv.image = .imgUserRating
        return iv
    }()
    
    private (set) var imgScore: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .imgCointScore
        return imageView
    }()
    
    private(set) lazy var leadView: UIView = {
        let view = UIView()
        view.backgroundColor = .cGradTwo
        view.layer.cornerRadius = 8
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setUpConstraints()
    }
    
        func setupUI() {
            backgroundColor = .clear
            contentView.addSubview(leadView)
            contentView.backgroundColor = .clear
            selectionStyle = .none
            [userImage, imgScore, nameLabel, scoreLabel, numberLabel] .forEach(leadView.addSubview(_:))

    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        nameLabel.text = nil
        scoreLabel.text =  nil
    }
    
    private func setUpConstraints(){
        
        leadView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(64.autoSize)
            make.width.equalTo(345.autoSize)
        }
        
        userImage.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(12)
            make.size.equalTo(48)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(userImage.snp.top)
            make.left.equalTo(userImage.snp.right).offset(10)
        }
        
        imgScore.snp.makeConstraints { (make) in
            make.bottom.equalTo(userImage.snp.bottom)
            make.left.equalTo(userImage.snp.right).offset(10)
            make.size.equalTo(24)
        }
        
        scoreLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(imgScore)
            make.left.equalTo(imgScore.snp.right).offset(4)
        }
        
        numberLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-12)
        }
    }
}
