//
//  RatingView.swift

import Foundation
import UIKit
import SnapKit

class RatingView: UIView {

    
    private (set) var bgImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .bgClassic
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
        let label = UILabel.createLabel(withText: "Rating of the week", font: .customFont(font: .kleeOne, style: .semiBold, size: 36), textColor: .cGradOne, lineHeightMultiple: 0.83)
        return label
    }()
    
    private(set) lazy var ratingTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        tableView.register(RatingCell.self, forCellReuseIdentifier: RatingCell.reuseId)
        tableView.register(CustomRatingCell.self, forCellReuseIdentifier: CustomRatingCell.reuseId)
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

        [bgImage, contScore, scoreLabel, titleLabel, ratingTableView] .forEach(addSubview(_:))

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
        
        ratingTableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
    }
}
