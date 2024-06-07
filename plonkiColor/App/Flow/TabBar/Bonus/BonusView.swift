//
//  BonusView.swift

import Foundation
import UIKit
import SnapKit

class BonusView: UIView {
    
    private var storage = Memory.shared
    let segmentValues = [0, 1, 2, 3, 4, 5, 6, 7]
    private  var corners: [CircleView] = []
    private  let count = 8
    private let colors: [UIColor] = [.red, .white, .yellow, .cyan, .brown, .green, .systemPink, .purple]
    
    private(set) var bonusView: UIView = {
        let view = UIView()
        return view
    }()
    
    private (set) var bgImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .bgHome
        imageView.clipsToBounds = true
        return imageView
    }()

  
    private(set) lazy var containerStack: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.alignment = .center
    stackView.spacing = 0
    return stackView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "daily bonus".uppercased()
        label.font = .systemFont(ofSize: 36)
        label.textAlignment = .center
        return label
    }()
    
    private var subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Turn the wheel to receive your daily bonus!"
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    private(set) lazy var circleContainer: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        return view
    }()

    private(set) lazy var centerBonusImg: UIImageView = {
        let image = UIImageView()
        image.image = .centerBonusImg
        return image
    }()


    private(set) lazy var bonzaImg: UIImageView = {
        let image = UIImageView()
        image.image = .circleBonzaImg
        return image
    }()
    
    private(set) lazy var selectImageView: UIImageView = {
        let image = UIImageView()
        image.image = .pointerImg
        return image
    }()
    
    private(set) var btnGetBonus: UIButton = {
        let btn = UIButton()
        btn.setImage(.btnGetBonus, for: .normal)
        btn.setImage(.tappedGetBonus, for: .highlighted)
        return btn
    }()
    
    private(set) var timerView: UIView = {
        let view = UIView()
        view.isHidden = true
        return view
    }()
    
    private (set) var timerBgImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .bgHome
        imageView.clipsToBounds = true
        return imageView
    }()

  
    private(set) lazy var timerContainerStack: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.alignment = .center
    stackView.spacing = 0
    return stackView
    }()
    
    private (set) var timerImg: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .timerImg
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private (set) var timerTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Time to next bonus"
        label.font = .systemFont(ofSize: 36)
        label.textAlignment = .center
        return label
    }()
    
    private (set) var timerCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 24)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupWheel()
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(bonusView)
        bonusView.addSubview(bgImage)
        bonusView.addSubview(containerStack)
        bonusView.addSubview(titleLabel)
        bonusView.addSubview(subTitleLabel)
        bonusView.addSubview(btnGetBonus)
        bonusView.addSubview(circleContainer)
        bonusView.addSubview(selectImageView)
        bonusView.addSubview(centerBonusImg)
        circleContainer.addSubview(bonzaImg)

        addSubview(timerView)
        timerView.addSubview(timerBgImage)
        timerView.addSubview(timerContainerStack)
        timerView.addSubview(timerImg)
        timerView.addSubview(timerTitleLabel)
        timerView.addSubview(timerCountLabel)

    }
    
    private func setupConstraints() {
     
        bonusView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        bgImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerStack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(containerStack.snp.bottom).offset(32)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom)
        }
        
        circleContainer.snp.makeConstraints { make in
            make.width.equalTo(400.autoSize)
            make.height.equalTo(400.autoSize)
            make.centerX.equalToSuperview()
            make.top.equalTo(subTitleLabel.snp.bottom).offset(24)
        }
        
        centerBonusImg.snp.makeConstraints { make in
            make.center.equalTo(bonzaImg)
            make.size.equalTo(164.autoSize)
        }
        
        bonzaImg.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }

        selectImageView.snp.makeConstraints { (make) in
            make.top.equalTo(bonzaImg.snp.top).offset(12)
            make.centerX.equalToSuperview()
            make.width.equalTo(40.autoSize)
            make.height.equalTo(60.autoSize)
        }
        
        btnGetBonus.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(48)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-40)
        }
        
        timerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        timerBgImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        timerContainerStack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
        }
        
        timerImg.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(timerContainerStack.snp.bottom).offset(40)
        }
        
        timerTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(timerImg.snp.bottom).offset(60)
        }
        
        timerCountLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(timerTitleLabel.snp.bottom)
        }
        
    }
    
    private func setupWheel() {
        for index in 0..<count {
            let corner = CircleView(startAngle: CGFloat(Double(index) / Double(count) * 2 * Double.pi),
                                 endAngle: CGFloat(Double(index + 1) / Double(count) * 2 * Double.pi),
                                 color: colors[index % colors.count])
            circleContainer.addSubview(corner)
            corners.append(corner)
        }
        corners.forEach { corner in
            corner.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(10)
            }
        }
    }
}
