//
//  ProgressBarView.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/08/02.
//

import UIKit

import SnapKit

final class YelloProgressBarView: UIView {
    
    private let progressBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .yelloMain500
        return view
    }()
    
    var ratio: CGFloat = 0.2 {
        didSet {
            self.isHidden = !self.ratio.isLess(than: 1.5)
            
            self.progressBarView.snp.remakeConstraints {
                $0.top.bottom.equalTo(self.safeAreaLayoutGuide)
                $0.width.equalToSuperview().multipliedBy(self.ratio)
            }
            
            UIView.animate(
                withDuration: 0.8,
                delay: 0.1,
                options: .curveEaseInOut, // In과 Out 부분을 천천히하라는 의미 (나머지인 중간 부분은 빠르게 진행)
                animations: self.layoutIfNeeded, // autolayout에 애니메이션을 적용시키고 싶은 경우 사용
                completion: nil
            )
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = false
        self.backgroundColor = .black
        self.addSubview(self.progressBarView)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
