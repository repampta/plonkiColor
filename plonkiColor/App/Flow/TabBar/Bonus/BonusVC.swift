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
        let sectorAngles: [CGFloat] = [22, 67, 112, 157, 202, 247, 292, 337]

        let randomSectorAngle = sectorAngles.randomElement() ?? 360
        
        let randomRotation = randomSectorAngle * .pi / 180.0
        
        switch randomSectorAngle {
        case 22:
            scoreCounts = contentView.segmentValues[1]
        case 67:
            scoreCounts = contentView.segmentValues[0]
        case 112:
            scoreCounts = contentView.segmentValues[7]
        case 157:
            scoreCounts = contentView.segmentValues[6]
        case 202:
            scoreCounts = contentView.segmentValues[5]
        case 247:
            scoreCounts = contentView.segmentValues[4]
        case 292:
            scoreCounts = contentView.segmentValues[3]
        case 337:
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
//                self.storage.lastBonusDate = Date()
            }
        }
        contentView.circleContainer.layer.add(rotationAnimation, forKey: "rotationAnimation")
        CATransaction.commit()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
            completion?()
        }
    }
    
    private func showResultView() {
        switch scoreCounts {
        case contentView.segmentValues[0]:
            print("Bonus scorePoints 01 - red")
            
        case contentView.segmentValues[1]:
            print("Bonus scorePoints 02 - white")

        case contentView.segmentValues[2]:
            print("Bonus scorePoints 03 -yellow")

        case contentView.segmentValues[3]:
            print("Bonus scorePoints 04 - cyan")


        case contentView.segmentValues[4]:
            print("Bonus scorePoints 05 - brown")


        case contentView.segmentValues[5]:
            print("Bonus scorePoints 06 -green")


        case contentView.segmentValues[6]:
            print("Bonus scorePoints 07 - systemPink")


        case contentView.segmentValues[7]:
            print("Bonus scorePoints 08  - purple")


        default:
            break
        }
    }
    
//    private func presentPrizeView(coint: String, image: UIImage) {
//        if fullScreenView == nil {
//            fullScreenView = UIView(frame: self.view.bounds)
//            fullScreenView!.backgroundColor = .black.withAlphaComponent(0.8)
//            fullScreenView!.alpha = 0
//        
//        let imageView = UIImageView(image: .containerModalImg)
//        imageView.contentMode = .scaleAspectFit
//            fullScreenView!.addSubview(imageView)
//        
//        let titleLabel = UILabel()
//        titleLabel.text = "congratilations!".uppercased()
//        titleLabel.font = .customFont(font: .mitr, style: .semiBold, size: .h3)
//        titleLabel.textColor = .white
//        titleLabel.numberOfLines = 0
//        titleLabel.textAlignment = .center
//        imageView.addSubview(titleLabel)
//        
//        let imageBonusView = UIImageView(image: image)
//        imageBonusView.contentMode = .scaleAspectFit
//        imageView.addSubview(imageBonusView)
//        
//        let countLabel = UILabel()
//        countLabel.text = coint
//        countLabel.font = .customFont(font: .mitr, style: .semiBold, size: .h3)
//        countLabel.textColor = .white
//        countLabel.numberOfLines = 0
//        countLabel.textAlignment = .center
//        imageView.addSubview(countLabel)
//        
//        let backButton = UIButton()
//        backButton.setImage(.btnThanks, for: .normal)
//        backButton.setImage(.tappedThanks, for: .highlighted)
//        backButton.addTarget(self, action: #selector(tappedCloseBonus), for: .touchUpInside)
//            fullScreenView!.addSubview(backButton)
//
//        imageView.snp.makeConstraints { make in
//                make.centerX.equalToSuperview()
//                make.centerY.equalToSuperview().offset(-40)
//            }
//        
//        titleLabel.snp.makeConstraints { make in
//                make.centerX.equalToSuperview()
//                make.top.equalTo(imageView.snp.top).offset(40)
//            }
//        
//        imageBonusView.snp.makeConstraints { make in
//                make.centerX.equalToSuperview()
//                make.top.equalTo(titleLabel.snp.bottom).offset(28)
//                make.size.equalTo(160)
//            }
//        
//        countLabel.snp.makeConstraints { make in
//                make.centerX.equalToSuperview()
//                make.top.equalTo(imageBonusView.snp.bottom)
//            }
//        
//        backButton.snp.makeConstraints { make in
//                make.centerX.equalToSuperview()
//                make.top.equalTo(countLabel.snp.bottom).offset(36)
//            }
//
//        self.view.addSubview(fullScreenView!)
//        }
//    UIView.animate(withDuration: 0.5, animations: {
//        self.fullScreenView!.alpha = 1
//    })
//    }
    
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

