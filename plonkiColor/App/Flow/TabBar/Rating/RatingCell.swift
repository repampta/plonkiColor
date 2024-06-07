//
//  RatingCell.swift


import Foundation
import UIKit
import SnapKit

class RatingCell: UITableViewCell {
    
    static let reuseId = String(describing: RatingCell.self)

    private(set) lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        return label
    }()

    private(set) lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .white
        return label
    }()
    
    private(set) lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    private(set) lazy var userImage: UIImageView = {
        let iv = UIImageView()
        iv.image = .imgUserDefolt
        return iv
    }()
    
    
    private(set) lazy var leadView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
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
            [nameLabel,scoreLabel,numberLabel,userImage] .forEach(leadView.addSubview(_:))

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
            make.height.equalTo(50.autoSize)
            make.width.equalTo(345.autoSize)
        }

        numberLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(8)
        }
        
        userImage.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(numberLabel.snp.right).offset(6)
            make.size.equalTo(48)
        }

        nameLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(userImage.snp.right).offset(6)
        }
        
        scoreLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-8)
        }
    }
}
