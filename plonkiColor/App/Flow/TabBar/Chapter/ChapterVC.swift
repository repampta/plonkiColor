//
//  ChapterVC.swift

import Foundation
import UIKit
import SnapKit

class ChapterVC: UIViewController {
    

    var contentView: ChapterView {
        view as? ChapterView ?? ChapterView()
    }
    
    override func loadView() {
        view = ChapterView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tappedButtons()
    }
    
    private func tappedButtons() {
        
    }
}
