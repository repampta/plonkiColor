//
//  RatingView.swift

import Foundation
import UIKit
import SnapKit

class RatingView: UIView {
    
    private (set) var view: UIView = {
        let view = UIImageView()
        view.backgroundColor = .systemPink
        return view
    }()
    
    private (set) var bgImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .bgHome
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private (set) var contScore: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    private (set) var scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "\(Memory.shared.scoreCoints)"
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private (set) var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Rating of the week"
        label.textColor = .blue
        label.font = .systemFont(ofSize: 36)
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
            make.size.equalTo(48)
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(24)
        }
        
        scoreLabel.snp.makeConstraints { make in
            make.left.equalTo(contScore.snp.right).offset(10)
            make.centerY.equalTo(contScore)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contScore.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        ratingTableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(24)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
    }
}
