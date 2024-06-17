//
//  HomeVC.swift

import Foundation
import UIKit
import SnapKit
import SwiftUI

struct ColorData {
    static let colorsForFirstItem: [UIColor] = [.red, .blue, .green, .orange, .yellow, .systemPink, .brown, .cyan, .cGradOne, .cGradTwo]
    static let colorsForSecondItem: [UIColor] = [.orange, .blue, .red, .orange, .yellow, .systemPink, .brown, .cyan, .cGradOne, .cGradTwo]
    static let colorsForThirdItem: [UIColor] = [.green, .blue, .red, .orange, .yellow, .systemPink, .brown, .cyan, .cGradOne, .cGradTwo]
}


class HomeVC: UIViewController {
    
    private var levelColors: [UIColor] = [.red, .blue, .green, .orange, .yellow, .systemPink, .brown, .cyan, .cGradOne, .cGradTwo]
    
    private var currentChapter = UserDefaults.currentChapter
    private var currentLevelIndex = Chapter.currentLevel.id
    private var levels: [Level] = UserDefaults.currentChapter.levels
    
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
        contentView.updatePageNumbers(
            count: levels.count,
            currentPage: currentLevelIndex
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if UserDefaults.currentChapter != currentChapter {
            self.currentChapter = UserDefaults.currentChapter
            self.levels = UserDefaults.currentChapter.levels
            self.currentLevelIndex = Chapter.currentLevel.id
            contentView.collectionView.reloadData()
        }
        
        /// Added the scroll to the index of the current level
        scrollCollectionToTheCurrentLevel()
        contentView.updatePageNumbers(count: levels.count, currentPage: currentLevelIndex)
    }
    
    private func configureCollection() {
        contentView.collectionView.dataSource = self
        contentView.collectionView.delegate = self
        contentView.collectionView.register(HomeCell.self, forCellWithReuseIdentifier: HomeCell.reuseId)
    }
    
    private func scrollCollectionToTheCurrentLevel() {
        DispatchQueue.main.async {
            let indexPath = IndexPath(item: self.currentLevelIndex, section: 0)
            self.contentView.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    private func tappedButtons() {
    }
    
    func setColors(colors: [UIColor]) {
           self.levelColors = colors
        contentView.collectionView.reloadData()
        contentView.updatePageNumbers(count: levelColors.count, currentPage: 1)
       }
}

extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return levels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.reuseId, for: indexPath) as! HomeCell
        cell.contentView.backgroundColor = levelColors[indexPath.item]
        
        cell.button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        cell.button.tag = indexPath.item
        
        return cell
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        let index = sender.tag
        print("Button tapped at index \(index)")
        
        if levels.indices.contains(index) {
            let level = levels[index]
            /// Here we can check if the level is open
            guard level.isOpen else { return }
            let levelViewModel = LevelViewModel(level: level)
            let controller = UIHostingController(rootView: LevelView(viewModel: levelViewModel))
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
          guard let visibleIndexPath = collectionView.indexPathsForVisibleItems.first else { return }
          let pageIndex = visibleIndexPath.item + 1
          print("didEndDisplaying - Current page index: \(pageIndex)")
          contentView.updatePageNumber(currentPage: pageIndex)
      }

}


