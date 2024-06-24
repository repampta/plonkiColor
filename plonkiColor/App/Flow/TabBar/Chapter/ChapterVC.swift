//
//  ChapterVC.swift
import Foundation
import UIKit
import SnapKit

class ChapterVC: UIViewController {
        
    private var chapter = Chapter.allCases

    var selectedIndex: IndexPath? = IndexPath(row: 0, section: 0)
    private var currentChapter = UserDefaults.currentChapter

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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        update()
    }
    private func update() {
        if let selectedIndex = selectedIndex {
                let cell = contentView.chapterTableView.cellForRow(at: selectedIndex) as? ChapterCell
                cell?.chapterImage.layer.borderColor = UIColor.cGradOne.cgColor
                cell?.chapterImage.layer.borderWidth = 8
                cell?.chapterImage.layer.cornerRadius = 20
                cell?.chapterImage.layer.masksToBounds = false
                cell?.chapterImage.layer.shadowColor = UIColor.purple.withAlphaComponent(0.8).cgColor
                cell?.chapterImage.layer.shadowOpacity = 1
                cell?.chapterImage.layer.shadowRadius = 12
                cell?.chapterImage.layer.shadowOffset = CGSize(width: 0, height: 0)
            }
    }
    private func configureTableView() {
        contentView.chapterTableView.dataSource = self
        contentView.chapterTableView.delegate = self
        contentView.chapterTableView.register(ChapterCell.self, forCellReuseIdentifier: ChapterCell.reuseId)
    }
}

extension ChapterVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chapter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChapterCell.reuseId, for: indexPath) as! ChapterCell
        cell.tittleLabel.text = chapter[indexPath.row].titleChapter
        cell.chapterImage.image = chapter[indexPath.row].imagesChapters
        
        cell.contentView.alpha = indexPath.row <= 1 ? 1.0 : 0.6
        cell.imgCompleted.isHidden = !chapter[indexPath.row].isFinished
        
        if indexPath == selectedIndex {
            cell.chapterImage.layer.borderColor = UIColor.cGradOne.cgColor
            cell.chapterImage.layer.borderWidth = 8
            cell.chapterImage.layer.cornerRadius = 20
            cell.chapterImage.layer.masksToBounds = false
            cell.chapterImage.layer.shadowColor = UIColor.purple.withAlphaComponent(0.8).cgColor
            cell.chapterImage.layer.shadowOpacity = 1
            cell.chapterImage.layer.shadowRadius = 12
            cell.chapterImage.layer.shadowOffset = CGSize(width: 0, height: 0)
        } else {
            resetCellAppearance(cell)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        if indexPath.row >= 2 {
            let alert = UIAlertController(title: "Coming soon", message: "Update will be available soon", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            if let previousIndex = selectedIndex {
                tableView.deselectRow(at: indexPath, animated: true)
                tableView.selectRow(at: previousIndex, animated: true, scrollPosition: .none)
            }
            return
        }
        
        if let previousIndex = selectedIndex {
            let previousCell = tableView.cellForRow(at: previousIndex) as? ChapterCell
            resetCellAppearance(previousCell)
        }
        
        let cell = tableView.cellForRow(at: indexPath) as? ChapterCell
        cell?.chapterImage.layer.borderColor = UIColor.cGradOne.cgColor
        cell?.chapterImage.layer.borderWidth = 8
        cell?.chapterImage.layer.cornerRadius = 20
        cell?.chapterImage.layer.masksToBounds = false
        cell?.chapterImage.layer.shadowColor = UIColor.purple.withAlphaComponent(0.8).cgColor
        cell?.chapterImage.layer.shadowOpacity = 1
        cell?.chapterImage.layer.shadowRadius = 12
        cell?.chapterImage.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        selectedIndex = indexPath

        switch indexPath.row {
        case 0:
            UserDefaults.currentChapter = .colorHarmony
        case 1:
            UserDefaults.currentChapter = .gradientChallenges
        default:
            return
        }
        
        if let tabBar = self.tabBarController as? TabBar {
            tabBar.selectTab(at: 2)
        }
    }

    private func resetCellAppearance(_ cell: ChapterCell?) {
        cell?.chapterImage.layer.borderColor = UIColor.clear.cgColor
        cell?.chapterImage.layer.borderWidth = 0
        cell?.chapterImage.layer.cornerRadius = 20
        cell?.chapterImage.layer.shadowColor = UIColor.clear.cgColor
        cell?.chapterImage.layer.shadowOpacity = 0
        cell?.chapterImage.layer.shadowRadius = 0
        cell?.chapterImage.layer.shadowOffset = CGSize.zero
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }

}
