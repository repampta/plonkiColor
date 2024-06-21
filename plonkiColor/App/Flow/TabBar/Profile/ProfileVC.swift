//
//  ProfileVC.swift


import Foundation
import UIKit
import SnapKit
import MessageUI
import StoreKit


class ProfileVC: UIViewController, MFMailComposeViewControllerDelegate {
    
    private var isTextFieldTapped = false
    private let imagePicker = UIImagePickerController()
    private let memory = Memory.shared
    private let appID = "123456789"
    private var fullScreenView: UIView?

    var contentView: ProfileView {
        view as? ProfileView ?? ProfileView()
    }
    
    override func loadView() {
        view = ProfileView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerDelegate()
        tappedButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkAchi()
    }
    
    
    private func checkAchi() {
        contentView.achiOneImg.alpha = Memory.shared.colorNovice ? 1.0 : 0.5
        contentView.achiTwoImg.alpha = Memory.shared.patternExplorer ? 1.0 : 0.5
        contentView.achiThreeImg.alpha = Memory.shared.colorApprentice ? 1.0 : 0.5
        contentView.achiFourImg.alpha = Memory.shared.harmoniousMastery ? 1.0 : 0.5

    }
    
    private func tappedButtons() {
        contentView.chosePhotoBtn.addTarget(self, action: #selector(goTakePhoto), for: .touchUpInside)
        contentView.editBtn.addTarget(self, action: #selector(tappeUpdateName), for: .touchUpInside)
        contentView.infoBtn.addTarget(self, action: #selector(pushInfo), for: .touchUpInside)
        contentView.rateBtn.addTarget(self, action: #selector(tappedRateUs), for: .touchUpInside)
        contentView.writeBtn.addTarget(self, action: #selector(tappedWriteUs), for: .touchUpInside)
        
        let achiOneTap = UITapGestureRecognizer(target: self, action: #selector(tappedAchiOne))
        contentView.achiOneView.addGestureRecognizer(achiOneTap)
        contentView.achiOneView.isUserInteractionEnabled = true
        
        let achiTwoTap = UITapGestureRecognizer(target: self, action: #selector(tappedAchiTwo))
        contentView.achiTwoView.addGestureRecognizer(achiTwoTap)
        contentView.achiTwoView.isUserInteractionEnabled = true
        
        let achiThreeTap = UITapGestureRecognizer(target: self, action: #selector(tappedAchiThree))
        contentView.achiThreeView.addGestureRecognizer(achiThreeTap)
        contentView.achiThreeView.isUserInteractionEnabled = true
        
        let achiFourTap = UITapGestureRecognizer(target: self, action: #selector(tappedAchiFour))
        contentView.achiFourView.addGestureRecognizer(achiFourTap)
        contentView.achiFourView.isUserInteractionEnabled = true
    }
    
    @objc private func tappedAchiOne() {
        presentModalView(title: "Color Novice", subtitle: "Unravel the first gradient", image: .imgViewAchiOne)
      }
    
    @objc private func tappedAchiTwo() {
        presentModalView(title: "Pattern Explorer", subtitle: "Complete the first chapter", image: .imgViewAchiTwo)
      }
    
    @objc private func tappedAchiThree() {
        presentModalView(title: "Color Apprentice", subtitle: "Solve the first 5 levels\nof the first chapter", image: .imgViewAchiTwo)
      }
    
    @objc private func tappedAchiFour() {
        presentModalView(title: "Harmonious Mastery", subtitle: "Get all the achievements in the game", image: .imgViewAchiTwo)

      }
    
    
    func presentModalView(title: String, subtitle: String, image: UIImage) {
            if fullScreenView == nil {
                fullScreenView = UIView(frame: self.view.bounds)
                fullScreenView!.backgroundColor = .black.withAlphaComponent(0.8)
                fullScreenView!.alpha = 0
                
            let viewConteiner = UIView()
                viewConteiner.backgroundColor = .cDarkPurple
                viewConteiner.layer.cornerRadius = 20
                viewConteiner.layer.borderWidth = 2
                viewConteiner.layer.borderColor = UIColor.cGradOne.cgColor
                viewConteiner.layer.shadowColor = UIColor.cPurple.cgColor
                viewConteiner.layer.shadowOpacity = 1
                viewConteiner.layer.shadowOffset = CGSize(width: 0, height: 0)
                viewConteiner.layer.shadowRadius = 20
                fullScreenView!.addSubview(viewConteiner)
                
            let imageBonusView = UIImageView(image: image)
                imageBonusView.contentMode = .scaleAspectFit
                imageBonusView.layer.shadowColor = UIColor.yellow.withAlphaComponent(0.4).cgColor
                imageBonusView.layer.shadowOpacity = 1
                imageBonusView.layer.shadowOffset = CGSize(width: 0, height: 0)
                imageBonusView.layer.shadowRadius = 44
                viewConteiner.addSubview(imageBonusView)
    
            let titleLabel = UILabel()
                titleLabel.text = title
                titleLabel.font = .customFont(font: .kleeOne, style: .semiBold, size: 32)
                titleLabel.textColor = .cLight
                titleLabel.numberOfLines = 0
                titleLabel.textAlignment = .center
                viewConteiner.addSubview(titleLabel)

            let subtitleLabelView = UILabel()
                subtitleLabelView.text = subtitle
                subtitleLabelView.font = .customFont(font: .chivo, style: .regular, size: 18)
                subtitleLabelView.textColor = .white
                subtitleLabelView.numberOfLines = 0
                subtitleLabelView.textAlignment = .center
                viewConteiner.addSubview(subtitleLabelView)
    
                
            let backButton = UIButton()
                backButton.configureButton(withTitle: "OK", font: .customFont(font: .kleeOne, style: .semiBold, size: 16), titleColor: .cDarkPurple, normalImage: .btnActivity, highlightedImage: .btnActivityTapped)
                backButton.addTarget(self, action: #selector(tappedCloseBuy), for: .touchUpInside)
                fullScreenView!.addSubview(backButton)
    
            viewConteiner.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview()
                make.height.equalTo(460)
                make.width.equalTo(353)
            }
                
            imageBonusView.snp.makeConstraints { make in
                make.centerX.equalTo(viewConteiner)
                make.top.equalToSuperview().offset(40)
                make.size.equalTo(200)
            }
                
            titleLabel.snp.makeConstraints { make in
                make.left.right.equalToSuperview().inset(20)
                make.top.equalTo(imageBonusView.snp.bottom).offset(24)
            }
                
            subtitleLabelView.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(titleLabel.snp.bottom).offset(20)
            }

            backButton.snp.makeConstraints { make in
                make.top.equalTo(subtitleLabelView.snp.bottom).offset(20)
                make.centerX.equalTo(viewConteiner)
                make.height.equalTo(48)
                make.width.equalTo(280)
                }
                
            self.view.addSubview(fullScreenView!)
            }
        UIView.animate(withDuration: 0.5, animations: {
            self.fullScreenView!.alpha = 1
        })
        }

    @objc func tappedCloseBuy() {
        UIView.animate(withDuration: 0.5, animations: {
            self.fullScreenView?.alpha = 0
        }) { _ in
            self.fullScreenView?.removeFromSuperview()
            self.fullScreenView = nil
        }
    }
    
    private func pickerDelegate() {
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
    }
    
    @objc func pushInfo() {
        let infoVC = InfoVC()
        navigationController?.pushViewController(infoVC, animated: true)
    }
    
    @objc func tappeUpdateName() {
        contentView.profileTextField.becomeFirstResponder()
    }
    
    private func checkFotoLoad() {
        if let savedImage = getImageFromLocal() {
            contentView.chosePhotoBtn.setImage(savedImage, for: .normal)
        }
    }
    
    @objc func goTakePhoto() {
        let alert = UIAlertController(title: "Pick Library", message: nil, preferredStyle: .actionSheet)
        
        let actionLibrary = UIAlertAction(title: "Photo Library", style: .default) { _ in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        
        let actionCamera = UIAlertAction(title: "Camera", style: .default) { _ in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.imagePicker.sourceType = .camera
                self.present(self.imagePicker, animated: true, completion: nil)
            } else {
                print("Camera not available")
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(actionCamera)
        alert.addAction(actionLibrary)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
    @objc func tappedRateUs() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            SKStoreReviewController.requestReview(in: windowScene)
        } else {
            if let url = URL(string: "itms-apps://itunes.apple.com/app/id\(appID)?action=write-review") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }


    
    @objc func tappedWriteUs() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["developer@example.com"]) // Replace with your developer email
            mail.setSubject("Feedback on \(Settings.appTitle) App")
            mail.setMessageBody("<p>Dear Developer,</p>", isHTML: true)
            
            present(mail, animated: true)
        } else {
            // Show alert informing the user
            let alert = UIAlertController(title: "Error", message: "Mail services are not available", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
    
    // MARK: - MFMailComposeViewControllerDelegate
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}



extension ProfileVC: UIImagePickerControllerDelegate {
    
    func saveImageToLocal(image: UIImage) {
        if let data = image.jpegData(compressionQuality: 1.0),
            let id  = memory.userID {
            let fileURL = getDocumentsDirectory().appendingPathComponent("\(id).png")
            try? data.write(to: fileURL)
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func getImageFromLocal() -> UIImage? {
        guard let id = memory.userID else { return nil }
        let fileURL = getDocumentsDirectory().appendingPathComponent("\(id).png")
        do {
            let data = try Data(contentsOf: fileURL)
            return UIImage(data: data)
        } catch {
            print("Error loading image from local storage")
            return nil
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            contentView.chosePhotoBtn.setImage(image, for: .normal)
            saveImageToLocal(image: image)
        }
        
        dismiss(animated: true, completion: nil)
    }
  
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension ProfileVC: UINavigationControllerDelegate {
    
}
