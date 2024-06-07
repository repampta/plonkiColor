
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
        return iv
    }()
    
    private(set) lazy var customImageView2: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private(set) lazy var customImageView3: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private(set) lazy var firstLabel1: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private(set) lazy var firstLabel2: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private(set) lazy var firstLabel3: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private(set) lazy var secondLabel1: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private(set) lazy var secondLabel2: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private(set) lazy var secondLabel3: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
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
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(110)
            make.height.equalTo(175)
        }
        
        secondContainer.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.right.equalTo(firstContainer.snp.left).offset(-10)
            make.width.equalTo(86)
            make.height.equalTo(144)
        }
        
        thirdContainer.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalTo(firstContainer.snp.right).offset(10)
            make.width.equalTo(86)
            make.height.equalTo(144)
        }
        
        setupContainer(firstContainer, imageView: customImageView1, firstLabel: firstLabel1, secondLabel: secondLabel1)
        setupContainer(secondContainer, imageView: customImageView2, firstLabel: firstLabel2, secondLabel: secondLabel2)
        setupContainer(thirdContainer, imageView: customImageView3, firstLabel: firstLabel3, secondLabel: secondLabel3)
    }
    
    private func setupContainer(_ container: UIView, imageView: UIImageView, firstLabel: UILabel, secondLabel: UILabel) {
        container.addSubview(imageView)
        container.addSubview(firstLabel)
        container.addSubview(secondLabel)
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(120)
        }
        
        firstLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
        }
        
        secondLabel.snp.makeConstraints { make in
            make.top.equalTo(firstLabel.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
        }
    }
}
