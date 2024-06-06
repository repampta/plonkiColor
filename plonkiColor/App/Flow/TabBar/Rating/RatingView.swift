//
//  RatingView.swift

import Foundation
import UIKit
import SnapKit

class RatingView: UIView {
    
    private (set) var view: UIView = {
        let view = UIImageView()
        view.backgroundColor = .systemPink
        return view
    }()
    
    private (set) var bgImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .bgHome
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

  

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {

        [view, bgImage] .forEach(addSubview(_:))

    }
    
    private func setupConstraints() {
        
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

    }
}
