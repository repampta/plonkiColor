//
//  HomeVC.swift

import Foundation
import UIKit
import SnapKit

struct ColorData {
    static let colorsForFirstItem: [UIColor] = [.red, .blue, .green, .orange, .yellow, .systemPink, .brown, .cyan, .cGradOne, .cGradTwo]
    static let colorsForSecondItem: [UIColor] = [.orange, .blue, .red, .orange, .yellow, .systemPink, .brown, .cyan, .cGradOne, .cGradTwo]
    static let colorsForThirdItem: [UIColor] = [.green, .blue, .red, .orange, .yellow, .systemPink, .brown, .cyan, .cGradOne, .cGradTwo]
}


class HomeVC: UIViewController {
    
    private var levels: [UIColor] = [.red, .blue, .green, .orange, .yellow, .systemPink, .brown, .cyan, .cGradOne, .cGradTwo]
    
    var contentView: HomeView {
        view as? HomeView ?? HomeView()
    }
    
    override func loadView() {
        view = HomeView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollection()
        tappedButtons()
        contentView.updatePageNumbers(count: levels.count, currentPage: 1)
    }
    
    private func configureCollection() {
        contentView.collectionView.dataSource = self
        contentView.collectionView.delegate = self
        contentView.collectionView.register(HomeCell.self, forCellWithReuseIdentifier: HomeCell.reuseId)
    }
    
    private func tappedButtons() {
    }
    
    func setColors(colors: [UIColor]) {
           self.levels = colors
        contentView.collectionView.reloadData()
        contentView.updatePageNumbers(count: levels.count, currentPage: 1)

       }
}

extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return levels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.reuseId, for: indexPath) as! HomeCell
        cell.contentView.backgroundColor = levels[indexPath.item]
        
        cell.button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        cell.button.tag = indexPath.item
        
        return cell
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        let index = sender.tag
        print("Button tapped at index \(index)")
        let vc = GameVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
          guard let visibleIndexPath = collectionView.indexPathsForVisibleItems.first else { return }
          let pageIndex = visibleIndexPath.item + 1
          print("didEndDisplaying - Current page index: \(pageIndex)")
          contentView.updatePageNumber(currentPage: pageIndex)
      }

}


