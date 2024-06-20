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
    private var chapterImagesOne: [UIImage] = [.imgLevelOne, .imgLevelTwo, .imgLevelThree, .imgLevelFour, .imgLevelFive, .imgLevelSix, .imgLevelSeven, .imgLevelEight, .imgLevelNine, .imgLevelTen]
    private var chapterImagesTwo: [UIImage] = [.imgGradLevelOne, .imgGradLevelTwo, .imgGradLevelThree, .imgGradLevelFour, .imgGradLevelFive, .imgGradLevelSix, .imgGradLevelSeven, .imgGradLevelEight, .imgGradLevelNine, .imgGradLevelTen]

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
        updateLabel()
    }
    
    
    private func updateLabel() {
        if currentChapter == .colorHarmony {
            contentView.titleLabel.text = "Chapter\n\"Color Harmony\""
        } else if currentChapter == .gradientChallenges {
            contentView.titleLabel.text = "Chapter\n\"Gradient Challenges\""
        }
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

extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return levels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.reuseId, for: indexPath) as! HomeCell
        
        if currentChapter == .colorHarmony {
                 cell.imageViewLevels.image = chapterImagesOne[indexPath.item]
             } else if currentChapter == .gradientChallenges {
                 cell.imageViewLevels.image = chapterImagesTwo[indexPath.item]
             }
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
    
    
//    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//          guard let visibleCells = collectionView.visibleCells as? [HomeCell] else { return }
//          
//          let visibleIndexPaths = visibleCells.compactMap { collectionView.indexPath(for: $0) }
//          
//          guard !visibleIndexPaths.isEmpty else { return }
//          
//          let sortedVisibleIndexPaths = visibleIndexPaths.sorted(by: { $0.item < $1.item })
//          let centerIndex = sortedVisibleIndexPaths.count / 2
//          
//          let centerIndexPath = sortedVisibleIndexPaths[centerIndex]
//          let pageIndex = centerIndexPath.item + 1
//          
//          print("didEndDisplaying - Current page index: \(pageIndex)")
//          
//          if levels.indices.contains(centerIndexPath.item) {
//              let level = levels[centerIndexPath.item]
//              if let visibleCell = collectionView.cellForItem(at: centerIndexPath) as? HomeCell {
//                  if level.isOpen {
//                      visibleCell.button.setBackgroundImage(UIImage(named: "btnActivity"), for: .normal)
//                      visibleCell.button.isEnabled = true
//                  } else {
//                      visibleCell.button.setBackgroundImage(UIImage(named: "btnLocked"), for: .normal)
//                      visibleCell.button.isEnabled = false
//                  }
//              }
//          }
//          contentView.updatePageNumber(currentPage: pageIndex)
//      }
//    
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
          guard let visibleIndexPath = collectionView.indexPathsForVisibleItems.first else { return }
          let pageIndex = visibleIndexPath.item + 1
          print("didEndDisplaying - Current page index: \(pageIndex)")
          
          if levels.indices.contains(visibleIndexPath.item) {
              let level = levels[visibleIndexPath.item]
              if let visibleCell = collectionView.cellForItem(at: visibleIndexPath) as? HomeCell {
                  if level.isOpen {
                      visibleCell.button.setBackgroundImage(UIImage(named: "btnActivity"), for: .normal)
                      visibleCell.button.isEnabled = true
                  } else {
                      visibleCell.button.setBackgroundImage(UIImage(named: "btnLocked"), for: .normal)
                      visibleCell.button.isEnabled = false
                  }
              }
          }
          contentView.updatePageNumber(currentPage: pageIndex)
      }

    
}


