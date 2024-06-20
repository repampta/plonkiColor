//
//  LoadingVC.swift


import Combine
import Foundation
import UIKit
import SnapKit
import SwiftUI

class LoadingVC: UIViewController {
    
    private let auth = AuthTokenService.shared
    private let post = PostRequestService.shared
    private let ud = Memory.shared
    
    private var loadignViewModel: LoadingViewModel = LoadingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let loadingScreen = LoadingScreen(loadignViewModel: loadignViewModel)
        let hostingController = UIHostingController(rootView: loadingScreen)
        addChild(hostingController)
        hostingController.view.frame = self.view.frame
        self.view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        animateProgressBar()
    }
    
    func animateProgressBar() {
        DispatchQueue.main.async {
            self.loadignViewModel.isAnimating = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.loadHomeVC()
        }
    }
  
    func loadHomeVC() {
        if Memory.shared.firstLaunchDate == nil {
                 Memory.shared.firstLaunchDate = Date()
             }
            Task {
                do {
                    try await auth.authenticate()
                    checkToken()
                    createUserIfNeededUses()
                    let vc = TabBar()
                    let navigationController = UINavigationController(rootViewController: vc)
                    navigationController.modalPresentationStyle = .fullScreen
                    present(navigationController, animated: true)
                    navigationController.setNavigationBarHidden(true, animated: false)
                } catch {
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    
    private func createUserIfNeededUses() {
        if ud.userID == nil {
            let uuid = UUID().uuidString
            Task {
                do {
                    let player = try await post.createPlayerUser(username: uuid)
                    ud.userID = player.id
                } catch {
                    print("Ошибка создания пользователя: \(error.localizedDescription)")
                }
            }
        }
    }

    private func checkToken() {
        guard let token = auth.token else {
            return
        }
    }
}
