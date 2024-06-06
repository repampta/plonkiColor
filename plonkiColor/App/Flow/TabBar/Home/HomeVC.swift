//
//  HomeVC.swift

import Foundation
import UIKit
import SnapKit

class HomeVC: UIViewController {
    

    var contentView: HomeView {
        view as? HomeView ?? HomeView()
    }
    
    override func loadView() {
        view = HomeView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tappedButtons()
    }
    
    private func tappedButtons() {
        
    }
}
