//
//  ChapterVC.swift

import Foundation
import UIKit
import SnapKit

class ChapterVC: UIViewController {
    
    private var titleTableView: [String] = ["Color Harmony", "Gradient Challenges", "Color Contours", "Reflections and Symmetry", "Color Puzzles", "Curved Perspectives", "Color Waves", "Color Mosaics", "Color Cascades", "Masters of Color"]
    
    private var imagesChapters: [UIImage] = [.imgChapterOne, .imgChapterTwo, .imgChapterThree, .imgChapterFour, .imgChapterFive, .imgChapterSix, .imgChapterSeven, .imgChapterEight, .imgChapterNine, .imgChapterTen]

    var selectedIndex: IndexPath? = IndexPath(row: 0, section: 0)

    var contentView: ChapterView {
        view as? ChapterView ?? ChapterView()
    }
    
    override func loadView() {
        view = ChapterView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    private func configureTableView() {
        contentView.chapterTableView.dataSource = self
        contentView.chapterTableView.delegate = self
        contentView.chapterTableView.register(ChapterCell.self, forCellReuseIdentifier: ChapterCell.reuseId)
    }
}

extension ChapterVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleTableView.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChapterCell.reuseId, for: indexPath) as! ChapterCell
        cell.tittleLabel.text = titleTableView[indexPath.row]
        cell.chapterImage.image = imagesChapters[indexPath.row]
        
        cell.contentView.alpha = indexPath.row <= 1 ? 1.0 : 0.6

        
        if indexPath == selectedIndex {
            cell.chapterImage.layer.borderColor = UIColor.cGradOne.cgColor
            cell.chapterImage.layer.borderWidth = 8
            cell.chapterImage.layer.cornerRadius = 20
            cell.layer.masksToBounds = false
            cell.layer.shadowColor = UIColor.cDarkPurple.withAlphaComponent(0.8).cgColor
            cell.layer.shadowOpacity = 1
            cell.layer.shadowRadius = 20
            cell.layer.shadowOffset = CGSize(width: 0, height: 0)

            } else {
            cell.chapterImage.layer.borderColor = UIColor.clear.cgColor
            cell.chapterImage.layer.borderWidth = 0
            cell.chapterImage.layer.cornerRadius = 20
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        if let previousIndex = selectedIndex {
                   let previousCell = tableView.cellForRow(at: previousIndex) as? ChapterCell
                   previousCell?.chapterImage.layer.borderColor = UIColor.clear.cgColor
                   previousCell?.chapterImage.layer.borderWidth = 0
            
               }
               
            let cell = tableView.cellForRow(at: indexPath) as? ChapterCell
            cell?.chapterImage.layer.borderColor = UIColor.cGradOne.cgColor
            cell?.chapterImage.layer.borderWidth = 8
            cell?.chapterImage.layer.cornerRadius = 20
            cell?.layer.masksToBounds = false
            cell?.layer.shadowColor = UIColor.cDarkPurple.withAlphaComponent(0.8).cgColor
            cell?.layer.shadowOpacity = 1
            cell?.layer.shadowRadius = 20
            cell?.layer.shadowOffset = CGSize(width: 0, height: 0)

        
        selectedIndex = indexPath

        
        switch indexPath.row {
        case 0:
            UserDefaults.currentChapter = .colorHarmony
        case 1:
            UserDefaults.currentChapter = .gradientChallenges
        default:
            return
        }
        self.tabBarController?.selectedIndex = 2
    }
}

