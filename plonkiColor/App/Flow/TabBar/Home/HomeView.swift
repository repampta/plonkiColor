//
//  HomeView.swift


import Foundation
import UIKit
import SnapKit

class HomeView: UIView {
    
    private (set) var view: UIView = {
        let view = UIImageView()
        view.backgroundColor = .green
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
        label.text = "Chapter Name"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 36)
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
        stackView.distribution = .fillEqually
        stackView.spacing = 8
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
            make.size.equalTo(48)
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(24)
        }
        
        scoreLabel.snp.makeConstraints { make in
            make.left.equalTo(contScore.snp.right).offset(10)
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
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 40)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPaging
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
                label.textColor = .green
                label.font = .boldSystemFont(ofSize: 24)
            } else {
                label.textColor = .white
                label.font = .systemFont(ofSize: 12)
            }
            pageNumberStackView.addArrangedSubview(label)
        }
    }
        
        func updatePageNumber(currentPage: Int) {
            for (index, view) in pageNumberStackView.arrangedSubviews.enumerated() {
                guard let label = view as? UILabel else { continue }
                if index + 1 == currentPage {
                    label.textColor = .green
                    label.font = .boldSystemFont(ofSize: 24)
                } else {
                    label.textColor = .white
                    label.font = .systemFont(ofSize: 12)
                }
            }
        }
}
