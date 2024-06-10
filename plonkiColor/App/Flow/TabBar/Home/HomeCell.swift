//
//  HomeCell.swift

import Foundation
import UIKit
import SnapKit

class HomeCell: UICollectionViewCell {
    
    static let reuseId = String(describing: HomeCell.self)

    let button: UIButton = {
        let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 8
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
        contentView.addSubview(button)
    }
    
    private func setupConstraints() {
        
        button.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-24)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(150)
        }
    }

}
