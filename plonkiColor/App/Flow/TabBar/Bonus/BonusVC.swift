//
//  BonusVC.swift

import Foundation
import UIKit
import SnapKit

class BonusVC: UIViewController {
    

    var contentView: BonusView {
        view as? BonusView ?? BonusView()
    }
    
    override func loadView() {
        view = BonusView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tappedButtons()
    }
    
    private func tappedButtons() {
        
    }
}
