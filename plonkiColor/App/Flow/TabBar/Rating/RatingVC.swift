//
//  RatingVC.swift

import Foundation
import UIKit
import SnapKit

class RatingVC: UIViewController {
    
    var users = [User]()
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
            $1.balance ?? 0 < $0.balance ?? 0
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

extension RatingVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomRatingCell.reuseId, for: indexPath) as? CustomRatingCell else {
                return UITableViewCell()
            }
            let topUsers = Array(users.prefix(3))
            cell.configure(with: topUsers)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RatingCell.reuseId, for: indexPath) as? RatingCell else {
                return UITableViewCell()
            }
            let user = users[indexPath.row]
            setupCell(ratingCell: cell, number: indexPath.row + 1, user: user)
            return cell
        }
    }
    
    func setupCell(ratingCell: RatingCell, number: Int, user: User) {
        ratingCell.numberLabel.text = "\(number)"
        ratingCell.scoreLabel.text = "\(user.balance ?? 0)"
        ratingCell.nameLabel.text = user.username == "" ? "USER# \(user.id ?? 0)" : user.username
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 200 : UITableView.automaticDimension
    }
}
