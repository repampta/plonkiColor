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
        label.text = "Chapter"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 36)
        return label
    }()
    
    
    private (set) var subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Of course, here's a list of 10 chapters for\nyour poinko-ball game:"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private(set) lazy var chapterTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .yellow
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
            make.size.equalTo(48)
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(24)
        }
        
        scoreLabel.snp.makeConstraints { make in
            make.left.equalTo(contScore.snp.right).offset(10)
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
