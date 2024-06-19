//
//  RatingVC.swift

import Foundation
import UIKit
import SnapKit

class RatingVC: UIViewController {
    
    var users = [ModelRating]()
    let getService = RatingService.shared

    
    var contentView: RatingView {
        view as? RatingView ?? RatingView()
    }
    
    override func loadView() {
        view = RatingView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        loadUsers()

    }
    
    func sorterScoreUsers() {
        users.sort {
            $1.score < $0.score
        }
    }
    
    func loadUsers() {
        getService.fetchData { [weak self] users in
            guard let self = self else { return }
            self.users = users
            self.contentView.ratingTableView.reloadData()
            self.sorterScoreUsers()
            }
    errorCompletion: { [weak self] error in
            guard self != nil else { return }
            }
        }
    
    private func configureTableView() {
        contentView.ratingTableView.dataSource = self
        contentView.ratingTableView.delegate = self
        contentView.ratingTableView.separatorStyle = .none
        contentView.ratingTableView.register(CustomRatingCell.self, forCellReuseIdentifier: CustomRatingCell.reuseId)
        contentView.ratingTableView.register(RatingCell.self, forCellReuseIdentifier: RatingCell.reuseId)
    }
}

//extension RatingVC: UITableViewDataSource, UITableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return users.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.row == 0 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: CustomRatingCell.reuseId, for: indexPath)
//            
//            guard let customCell = cell as? CustomRatingCell else {
//                return cell
//            }
//            
//            customCell.customImageView1.image = .imgUserOne
//            customCell.firstLabel1.text = "3000"
//            customCell.secondLabel1.text = "Adam"
//            
//            customCell.customImageView2.image = .imgUserTwo
//            customCell.firstLabel2.text = "2500"
//            customCell.secondLabel2.text = "Trisha"
//            
//            customCell.customImageView3.image = .imgUserThree
//            customCell.firstLabel3.text = "2000"
//            customCell.secondLabel3.text = "Demos"
//            
//            return customCell
//        } else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: RatingCell.reuseId, for: indexPath)
//            
//            guard let ratingCell = cell as? RatingCell else {
//                return cell
//            }
//            
//            let index = indexPath.row
//            let number = index + 1
//            let user = users[index]
//
//            setupDefaultCell(ratingCell: ratingCell, number: number, user: user)
//            
//            return ratingCell
//        }
//    }
//    
//    private func setupDefaultCell(ratingCell: RatingCell, number: Int, user: ModelRating) {
//        ratingCell.numberLabel.text = "\(number)"
//        ratingCell.scoreLabel.text = "\(user.score)"
//        ratingCell.nameLabel.text = user.name == nil || user.name == "" ? "USER# \(user.id ?? 0)" : user.name
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return indexPath.row == 0 ? 200 : UITableView.automaticDimension
//    }
//    
//    
//}

extension RatingVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RatingCell.reuseId, for: indexPath)
        
        guard let ratingCell = cell as? RatingCell else {
            
            return cell
        }
        
        
        let index = indexPath.row
        let number = index + 1
        let user = users[index]
        
        setupCell(leaderBoardCell: ratingCell, number: number, user: user)
        
        return ratingCell
    }
    
    func setupCell(leaderBoardCell: RatingCell, number: Int, user: ModelRating) {
        
        leaderBoardCell.numberLabel.text = "\(number)"
        leaderBoardCell.scoreLabel.text = "\(user.score)"
        leaderBoardCell.nameLabel.text = user.name == nil || user.name == "" ? "USER# \(user.id ?? 0)" : user.name
    }
}
