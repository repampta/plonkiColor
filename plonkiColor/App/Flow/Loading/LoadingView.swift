//
//  LoadingView.swift

import Foundation
import UIKit
import SnapKit

class LoadingView: UIView {
    
    private (set) var bgImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .bgLoad
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private (set) var titleLabel: UILabel = {
        let label = UILabel.createLabel(withText: "Hello to Ball Color", font: .customFont(font: .kleeOne, style: .semiBold, size: 28), textColor: .cLight, lineHeightMultiple: 0.83)
        return label
    }()
    
    private (set) var loadView: UIView = {
        let view = UIView()
        view.backgroundColor = .cDarkPurple
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.cGradOne.cgColor
        return view
    }()

    private(set) lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.progress = 0.0
        progressView.progressTintColor = .clear
        progressView.layer.cornerRadius = 8
        progressView.clipsToBounds = true
        return progressView
    }()

    private let gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.cGradOne.cgColor, UIColor.cGradTwo.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        return gradient
    }()
    
    private let gradientMaskLayer: CALayer = {
         let maskLayer = CALayer()
         maskLayer.backgroundColor = UIColor.black.cgColor
         return maskLayer
     }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        setupGradient()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {

        [bgImage, titleLabel, loadView] .forEach(addSubview(_:))
        loadView.addSubview(progressView)

    }
    
    private func setupConstraints() {
        bgImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loadView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(16)
            make.width.equalTo(280)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-120)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(loadView.snp.top).offset(-24)
        }
        progressView.snp.makeConstraints { make in
            make.left.equalTo(loadView.snp.left)   // Закрепите левую границу к левой границе loadView
            make.right.equalTo(loadView.snp.right) // Закрепите правую границу к правой границе loadView
            make.centerY.equalTo(loadView.snp.centerY) // Выровнять по центру loadView по вертикали
            make.height.equalTo(loadView.snp.height)   // Установить высоту равной высоте loadView
        }
    }
    
    private func setupGradient() {
          gradientLayer.frame = progressView.bounds
          gradientLayer.mask = gradientMaskLayer
          progressView.layer.insertSublayer(gradientLayer, at: 0)
      }

      override func layoutSubviews() {
          super.layoutSubviews()
          gradientLayer.frame = progressView.bounds
          updateGradientMask()
      }
      
    func updateGradientMask() {
        let maskWidth = CGFloat(progressView.progress) * progressView.bounds.width
        gradientMaskLayer.frame = CGRect(x: 0, y: 0, width: maskWidth, height: progressView.bounds.height)
    }

    func animateGradient() {
        let animation = CABasicAnimation(keyPath: "bounds.size.width")
        animation.fromValue = 0
        animation.toValue = progressView.bounds.width
        animation.duration = 1.5
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        gradientMaskLayer.add(animation, forKey: "bounds.size.width")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.gradientMaskLayer.frame = CGRect(x: 0, y: 0, width: self.progressView.bounds.width, height: self.progressView.bounds.height)
        }
    }
}
