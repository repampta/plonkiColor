
import UIKit
import SnapKit

class CustomRatingCell: UITableViewCell {
    
    static let reuseId = String(describing: CustomRatingCell.self)
    
    private(set) lazy var firstContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    private(set) lazy var secondContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    private(set) lazy var thirdContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    private(set) lazy var customImageView1: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.shadowColor = UIColor.yellow.withAlphaComponent(0.8).cgColor
        iv.layer.shadowOpacity = 1
        iv.layer.shadowRadius = 10
        iv.layer.shadowOffset = CGSize(width: 0, height: 0)
        return iv
    }()
    
    private(set) lazy var customImageScore1: UIImageView = {
        let iv = UIImageView()
        iv.image = .imgCoint
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private(set) lazy var customImageView2: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private(set) lazy var customImageScore2: UIImageView = {
        let iv = UIImageView()
        iv.image = .imgCoint
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private(set) lazy var customImageView3: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private(set) lazy var customImageScore3: UIImageView = {
        let iv = UIImageView()
        iv.image = .imgCoint
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private(set) lazy var firstLabel1: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .cGradOne
        label.font = .customFont(font: .chivo, style: .black, size: 24)
        return label
    }()
    
    private(set) lazy var firstLabel2: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .cGradOne
        label.font = .customFont(font: .chivo, style: .black, size: 24)
        return label
    }()
    
    private(set) lazy var firstLabel3: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .cGradOne
        label.font = .customFont(font: .chivo, style: .black, size: 24)
        return label
    }()
    
    private(set) lazy var secondLabel1: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .cLight
        label.font = .customFont(font: .chivo, style: .regular, size: 16)
        return label
    }()
    
    private(set) lazy var secondLabel2: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .cLight
        label.font = .customFont(font: .chivo, style: .regular, size: 16)
        return label
    }()
    
    private(set) lazy var secondLabel3: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .cLight
        label.font = .customFont(font: .chivo, style: .regular, size: 16)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear
        
        contentView.addSubview(firstContainer)
        contentView.addSubview(secondContainer)
        contentView.addSubview(thirdContainer)
        
        firstContainer.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-16)
            make.centerX.equalToSuperview()
            make.width.equalTo(110)
            make.height.equalTo(190)
        }
        
        secondContainer.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.right.equalTo(firstContainer.snp.left).offset(-20)
            make.width.equalTo(94)
            make.height.equalTo(154)
        }
        
        thirdContainer.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalTo(firstContainer.snp.right).offset(20)
            make.width.equalTo(94)
            make.height.equalTo(154)
        }
        
        setupContainer(firstContainer, imageView: customImageView1, imageScore: customImageScore1, firstLabel: firstLabel1, secondLabel: secondLabel1)
        setupContainer(secondContainer, imageView: customImageView2, imageScore: customImageScore2, firstLabel: firstLabel2, secondLabel: secondLabel2)
        setupContainer(thirdContainer, imageView: customImageView3, imageScore: customImageScore3, firstLabel: firstLabel3, secondLabel: secondLabel3)
    }
    
    private func setupContainer(_ container: UIView, imageView: UIImageView, imageScore: UIImageView, firstLabel: UILabel, secondLabel: UILabel) {
        container.addSubview(imageView)
        container.addSubview(imageScore)
        container.addSubview(firstLabel)
        container.addSubview(secondLabel)
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(120)
        }
        
        imageScore.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(4)
            make.left.equalToSuperview()
            make.size.equalTo(32)
        }
        
        firstLabel.snp.makeConstraints { make in
            make.left.equalTo(imageScore.snp.right).offset(2)
            make.centerY.equalTo(imageScore)
        }
        
        secondLabel.snp.makeConstraints { make in
            make.top.equalTo(imageScore.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
        }
    }
}
