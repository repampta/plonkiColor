//
//  RatingVC.swift

import Foundation
import UIKit
import SnapKit

class RatingVC: UIViewController {
    
    var contentView: RatingView {
        view as? RatingView ?? RatingView()
    }
    
    override func loadView() {
        view = RatingView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tappedButtons()
        configureTableView()
    }
    
    private func tappedButtons() {
        // Настройка действий на кнопки
    }
    
    private func configureTableView() {
        contentView.ratingTableView.dataSource = self
        contentView.ratingTableView.delegate = self
        contentView.ratingTableView.separatorStyle = .none
        contentView.ratingTableView.register(CustomRatingCell.self, forCellReuseIdentifier: CustomRatingCell.reuseId)
        contentView.ratingTableView.register(RatingCell.self, forCellReuseIdentifier: RatingCell.reuseId)
    }
}

extension RatingVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CustomRatingCell.reuseId, for: indexPath)
            
            guard let customCell = cell as? CustomRatingCell else {
                return cell
            }
            
            customCell.customImageView1.image = .imgUserOne
            customCell.firstLabel1.text = "3000"
            customCell.secondLabel1.text = "Adam"
            
            customCell.customImageView2.image = .imgUserTwo
            customCell.firstLabel2.text = "2500"
            customCell.secondLabel2.text = "Trisha"
            
            customCell.customImageView3.image = .imgUserThree
            customCell.firstLabel3.text = "2000"
            customCell.secondLabel3.text = "Demos"
            
            return customCell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: RatingCell.reuseId, for: indexPath)
            
            guard let ratingCell = cell as? RatingCell else {
                return cell
            }
            
            let index = indexPath.row
            let number = index + 1
            
            setupDefaultCell(ratingCell: ratingCell, number: number)
            
            return ratingCell
        }
    }
    
    private func setupDefaultCell(ratingCell: RatingCell, number: Int) {
        ratingCell.numberLabel.text = "\(number)"
        ratingCell.scoreLabel.text = "\(number)"
        ratingCell.nameLabel.text = "Default User \(number)"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 200 : UITableView.automaticDimension
    }
    
    
}
