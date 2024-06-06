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
    }
    
    private func tappedButtons() {
        
    }
}
