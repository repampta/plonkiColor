//
//  HomeView.swift


import Foundation
import UIKit
import SnapKit

class HomeView: UIView {
    
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
        let label = UILabel.createLabel(withText: "Chapter", font: .customFont(font: .kleeOne, style: .semiBold, size: 36), textColor: .cGradOne, lineHeightMultiple: 0.83)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
  

    private(set) lazy var collectionView: UICollectionView = {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private(set) var pageNumberStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 16
        return stackView
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

        [bgImage, contScore, scoreLabel, titleLabel, collectionView, pageNumberStackView] .forEach(addSubview(_:))

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
            make.top.equalTo(contScore.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.height.equalTo(400)
            make.left.right.equalToSuperview()
        }
        
        pageNumberStackView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
    }
    
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .fractionalHeight(1.0))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPagingCentered
            return section
        }
        return layout
    }
    
    func updatePageNumbers(count: Int, currentPage: Int) {
        pageNumberStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for i in 0..<count {
            let label = UILabel()
            label.text = "\(i + 1)"
            if i == currentPage {
                label.textColor = .cGradOne
                label.font = .customFont(font: .chivo, style: .black, size: 54)
            } else {
                label.textColor = .cLight.withAlphaComponent(0.4)
                label.font = .customFont(font: .chivo, style: .black, size: 24)
            }
            pageNumberStackView.addArrangedSubview(label)
        }
    }
        
        func updatePageNumber(currentPage: Int) {
            for (index, view) in pageNumberStackView.arrangedSubviews.enumerated() {
                guard let label = view as? UILabel else { continue }
                if index + 1 == currentPage {
                    label.textColor = .cGradOne
                    label.font = .customFont(font: .chivo, style: .black, size: 54)
                } else {
                    label.textColor = .cLight.withAlphaComponent(0.4)
                    label.font = .customFont(font: .chivo, style: .black, size: 24)
                }
            }
        }
}
