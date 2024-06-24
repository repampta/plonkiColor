//
//  ChapterCell.swift


import Foundation
import UIKit
import SnapKit

class ChapterCell: UITableViewCell {
    
    static let reuseId = String(describing: ChapterCell.self)
    
    
    private(set) lazy var tittleLabel: UILabel = {
        let label = UILabel()
        label.font = .customFont(font: .kleeOne, style: .semiBold, size: 28)
        label.textColor = .cLight
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    
    private(set) lazy var imgCompleted: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .imgChapterCompleted
        imageView.layer.shadowColor = UIColor.black.withAlphaComponent(0.6).cgColor
        imageView.layer.shadowOpacity = 1
        imageView.layer.shadowRadius = 12
        imageView.layer.shadowOffset = CGSize(width: 0, height: 0)
        imageView.isHidden = true
        return imageView
    }()
    
    private(set) lazy var chapterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = false
        return imageView
    }()
    
    private(set) lazy var conteiner: UIView = {
        let view = UIView()
        return view
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setupConstraints()
    }
    
    override func layoutSubviews() {
            super.layoutSubviews()
            contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 20, left: 12, bottom: 0, right: 12))
        }
    
        func setupUI() {
            contentView.addSubview(conteiner)
            contentView.backgroundColor = .clear
            contentView.layer.cornerRadius = 20
            contentView.layer.masksToBounds = false
            backgroundColor = .clear
            selectionStyle = .none
            [chapterImage, tittleLabel, imgCompleted].forEach(conteiner.addSubview(_:))
            
        }
        
        func setupConstraints() {

            conteiner.snp.makeConstraints { make in
                make.top.left.right.bottom.equalToSuperview()
                make.bottom.equalToSuperview()
                make.height.equalTo(160.autoSize)
            }
            
            chapterImage.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            tittleLabel.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
            
            imgCompleted.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.centerY.equalTo(chapterImage.snp.top).offset(15)
            }
        }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        tittleLabel.text = nil
        chapterImage.image = nil
    }
    
 
}
