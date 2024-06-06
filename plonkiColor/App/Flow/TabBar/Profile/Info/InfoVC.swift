//
//  InfoVC.swift


import Foundation
import UIKit
import SnapKit

class InfoVC: UIViewController {
    

    var contentView: InfoView {
        view as? InfoView ?? InfoView()
    }
    
    override func loadView() {
        view = InfoView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tappedButtons()
    }
    
    private func tappedButtons() {
        contentView.backBtn.addTarget(self, action: #selector(tappedBack), for: .touchUpInside)

    }
    
    @objc func tappedBack() {
        navigationController?.popViewController(animated: true)
    }
}
