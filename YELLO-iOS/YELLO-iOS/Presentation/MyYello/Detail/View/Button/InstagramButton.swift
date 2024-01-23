//
//  InstagramButton.swift
//  YELLO-iOS
//
//  Created by 정채은 on 11/5/23.
//

import UIKit

final class InstagramButton: UIButton {
    
    let instagramImageView = UIImageView()
    let instagramLabel = UILabel()

    // MARK: - Functions
//    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
//        let expandedBounds = bounds.insetBy(dx: -89.adjustedWidth, dy: -84.adjustedHeight)
//        return expandedBounds.contains(point)
//    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        setStyle()
        setLayout()
    }
    
    func setStyle() {
        self.backgroundColor = .btnwhite
        self.makeCornerRound(radius: 20.adjustedHeight)
        
        instagramImageView.do {
            $0.image = ImageLiterals.MyYello.imgInstagram
        }
        
        instagramLabel.do {
            $0.text = StringLiterals.MyYello.Detail.instagram
            $0.font = .uiButton
            $0.textColor = .black
        }
    }
    
    func setLayout() {
        self.addSubviews(instagramImageView,
                         instagramLabel)
        
        self.snp.makeConstraints {
            $0.height.equalTo(40.adjustedHeight)
            $0.width.equalTo(124.adjustedWidth)
        }
        
        instagramImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20.adjustedWidth)
            $0.width.height.equalTo(20.adjusted)
        }
        
        instagramLabel.snp.makeConstraints {
            $0.leading.equalTo(instagramImageView.snp.trailing).offset(4.adjustedWidth)
            $0.centerY.equalToSuperview()
        }
    }
}
