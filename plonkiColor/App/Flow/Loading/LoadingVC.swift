//
//  LoadingVC.swift


import Foundation
import UIKit
import SnapKit

class LoadingVC: UIViewController {
    
    private let auth = AuthTokenService.shared
    private let post = PostRequestService.shared
    private let ud = Memory.shared


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
          UIView.animate(withDuration: 1.5, animations: {
              self.contentView.progressView.setProgress(1.0, animated: true)
          }, completion: { _ in
              self.contentView.updateGradientMask()
              self.contentView.animateGradient()
          })
          
          DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
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
//                    createUserIfNeeded()
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
        Task {
            let player =  try await post.createPlayerUser("Blank")
        }
    }
    
    private func createUserIfNeeded() {
        if ud.userID == nil {
            let payload = CreateRequestPayload(name: nil, score: ud.scoreCoints)
            post.createPlayer(payload: payload) { [weak self] createResponse in
                guard let self = self else { return }
                ud.userID = createResponse.id
            } errorCompletion: { error in
                print("Ошибка получени данных с бека")
            }
        }
    }
    
    private func checkToken() {
        guard let token = auth.token else {
            return
        }
    }
}
