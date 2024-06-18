//
//  BonusView.swift

import Foundation
import UIKit
import SnapKit

class BonusView: UIView {
    
    private var storage = Memory.shared
    let segmentValues = [0, 1, 2, 3, 4, 5]
    private  var corners: [CircleView] = []
    private  let count = 6
    private let colors: [UIColor] = [.clear, .clear, .clear, .clear, .clear, .clear]
    
    private(set) var bonusView: UIView = {
        let view = UIView()
        return view
    }()
    
    private (set) var bgImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .bgClassic
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
        let label = UILabel.createLabel(withText: "Daily bonus", font: .customFont(font: .kleeOne, style: .semiBold, size: 36), textColor: .cGradOne, lineHeightMultiple: 0.83)
        return label
    }()
    
    private var subTitleLabel: UILabel = {
        let label = UILabel.createLabel(withText: "Turn the wheel to receive\nyour daily bonus!", font: .customFont(font: .chivo, style: .regular, size: 18), textColor: .cLight, lineHeightMultiple: 1)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private(set) lazy var circleContainer: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        return view
    }()

    private(set) lazy var centerBonusImg: UIImageView = {
        let image = UIImageView()
        image.image = .imgPointer
        return image
    }()


    private(set) lazy var bonzaImg: UIImageView = {
        let image = UIImageView()
        image.image = .imgFortuneWheel
        return image
    }()
    
    private(set) lazy var selectImageView: UIImageView = {
        let image = UIImageView()
        image.image = .pointerImg
        return image
    }()
    
    private(set) var btnGetBonus: UIButton = {
        let btn = UIButton()
        btn.configureButton(withTitle: "get bonus".uppercased(), font: .customFont(font: .kleeOne, style: .semiBold, size: 24), titleColor: .cDarkPurple, normalImage: .btnActivity, highlightedImage: .btnActivityTapped)
        return btn
    }()
    
    private(set) var timerView: UIView = {
        let view = UIView()
        view.isHidden = true
        return view
    }()
    
    private (set) var timerBgImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .bgClassic
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private (set) var timerImg: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .imgTime
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private (set) var timerTitleLabel: UILabel = {
        let label = UILabel.createLabel(withText: "Daily bonus", font: .customFont(font: .kleeOne, style: .semiBold, size: 36), textColor: .cGradOne, lineHeightMultiple: 0.83)
        return label
    }()
    
    private (set) var timerSubTitleLabel: UILabel = {
        let label = UILabel.createLabel(withText: "The bonus will be available through", font: .customFont(font: .chivo, style: .regular, size: 16), textColor: .cLight, lineHeightMultiple: 1)
        return label
    }()
    
    private (set) var timerCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .cGradOne
        label.font = .customFont(font: .chivo, style: .black, size: 24)
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
//        bonusView.addSubview(selectImageView)
        bonusView.addSubview(centerBonusImg)
        circleContainer.addSubview(bonzaImg)

        addSubview(timerView)
        timerView.addSubview(timerBgImage)
        timerView.addSubview(timerImg)
        timerView.addSubview(timerTitleLabel)
        timerView.addSubview(timerSubTitleLabel)
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
        
        circleContainer.snp.makeConstraints { make in
            make.width.equalTo(977.autoSize)
            make.height.equalTo(977.autoSize)
            make.centerX.equalToSuperview()
            make.centerY.equalTo(safeAreaLayoutGuide.snp.top).offset(80)
        }
        
        centerBonusImg.snp.makeConstraints { make in
            make.centerX.equalTo(bonzaImg)
            make.centerY.equalTo(bonzaImg).offset(40)
            make.height.equalTo(158)
            make.width.equalTo(84)
        }
        
        bonzaImg.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }

        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(circleContainer.snp.bottom).offset(-84)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
        }
        
        btnGetBonus.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.equalTo(subTitleLabel.snp.bottom).offset(20)
        }
        
        timerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        timerBgImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        timerImg.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(24)
        }
        
        timerTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(timerImg.snp.bottom).offset(24)
        }
        
        timerSubTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(timerTitleLabel.snp.bottom).offset(24)
        }
        
        timerCountLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(timerSubTitleLabel.snp.bottom).offset(24)
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
