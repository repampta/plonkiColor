//
//  ChapterCell.swift


import Foundation
import UIKit
import SnapKit

class ChapterCell: UITableViewCell {
    
    static let reuseId = String(describing: ChapterCell.self)
    
    
    private(set) lazy var tittleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private(set) lazy var chapterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private(set) lazy var conteiner: UIView = {
        let view = UIView()
        view.clipsToBounds = true
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
            contentView.backgroundColor = .red
            contentView.layer.cornerRadius = 8
            backgroundColor = .clear
            selectionStyle = .none
            [tittleLabel,chapterImage].forEach(conteiner.addSubview(_:))
            
        }
        
        func setupConstraints() {

            conteiner.snp.makeConstraints { make in
                make.top.left.right.bottom.equalToSuperview()
                make.bottom.equalToSuperview()
            }
            
            chapterImage.snp.makeConstraints { make in
                make.left.right.top.equalToSuperview()
                make.height.equalTo(120)
            }
            
            tittleLabel.snp.makeConstraints { make in
                make.top.equalTo(chapterImage.snp.bottom).offset(12)
                make.left.right.bottom.equalToSuperview()
                make.height.equalTo(18)
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
