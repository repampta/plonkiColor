//
//  BonusVC.swift

import Foundation
import UIKit
import SnapKit

class BonusVC: UIViewController {
    
    private var fullScreenView: UIView?

    private var isTime: Bool = true
    private let storage = Memory.shared
    private var scoreCounts: Int = 0

    private var contentView: BonusView {
        view as? BonusView ?? BonusView()
    }
    
    override func loadView() {
        view = BonusView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tappedButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        goDailyScreen()
    }
    
    private func tappedButtons() {
        contentView.btnGetBonus.addTarget(self, action: #selector(goButtonTapped), for: .touchUpInside)
    }
    

    @objc func goButtonTapped() {
        spinCircle()
    }
    
   
    private func spinCircle(completion: (() -> Void)? = nil) {
        contentView.btnGetBonus.isEnabled = false
        let sectorAngles: [CGFloat] = [0, 60, 120, 180, 240, 300]

        let randomSectorAngle = sectorAngles.randomElement() ?? 360
        
        let randomRotation = randomSectorAngle * .pi / 180.0
        
        switch randomSectorAngle {
        case 0:
            scoreCounts = contentView.segmentValues[1]
        case 60:
            scoreCounts = contentView.segmentValues[0]
        case 120:
            scoreCounts = contentView.segmentValues[5]
        case 180:
            scoreCounts = contentView.segmentValues[4]
        case 240:
            scoreCounts = contentView.segmentValues[3]
        case 300:
            scoreCounts = contentView.segmentValues[2]
        default:
            break
        }
        
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.toValue = CGFloat.pi * 12 + randomRotation
        rotationAnimation.duration = 3.0
        rotationAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        rotationAnimation.fillMode = .forwards
        rotationAnimation.isRemovedOnCompletion = false
        
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.contentView.btnGetBonus.isEnabled = true
                self.showResultView()
                completion?()
                self.storage.lastBonusDate = Date()
            }
        }
        contentView.circleContainer.layer.add(rotationAnimation, forKey: "rotationAnimation")
        CATransaction.commit()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
            completion?()
        }
    }
    
    func updateScore() {
        let payload = UpdatePayload(name: nil, balance: Memory.shared.scoreCoints)
        PostRequestService.shared.updateData(id: Memory.shared.userID!, payload: payload) { result in
           DispatchQueue.main.async {
               switch result {
               case .success(_):
                   print("Success")
               case .failure(let failure):
                   print("Error - \(failure.localizedDescription)")
               }
           }
       }
   }
    
    private func showResultView() {
        switch scoreCounts {
        case contentView.segmentValues[0]:
            print("Bonus scorePoints 01 - red")
            presentPrizeView(coint: "100")
            Memory.shared.scoreCoints += 100
            updateScore()
            
        case contentView.segmentValues[1]:
            print("Bonus scorePoints 02 - white")
            presentPrizeView(coint: "500")
            Memory.shared.scoreCoints += 500
            updateScore()
            
        case contentView.segmentValues[2]:
            print("Bonus scorePoints 03 -yellow")
            presentPrizeView(coint: "300")
            Memory.shared.scoreCoints += 300
            updateScore()
            
        case contentView.segmentValues[3]:
            print("Bonus scorePoints 04 - cyan")
            presentPrizeView(coint: "200")
            Memory.shared.scoreCoints += 200
            updateScore()
            
        case contentView.segmentValues[4]:
            print("Bonus scorePoints 05 - brown")
            presentPrizeView(coint: "6000")
            Memory.shared.scoreCoints += 6000
            updateScore()
            
        case contentView.segmentValues[5]:
            print("Bonus scorePoints 06 -green")
            presentPrizeView(coint: "400")
            Memory.shared.scoreCoints += 400
            updateScore()
        default:
            break
        }
    }
    
    private func presentPrizeView(coint: String) {
        if fullScreenView == nil {
            fullScreenView = UIView(frame: self.view.bounds)
            fullScreenView!.backgroundColor = .black.withAlphaComponent(0.8)
            fullScreenView!.alpha = 0
        
        let imageView = UIImageView(image: .imgBonusBG)
        imageView.contentMode = .scaleAspectFit
            fullScreenView!.addSubview(imageView)
        
            let titleLabel = UILabel.createLabel(withText: "Congratulations!", font: .customFont(font: .kleeOne, style: .semiBold, size: 36), textColor: .cGradOne, lineHeightMultiple: 0.83)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        imageView.addSubview(titleLabel)
     
            let countLabel = UILabel.createLabel(withText: "You Win +\(coint) points", font: .customFont(font: .chivo, style: .regular, size: 18), textColor: .cLight, lineHeightMultiple: 1)
        countLabel.numberOfLines = 0
        countLabel.textAlignment = .center
        imageView.addSubview(countLabel)
        
        let backButton = UIButton()
            backButton.configureButton(withTitle: "Thanks".uppercased(), font: .customFont(font: .kleeOne, style: .semiBold, size: 24), titleColor: .cDarkPurple, normalImage: .btnActivity, highlightedImage: .btnActivityTapped, kern: 4.8)
        backButton.addTarget(self, action: #selector(tappedCloseBonus), for: .touchUpInside)
            fullScreenView!.addSubview(backButton)

        imageView.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview()
            }
        
        titleLabel.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(imageView.snp.top).offset(80)
            }
            
        backButton.snp.makeConstraints { make in
                make.bottom.equalTo(imageView.snp.bottom).offset(-100)
                make.left.right.equalTo(imageView).inset(76)
            }
            
        countLabel.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
            make.bottom.equalTo(backButton.snp.top).offset(-24)
            }
        
        self.view.addSubview(fullScreenView!)
        }
    UIView.animate(withDuration: 0.5, animations: {
        self.fullScreenView!.alpha = 1
    })
    }
    
    @objc func tappedCloseBonus() {
        UIView.animate(withDuration: 0.5, animations: {
            self.fullScreenView?.alpha = 0
        }) { _ in
            self.fullScreenView?.removeFromSuperview()
            self.fullScreenView = nil
            self.storage.lastBonusDate = Date()
            self.goDailyScreen()
        }
    }
}

extension BonusVC {
    
    func goDailyScreen() {
        if let lastVisitDate = storage.lastBonusDate {
            let calendar = Calendar.current
            if let hours = calendar.dateComponents([.hour], from: lastVisitDate, to: Date()).hour, hours < 24 {
                isTime = true
                contentView.timerView.isHidden = false
                startCountdownTimer()
            } else {
                isTime = false
                contentView.timerView.isHidden = true
            }
        }
    }
    
    func startCountdownTimer() {
        let calendar = Calendar.current
        
        guard let lastVisitDate = storage.lastBonusDate,
              let targetDate = calendar.date(byAdding: .day, value: 1, to: lastVisitDate) else {
            return
        }
        
        let now = Date()
        if now < targetDate {
            let timeRemaining = calendar.dateComponents([.hour, .minute, .second], from: now, to: targetDate)

            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
                guard let self = self else {
                    timer.invalidate()
                    return
                }
                
                let now = Date()
                if now >= targetDate {
                    UserDefaults.standard.set(now, forKey: "LastVisitDate")
                    self.dismiss(animated: true, completion: nil)
                    timer.invalidate()
                } else {
                    let timeRemaining = calendar.dateComponents([.hour, .minute, .second], from: now, to: targetDate)
                    let timeString = String(format: "%02d : %02d : %02d", timeRemaining.hour ?? 0, timeRemaining.minute ?? 0, timeRemaining.second ?? 0)
                    self.contentView.timerCountLabel.text = "\(timeString)"
                }
            }
        } else {
            UserDefaults.standard.set(now, forKey: "LastVisitDate")
        }
    }

}

