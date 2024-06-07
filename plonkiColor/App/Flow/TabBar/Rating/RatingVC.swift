//
//  RatingVC.swift

//import Foundation
//import UIKit
//import SnapKit
//
//class RatingVC: UIViewController {
//    
//
//    var contentView: RatingView {
//        view as? RatingView ?? RatingView()
//    }
//    
//    override func loadView() {
//        view = RatingView()
//    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tappedButtons()
//        configureTableView()
//    }
//    
//    private func tappedButtons() {
//        
//    }
//    
//    private func configureTableView() {
//        contentView.ratingTableView.dataSource = self
//        contentView.ratingTableView.delegate = self
//        contentView.ratingTableView.separatorStyle = .none
//        
//    }
//}
//
//
//extension RatingVC: UITableViewDataSource, UITableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 10
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//           if indexPath.row == 0 {
//               let cell = tableView.dequeueReusableCell(withIdentifier: CustomRatingOneCell.reuseId, for: indexPath)
//               
//               guard let customCell = cell as? CustomRatingOneCell else {
//                   return cell
//               }
//               
//               customCell.firstLabel.text = "One"
//               customCell.secondLabel.text = "Score"
//               customCell.contentView.snp.remakeConstraints { make in
//                             make.width.equalTo(110)
//                             make.centerX.equalToSuperview()
//                         }
//               
//               return customCell
//           } else {
//               let cell = tableView.dequeueReusableCell(withIdentifier: RatingCell.reuseId, for: indexPath)
//               
//               guard let ratingCell = cell as? RatingCell else {
//                   return cell
//               }
//               
//               let index = indexPath.row
//               let number = index + 1
//               
//               setupDefaultCell(ratingCell: ratingCell, number: number)
//               
//               return ratingCell
//           }
//       }
//       
//       private func setupDefaultCell(ratingCell: RatingCell, number: Int) {
//           ratingCell.numberLabel.text = "\(number)"
//           ratingCell.scoreLabel.text = "Default Score \(number)"
//           ratingCell.nameLabel.text = "Default User \(number)"
//       }
//       
//       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//           return indexPath.row == 0 ? 175 : UITableView.automaticDimension
//       }
////    func setupCell(leaderBoardCell: RatingCell, number: Int) {
////
////
////        leaderBoardCell.numberLabel.text = "\(number)"
////        leaderBoardCell.scoreLabel.text = "\(user.score)"
////        leaderBoardCell.nameLabel.text = user.name == nil || user.name == "" ? "USER# \(user.id ?? 0)" : user.name
////    }
//    
//}

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
            
            customCell.customImageView1.image = .centerImg
            customCell.firstLabel1.text = "One"
            customCell.secondLabel1.text = "Score"
            
            customCell.customImageView2.image = .centerImg
            customCell.firstLabel2.text = "Two"
            customCell.secondLabel2.text = "Score"
            
            customCell.customImageView3.image = .centerImg
            customCell.firstLabel3.text = "Three"
            customCell.secondLabel3.text = "Score"
            
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
        ratingCell.scoreLabel.text = "Default Score \(number)"
        ratingCell.nameLabel.text = "Default User \(number)"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 175 : UITableView.automaticDimension
    }
}
