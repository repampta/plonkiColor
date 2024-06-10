//
//  ChapterVC.swift

import Foundation
import UIKit
import SnapKit

class ChapterVC: UIViewController {
    
    private var titleTableView: [String] = ["Color Harmony", "Gradient Challenges", "Color Contours", "Reflections and Symmetry", "Color Puzzles", "Curved Perspectives", "Color Waves", "Color Mosaics", "Color Cascades", "Masters of Color"]
    
    var contentView: ChapterView {
        view as? ChapterView ?? ChapterView()
    }
    
    override func loadView() {
        view = ChapterView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tappedButtons()
        configureTableView()
    }
    
    private func tappedButtons() {
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
        // Установка изображения, если требуется
        // cell.chapterImage.image = UIImage(named: "someImage")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var selectedColors: [UIColor] = []
        switch indexPath.row {
        case 0:
            selectedColors = [.red, .blue, .green, .orange, .yellow, .systemPink, .brown, .cyan, .cGradOne, .cGradTwo]
        case 1:
            selectedColors = [.orange, .blue, .red, .orange, .yellow, .systemPink, .brown, .cyan, .cGradOne, .cGradTwo]
        case 2:
            selectedColors = [.green, .blue, .red, .orange, .yellow, .systemPink, .brown, .cyan, .cGradOne, .cGradTwo]
        default:
            selectedColors = [.red, .blue, .green, .orange, .yellow, .systemPink, .brown, .cyan, .cGradOne, .cGradTwo]
        }
        let homeVC = HomeVC()
        homeVC.setColors(colors: selectedColors)
        navigationController?.pushViewController(homeVC, animated: true)
    }
}

