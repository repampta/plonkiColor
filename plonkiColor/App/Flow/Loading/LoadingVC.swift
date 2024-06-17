//
//  LoadingVC.swift


import Foundation
import UIKit
import SnapKit

class LoadingVC: UIViewController {

    var contentView: LoadingView {
        view as? LoadingView ?? LoadingView()
    }
    
    override func loadView() {
        view = LoadingView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.layoutIfNeeded()
        animateProgressBar()
    }
    
    func animateProgressBar() {
        UIView.animate(withDuration: 1.5) {
            self.contentView.progressView.setProgress(1.0, animated: true)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                  self.loadHomeVC()
    }
}
    
    func loadHomeVC() {
        let vc = TabBar()
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
        navigationController.setNavigationBarHidden(true, animated: false)
    }
}
