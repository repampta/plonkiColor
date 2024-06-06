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
    
    private func tappedButtons() {
        contentView.chosePhotoBtn.addTarget(self, action: #selector(goTakePhoto), for: .touchUpInside)
        contentView.editBtn.addTarget(self, action: #selector(tappeUpdateName), for: .touchUpInside)
        contentView.infoBtn.addTarget(self, action: #selector(pushInfo), for: .touchUpInside)
        contentView.rateBtn.addTarget(self, action: #selector(tappedRateUs), for: .touchUpInside)
        contentView.writeBtn.addTarget(self, action: #selector(pushInfo), for: .touchUpInside)

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
        if contentView.editBtn.backgroundImage(for: .normal) == UIImage(named: "checkBtn") {
            view.endEditing(true)
            isTextFieldTapped = false
            contentView.editBtn.setBackgroundImage(UIImage(named: "editBtn"), for: .normal)
        } else {
            contentView.profileTextField.becomeFirstResponder()
            
            contentView.editBtn.setBackgroundImage(UIImage(named: "tappedWriteUs"), for: .normal)
            
            isTextFieldTapped = true
        }
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
