//
//  ChapterView.swift

import Foundation
import UIKit
import SnapKit

class ChapterView: UIView {
    
    private (set) var bgImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .bgStart
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private (set) var contScore: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .imgCoint
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private (set) var scoreLabel: UILabel = {
        let label = UILabel.createLabel(withText: "\(Memory.shared.scoreCoints)", font: .customFont(font: .chivo, style: .black, size: 24), textColor: .cGradOne, lineHeightMultiple: 1)
        return label
    }()

    private (set) var titleLabel: UILabel = {
        let label = UILabel.createLabel(withText: "Chapter", font: .customFont(font: .kleeOne, style: .semiBold, size: 36), textColor: .cGradOne, lineHeightMultiple: 0.83)
        return label
    }()
    
    
    private (set) var subTitleLabel: UILabel = {
        let label = UILabel.createLabel(withText: "Of course, here's a list of 10 chapters for\nyour poinko-ball game:", font: .customFont(font: .chivo, style: .regular, size: 18), textColor: .cLight, lineHeightMultiple: 1)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private(set) lazy var chapterTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        return tableView
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

        [bgImage, contScore, scoreLabel, titleLabel, subTitleLabel, chapterTableView] .forEach(addSubview(_:))

    }
    
    private func setupConstraints() {
        
        bgImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contScore.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.size.equalTo(60)
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
        }
        
        scoreLabel.snp.makeConstraints { make in
            make.left.equalTo(contScore.snp.right)
            make.centerY.equalTo(contScore)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(scoreLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(20)
        }
        
        chapterTableView.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom)
            make.left.right.equalToSuperview().inset(8)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-24)
        }
    }
}
